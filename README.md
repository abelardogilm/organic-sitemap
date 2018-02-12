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
Put this line in your Gemfile:

```gem 'organic-sitemap'```

Run ```bundle install```

## Configuration

To setup this gem you should add your config:

```ruby
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
```

## Crawler and cache Services

If have a front cache service, this services allow you to use your score sitemap to warmup this expire urls

When a page is loaded, score is update with current time and this told as when last cache occurs. Using it we can get all expired urls, and visit they to warm it up.

To configure it:

### On initializer define:

```ruby
  # Crawler needs a domain to mount urls to visit
  config.crawler_domain = "http://mi.domain.com"

  # By default crawler_delay is 5sec. This is the time between get each url
  # To change it (seconds of delay):
  # config.crawler_delay = x
```

With **CacheManager.uncached_urls(expiration_time: CacheExpirationTime, url_pattern: PATTERN)** we get all url not hitted on this time (all expired urls)

*** Examples

```ruby
# Return urls not visited between 1.week.ago(setted on config.expiry_time) and 3.hours.ago
OrganicSitemap::CacheManager.uncached_urls(expiration_time: 3.hours)

# Return urls not visited between 1.week.ago(setted on config.expiry_time) and 3.hours.ago and contains "/test/" string
OrganicSitemap::CacheManager.uncached_urls(expiration_time: 3.hours, url_pattern: "/test/")

# Return urls not visited between 1.week.ago(setted on config.expiry_time) and 3.hours.ago and match ^\/test\/ regexp
OrganicSitemap::CacheManager.uncached_urls(expiration_time: 3.hours, url_pattern: /^\/test\//)
```

The with **CrawlerManager.warmup(urls, opts={})** we visit all this urls. We can set a delay between each page load setting a delay on configuration file. When we visit a url, *RedisManager* update score for this url and will be no more visited until not expire cache time

*** Examples

```ruby
# For a 3.hours page cache, get page with user-agent='Ruby'
CrawlerManager.warmup(CacheManager.uncached_urls(expiration_time: 3.hours))

# Get '/test' with user-agent='Crawler-bot'
CrawlerManager.warmup('/test', {headers: {"User-Agent" => 'Crawler-bot'}})
```

## Rails config generator

Copy base config file on your Rails app by

```sh
$ rails generator organic_sitemap:config
```

## Contribution

If you have cool idea for improving this Gem or any bug fix just open a pull request and I'll be glad to have a look and merge it if seems fine.

## License

This project rocks and uses [MIT-LICENSE](https://github.com/abelardogilm/organic-sitemap/blob/master/LICENSE.txt).
