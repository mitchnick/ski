class ViewCount < ActiveRecord::Base
	attr_accessible 	:ip_address, :user_id, :photo_id, :view_date
	belongs_to :user
	belongs_to :photo

	validates :user_id, :presence => {:unless => "ip_address"}
	validates :photo_id, presence: true
end