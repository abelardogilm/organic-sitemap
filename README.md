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

  # By default, all urls are saved on Redis.new(url: 'redis://127.0.0.1:6379'), but you can set you own connection
  # config.redis_connection = Your redis connection
end

  # url are saved on a set on redis called "sitemap-urls", but if you want you can change it
  # config.storage_key = your key
  
  # By dafault all url have a expiry time in 7 days, after this time, if no one load this page, it will be removed from the set. To change it (expect number of days):
  # config.expiry_time = X
end
```

## Contribution

If you have cool idea for improving this Gem or any bug fix just open a pull request and I'll be glad to have a look and merge it if seems fine.

## License

This project rocks and uses [MIT-LICENSE](https://github.com/abelardogilm/organic-sitemap/blob/master/LICENSE.txt).