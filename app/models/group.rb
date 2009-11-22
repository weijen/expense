require 'digest/sha1'
class Group < ActiveRecord::Base
  belongs_to :owner, :class_name => "User", :foreign_key => :owner_id

  validates_presence_of :name, :short_name
  validates_length_of :name, :minimum => 3

  before_create :set_secret_id

  def to_param
    self.secret_id
  end

  private

  def set_secret_id
    self.secret_id = Digest::SHA1.hexdigest(DateTime.now.to_f.to_s)
  end
end
