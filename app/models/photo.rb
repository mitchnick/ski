class Photo < ActiveRecord::Base
  attr_accessible :name, :description, :camera_type, :lens_type, :aperture, :shutter_speed, :focal_length, 
    :views, :license_attr, :city, :state, :zipcode, :image, :remote_image_url, :image_thumb, :width, :height, 
  	:taken_time, :tag_list, :gear_list, :mountain_id, :image_url, :user_id, :rider_id

  belongs_to :mountain 
  has_many :photo_relationships, dependent: :destroy
  has_many :gnars, dependent: :destroy
  has_many :users, :through => :photo_relationships
  has_many :photographers, class_name: 'User', source: :user, through: :photo_relationships
  has_many :users, :through => :gnars
  has_many :view_counts, dependent: :destroy
  belongs_to :user
  belongs_to :rider, class_name: 'User'

  acts_as_taggable
  acts_as_taggable_on :gear

  validates :mountain, presence: true
  validates :image, :presence => {:unless => "remote_image_url", :message=> "You must enter an image or web link"}
  validates :remote_image_url, :presence => {:message=>"You must enter an image or web link"}, :if => Proc.new { |a| a.image.blank?}
  validates :name, presence: true, length: { maximum: 50 }

  before_create :get_photo_attributes

  mount_uploader :image, ImageUploader

  def most_gnar(photos)
    photos.order(sort { |x,y| y.gnars.count <=> x.gnars.count })
  end

  def view_count_update(current_user, remote_ip)
    if current_user.present? then
      unless ViewCount.where("user_id = ? AND photo_id = ? AND view_date = ?", current_user, self.id, Date.today).exists? then
        new_view = ViewCount.create
        new_view.user = current_user
        new_view.photo = self
        new_view.view_date = Date.today
        new_view.save
        self.increment(:views, by = 1)
        self.save
      end
    else
      unless ViewCount.where("ip_address = ? AND photo_id = ? AND view_date = ?", remote_ip, self.id, Date.today).exists? then
        new_view = ViewCount.create
        new_view.ip_address = remote_ip
        new_view.photo = self
        new_view.view_date = Date.today
        new_view.save
        self.increment(:views, by = 1)
        self.save
      end
    end
  end
  
  def get_photo_attributes
    if EXIFR::JPEG.new('IMG_6841.JPG').exif? then 
      exif = EXIFR::JPEG.new(image.file.file)
      self.width = exif.width
      self.height = exif.height
      self.camera_type = exif.model
      self.aperture = exif.f_number.to_f
      self.shutter_speed = exif.exposure_time.to_s
      self.focal_length = exif.focal_length.to_f
      self.taken_time = exif.date_time
      # self.gps_lat = 
      # self.gps_lng
      # self.lens_type =      
      # self.iso = exif.iso_speed_ratings
    end
  end

  def exif_data?
    if self.camera_type.length > 0 || self.aperture.length > 0 || self.focal_length.length > 0 || self.shutter_speed.length > 0 then true else false end
  end

end

# == Schema Information
#
# Table name: photos
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  creator           :integer
#  photographer      :integer
#  rider             :integer
#  mountain_id       :integer
#  mountain_fat      :string(255)
#  camera_type       :string(255)
#  lens_type         :string(255)
#  aperture          :string(255)
#  shutter_speed     :string(255)
#  focal_length      :string(255)
#  views             :integer
#  license_attr      :string(255)
#  url               :string(255)
#  current_path      :string(255)
#  identifier        :string(255)
#  city              :string(255)
#  state             :string(255)
#  zipcode           :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  image             :string(255)
#  description       :text
#  image_thumb       :string(255)
#  image_max_width   :string(255)
#  width             :string(255)
#  height            :string(255)
#  taken_time        :date
#  admin_description :text
#

