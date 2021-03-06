# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.wheretoski.co"
SitemapGenerator::Sitemap.create do
  
  add '/about'
  add '/contact'
  add '/search'
  add '/all_mountains'

  Mountain.find_each do |mountain|
    add mountain_path(mountain), :lastmod => mountain.updated_at
  end

  Region.find_each do |region|
    add region_path(region), :lastmod => region.updated_at
  end
  
  User.find_each do |user|
    add user_path(user), :lastmod => user.updated_at
  end

  Photo.find_each do |photo|
    add mountain_photo_path(photo.mountain, photo), :lastmod => photo.updated_at
  end

  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
