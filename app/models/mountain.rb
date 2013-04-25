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
  		:trail_map, :state, :region_id, :slug

  has_many :photos
  has_many :my_mountains, dependent: :destroy
  has_many :users, through: :my_mountains
  has_many :photo_relationships, through: :photos  
  has_many :riders, class_name: 'User', through: :photos
  has_many :photographers, class_name: 'User', through: :photos
  belongs_to :region

  validates :name,	presence: true, length: { maximum: 50 }
  validates :slug, uniqueness: true, presence: true
  before_validation :generate_slug
  
  def to_param
    "#{name}".parameterize
  end

  def generate_slug
    self.slug ||= name.parameterize
  end

  def top_image
  	Photo.find( :first,:select => "photos.*, count(gnars.id) as gnar_count", 
                :joins => "left outer join gnars ON gnars.photo_id = photos.id", 
                :conditions => ["photos.mountain_id = ?",self.id], 
                :order => "gnar_count desc",
                :group => "photos.mountain_id")
    # pics = photos.sort { |x,y| y.gnars.count <=> x.gnars.count }
    # pics.first
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end