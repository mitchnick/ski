class Region < ActiveRecord::Base
  attr_accessible :name
  has_many :mountains

	validates :slug, uniqueness: true, presence: true
  before_validation :generate_slug
  
  def to_param
    "#{name}".parameterize
  end

  def generate_slug
    self.slug ||= name.parameterize
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
