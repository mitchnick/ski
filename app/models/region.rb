class Region < ActiveRecord::Base
  attr_accessible :name, :slug
  has_many :mountains, order: "name ASC"

	validates :slug, uniqueness: true, presence: true
  before_validation :generate_slug

  scope :alphabetical, order("name ASC")
  default_scope alphabetical
  
  def to_param
    "#{name}".parameterize
  end

  def generate_slug
    self.slug ||= name.parameterize
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['lower(name) LIKE ?', "%#{search.downcase}%"])
    else
      find(:all)
    end
  end
end
