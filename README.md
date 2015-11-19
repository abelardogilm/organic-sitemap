# OrganicSitemap
OrganicSitemap is a gem that gives you a structure to manage your sitemap with healthy urls. It adds a middleware that save on a expiry set on redis all urls served from your server that meet certain criteria

* *status* **200**
* Only html pages
* *method* **GET**
* Don't match with any of **skypped_urls** Array

## Requisites

**OrganicSitemap** add a middleware on your **Rails** project.

Uses a **Redis** connection to save sitemaps urls

## Installation
OrganicSearch is not available as a gem yet, you can load it using my github account.

Add in your Gemfile:

```gem 'organic-sitemap', :git => 'git://github.com/abelardogilm/organic-sitemap.git'```

Run ```bundle install.```

## Configuration

To setup this gem you should add your config:

```
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
end
```
## Crawler and cache Services

If have a front cache service, this services allow you to use your score sitemap to warmup this expire urls

When a page is loaded, score is update with current time and this told as when last cache occurs. Using it we can get all expired urls, and visit they to warm it up.

To configure it:

### On initializer define:
```
  # Crawler needs a domain to mount urls to visit
  config.crawler_domain = "http://mi.domain.com"

  # By default crawler_delay is 5sec. This is the time between get each url
  # To change it (seconds of delay):
  # config.crawler_delay = x
```

With **CacheService.uncached_url(to: CacheExpirationTime)** we get all url not hitted on this time (all expired urls)

Example:
```
CacheService.uncached_urls(3.hours) # Return urls not visited between 1.week.ago(setted on  config.expiry_time) and 3.hours.ago
```
The with **CrawlerService.warmup(urls)** we visit all this urls with a delay setted on configuration file (by default 5 sec). When we visit a url, *RedisManager* update score for this url and will be no more visited until not expire cache time

Example:
```
# For a 1.day page cache
CrawlerService.warmup(CacheService.uncached_urls(3.hours))
```

## Rails config generator

Copy base config file on your Rails app by

```rails generator organic_sitemap:config```

## Contribution

If you have cool idea for improving this Gem or any bug fix just open a pull request and I'll be glad to have a look and merge it if seems fine.

## License

This project rocks and uses [MIT-LICENSE](https://github.com/abelardogilm/organic-sitemap/blob/master/LICENSE.txt).
