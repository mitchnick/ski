class MountainsController < ApplicationController
  before_filter :get_mountain
  before_filter :authenticate_admin!, only: :create

  def get_mountain
    @mountain = Mountain.find_by_slug!(params[:id])
  end

  def index
    @mountains = Mountain.all
  end

	def show
    @mymountains = @mountain.my_mountains
    @photos = @mountain.photos.sort { |x,y| y.gnars.count <=> x.gnars.count }.paginate(page: params[:page], per_page: GlobalVar::PHOTOSPERPAGE)
    @shoots = @mountain.photographers.where(photo_relationships: {role_id: RelationshipRole::PHOTOGRAPHER}).uniq.paginate(page: params[:page], per_page: GlobalVar::PHOTOSPERPAGE)
    @rides = @mountain.users.where(my_mountains: {type: MyMountainRole::HAVEBEEN}).uniq.paginate(page: params[:page], per_page: GlobalVar::PHOTOSPERPAGE)
  end

  def create
  	@mountain = Mountain.new
  end
  
end
