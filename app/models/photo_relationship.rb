class PhotoRelationship < ActiveRecord::Base
	attr_accessible :photo_id, :user_id, :role_id
	belongs_to :photo
	belongs_to :user

	validates :photo_id, presence: true
	validates :user_id, presence: true
	validates :role_id, presence: true

	# Creator: 0 = role_id
	# Photographer: 1 = role_id
	# Rider: 2 = role_id

end




