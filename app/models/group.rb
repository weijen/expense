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

  private

  def set_secret_id
    self.secret_id = Digest::SHA1.hexdigest(DateTime.now.to_f.to_s)
  end
end
