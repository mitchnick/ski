# == Schema Information
#
# Table name: mountains
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  gps_lat      :string(255)
#  gps_lon      :string(255)
#  description  :text
#  phone        :string(255)
#  web_link     :string(255)
#  tickets_link :string(255)
#  trail_map    :string(255)
#  region       :string(255)
#  state        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Mountain < ActiveRecord::Base
  attr_accessible :name, :gps_lat, :gps_lon, :description, :phone, :web_link, :tickets_link, 
  		:trail_map, :region, :state

  has_many :photos

  validates :name, 	presence: true, length: { maximum: 50 }
  

end
