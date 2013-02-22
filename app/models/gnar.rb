class Gnar < ActiveRecord::Base
  attr_accessible :user_id, :photo_id
  belongs_to :photo
  belongs_to :user

  validates :photo_id, :uniqueness => { :scope => :user_id }
  validates :photo_id, presence: true
  validates :user_id,  presence: true
end
