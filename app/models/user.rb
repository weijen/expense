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
#  locale                    :string(255)     default("zh-TW")
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

  has_many :user_group_relations
  has_many :groups, :through => :user_group_relations
  has_many :expenses
  has_many :tags

  named_scope :approved_users, :include=> :user_group_relations, :conditions => ["user_group_relations.approved = ?", true]
  named_scope :unapprove_users, :include => :user_group_relations, :conditions => ["user_group_relations.approved = ?", false]
  named_scope :managers,  :include => :user_group_relations, :conditions => ["user_group_relations.manager = ?", true]

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :locale



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
    urg.manager if urg
  end

  def approved?(group)
    urg = self.user_group_relations.find_by_group_id(group.id) 
    urg.approved if urg
  end

  def approved_but_not_manager?(group)
    urg = self.user_group_relations.find_by_group_id(group.id) 
    (urg.approved && !urg.manager) if urg
  end

  def join?(group)
    self.user_group_relations.find_by_group_id(group.id)
  end

  def unapprove?(group)
    urg = self.user_group_relations.find_by_group_id(group.id)
    !urg.approved  if urg
  end

  def not_join?(group)
    !self.user_group_relations.find_by_group_id(group.id)
  end

  # show brief info
  
  def to_brief_info
    return "#{login}(#{name})"
  end
  
  protected
end
