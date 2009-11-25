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

  validates_presence_of :name, :short_name
  validates_length_of :name, :minimum => 3

  before_create :set_secret_id

  named_scope :proven, :include=> :user_group_relations, :conditions => ["user_group_relations.proven == ?", true]
  named_scope :unproven, :include => :user_group_relations, :conditions => ["user_group_relations.proven == ?", false]

  def to_param
    self.secret_id
  end

  def owners
    self.users.owner
  end

  def add_manager(user)
    unless self.users.include?(user)
      ugr = self.user_group_relations.new(:user_id => user.id)
    else
      ugr = self.user_group_relations.find_by_user_id(user.id)
    end
    ugr.proven = true
    ugr.manager = true
    ugr.save
  end

  def add_follower(user)
    unless self.users.include?(user)
      ugr = self.user_group_relations.new(:user_id => user.id)
    else
      ugr = self.user_group_relations.find_by_user_id(user.id)
    end
    ugr.proven = true
    ugr.save
  end 

  private

  def set_secret_id
    self.secret_id = Digest::SHA1.hexdigest(DateTime.now.to_f.to_s)
  end
end
