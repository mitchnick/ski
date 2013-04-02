class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :token_authenticatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible 	:first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :bio, 
  					:home_mountain, :home_town, :terms, :email_opt_in, :photo, :confirmed_at, :current_password, 
            :mountain_id, :provider, :uid
  # attr_accessible :title, :body

  mount_uploader :photo, AvatarUploader
  
  has_many :photo_relationships
  has_many :my_mountains, dependent: :destroy
  has_many :gnars,  dependent: :destroy
  has_many :relationship_photos, class_name: 'Photo', source: :photo, through: :photo_relationships
  has_many :gnar_photos, class_name: 'Photo', source: :photo, :through => :gnars
  has_many :mountains, :through => :my_mountains
  has_many :views, dependent: :destroy

  validates_presence_of :first_name, :last_name
  
  before_save :terms_agree

  def name 
    self.first_name + " " + self.last_name
  end

  def has_been_to(mountain)
    mymountain = my_mountains.build
    mymountain.type = MyMountainRole::HAVEBEEN
    mymountain.user = self
    mymountain.mountain = mountain
    mymountain.save
  end

  def wants_to_go(mountain)
    mymountain = my_mountains.build
    mymountain.type = MyMountainRole::WANTTOGO
    mymountain.user = self
    mymountain.mountain = mountain
    mymountain.save
  end

  def create_relationship(photo, role_id)
    relationship = photo_relationships.build
    relationship.photo = photo
    relationship.user = self
    relationship.role_id = role_id
    relationship.save
  end

  def give_gnar(photo)
    gnar = gnars.build
    gnar.photo = photo
    gnar.user = self
    gnar.save
  end

  def take_back_gnar(gnar)
    gnar.destroy
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    # user = User.where(:email => auth.email).first()
    unless user
      user = User.create(first_name:auth.info.first_name,
                           last_name:auth.info.last_name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20],
                           home_town:auth.info.location,
                           photo:auth.info.image
                           )
      user.skip_confirmation!
      user.save
    end
    user
  end

  private 
    def terms_agree
      self.terms = true
    end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string(255)
#  last_name              :string(255)
#  bio                    :text
#  home_town              :string(255)
#  home_mountain          :string(255)
#  terms                  :boolean
#  email_opt_in           :boolean
#  photo                  :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#
