# == Schema Information
#
# Table name: groups
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  short_name :string(255)
#  secret_id  :string(255)
#  owner_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'digest/sha1'
class Group < ActiveRecord::Base
  has_many :user_group_relations
  has_many :users, :through => :user_group_relations
  has_many :tag_group_relations
  has_many :tags, :through => :tag_group_relations
  has_many :expenses

  validates_presence_of :name, :short_name
  validates_length_of :name, :within => 3..40
  validates_length_of :short_name, :within => 3..40

  before_create :set_secret_id

  named_scope :approved_groups, :include=> :user_group_relations, :conditions => ["user_group_relations.approved == ?", true]
  named_scope :unprove_groups, :include => :user_group_relations, :conditions => ["user_group_relations.approved == ?", false]

  def to_param
    self.secret_id
  end

  def managers
    self.users.managers
  end

  def approved_users_but_not_manager
    self.users.approved_users - self.users.managers
  end

  def approved_users
    self.users.approved_users
  end

  def unapprove_users
    self.users.unprove_users
  end

  def add_manager(user)
    unless self.users.include?(user)
      ugr = self.user_group_relations.new(:user_id => user.id)
    else
      ugr = self.user_group_relations.find_by_user_id(user.id)
    end
    ugr.approved = true
    ugr.manager = true
    ugr.save
  end

  def add_approved_user(user)
    unless self.users.include?(user)
      ugr = self.user_group_relations.new(:user_id => user.id)
    else
      ugr = self.user_group_relations.find_by_user_id(user.id)
    end
    ugr.approved = true
    ugr.save
  end 

  def add_unapprove_user(user)
    self.user_group_relations.create(:user_id => user.id) unless self.user_group_relations.find_by_user_id(user.id)
  end

  def remove_follower(user)
    ugr = self.user_group_relations.find_by_user_id(user.id)
    ugr.destroy if ugr
  end

  private

  def set_secret_id
    self.secret_id = Digest::SHA1.hexdigest(DateTime.now.to_f.to_s)
  end
end
