OrganicSitemap.configure do |config|
  
  # Add here all regexp you don't want to add on your sitemap
  # config.skipped_urls = [ "^/sitemap",
  #                         ".txt$",
  #                         ".rss$" ] 

  # OrganicSitemap ignore query_params to identify urls. You can add you allowed params
  # config.allowed_params = [...]

  # By default, all urls are saved on Redis.new(url: 'redis://127.0.0.1:6379'),
  # but you can set you own connection
  # config.redis_connection = Your redis connection

  # url are saved on a set on redis called "sitemap-urls", but if you want you can change it
  # config.storage_key = your key
  
  # By dafault all url have a expiry time in 7 days
  # after this time, if no one load this page, it will be removed from the set.
  # To change it (number of days):
  # config.expiry_time = X

  # Crawler needs a domain to mount urls to visit
  config.crawler_domain = "http://mi.domain.com"

  # By default crawler_delay is 5sec. This is the time between get each url
  # To change it (seconds of delay):
  # config.crawler_delay = x

  # By default, do nothing with urls that not return 200.
  # If you want remove automatically 301 urls from Redis
  # config.clean_redirects = true
  # If you want remove automatically 404 urls from Redis
  # config.clean_not_found = true
end
