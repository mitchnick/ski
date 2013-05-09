# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.wheretoski.co"
SitemapGenerator::Sitemap.sitemaps_path = 'shared/'
SitemapGenerator::Sitemap.create do
  
  add '/about'
  add '/contact'
  add '/search'
  add '/all_mountains'

  Mountains.find_each do |mountain|
    add mountains_path(mountain), :lastmod => mountain.updated_at
  end

  Regions.find_each do |region|
    add regions_path(region), :lastmod => region.updated_at
  end
  
  Users.find_each do |user|
    add users_path(user), :lastmod => user.updated_at
  end

  Photos.find_each do |photo|
    add mountain_photos_path(photo.mountain, photo), :lastmod => photo.updated_at
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
