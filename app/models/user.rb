# == Schema Information
#
# Table name: users
#
#  id                        :integer         not null, primary key
#  login                     :string(40)
#  name                      :string(100)     default("")
#  email                     :string(100)
#  crypted_password          :string(40)
#  salt                      :string(40)
#  created_at                :datetime
#  updated_at                :datetime
#  remember_token            :string(40)
#  remember_token_expires_at :datetime
#

require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  
  has_many :own_groups, :class_name => "Group", :foreign_key => :owner_id
  has_many :user_group_relations
  has_many :groups, :through => :user_group_relations
  has_many :expenses
  has_many :tags

  named_scope :proven, :include=> :user_group_relations, :conditions => ["user_group_relations.proven == ?", true]
  named_scope :unproven, :include => :user_group_relations, :conditions => ["user_group_relations.proven == ?", false]
  named_scope :owner,  :include => :user_group_relations, :conditions => ["user_group_relations.manager == ?", true]

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  # check position for group
  def manager?(group)
    urg = self.user_group_relations.find_by_group_id(group.id) 
    urg.manager
  end

  def proven?(group)
    urg = self.user_group_relations.find_by_group_id(group.id) 
    urg.proven
  end

  def follow?(group)
    urg = self.user_group_relations.find_by_group_id(group.id)
  end

  def position(group)
    case
    when self.manager?(group)
      return "manager"
    when !self.manager?(group) && self.follow?(group)
      return "follower"
    when !self.manager?(group) && self.follow?(group)
      return "unproven"
    end
  end
  protected
end
