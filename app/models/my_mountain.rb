class MyMountain < ActiveRecord::Base
  attr_accessible :user, :mountain, :type, :user_id, :mountain_id
  belongs_to :user
  belongs_to :mountain
  self.inheritance_column = nil

  validates :mountain_id, :uniqueness => { :scope => [:user_id, :type] }
  validates :mountain_id, presence: true
  validates :user_id,  		presence: true
  validates :type,				presence: true

  # type: 0 = Want to go
  # type: 1 = Have Been
  # type: 2 = My Home Mountain
end
