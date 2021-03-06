require 'digest/sha1'
class Group < ActiveRecord::Base
  has_many :user_group_relations
  has_many :users, :through => :user_group_relations
  has_many :tag_group_relations
  has_many :tags, :through => :tag_group_relations
  has_many :expenses

  STATE=["alive", "frozen"] 

  validates_presence_of :name, :short_name
  validates_length_of :name, :within => 3..40
  validates_length_of :short_name, :within => 3..40
  validates_format_of :url, :with => /^(http|https|ftp):\/\/.*/, :if => Proc.new { |group| !group.url.blank? }

  before_create :set_secret_id

  named_scope :approved_groups, :include=> :user_group_relations, :conditions => ["user_group_relations.approved = ?", true], :order => "groups.created_at DESC"
  named_scope :unapprove_groups, :include => :user_group_relations, :conditions => ["user_group_relations.approved = ?", false], :order => "groups.created_at DESC"
  named_scope :managed_groups, :include => :user_group_relations, :conditions => ["user_group_relations.manager = ?", true], :order => "groups.created_at DESC"
  named_scope :alive, :conditions => "state = 'alive'"

  def to_param
    self.secret_id
  end

  # Get group users
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
    self.users.unapprove_users
  end

  #Add user or remove a joined user 
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

  def remove_joined_user(user)
    ugr = self.user_group_relations.find_by_user_id(user.id)
    ugr.destroy if ugr
  end

  # get report
  
  def users_report(start_date = Date.parse("2009-01-01"), end_date = Date.today)
    self.approved_users.map do |user|
      [user.login, user.expenses.by_group(self).during(start_date, end_date).total]
    end
  end

  def tags_report(start_date = Date.parse("2009-01-01"), end_date = Date.today)
    self.tags.map do |tag|
      [tag.name, self.expenses.by_tag(tag).during(start_date, end_date).total]
    end
  end

  #for state
  
  def set_freeze
    update_attribute(:state, "frozen")
  end
  
  def set_alive
    update_attribute(:state, "alive")
  end

  def frozen?
    return true if self.state == 'frozen'

    false
  end

  def alive?
    return true if self.state == 'alive'

    false
  end

  private

  def set_secret_id
    self.secret_id = Digest::SHA1.hexdigest(Time.now.to_f.to_s)
  end
end

# == Schema Information
#
# Table name: groups
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  short_name        :string(255)
#  secret_id         :string(255)
#  owner_id          :integer
#  created_at        :datetime
#  updated_at        :datetime
#  state             :string(255)     default("alive")
#  froze_before_date :date
#  url               :string(255)
#  description       :text
#

