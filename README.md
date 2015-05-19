# OrganicSitemap
OrganicSitemap is a gem that gives you a structure to manage your sitemap with healthy urls. It adds a middleware that save on a expiry set on redis all urls served from your server that meet certain criteria

* *status* **200**
* Only html pages
* *method* **GET**
* Not are included on a **skypped_urls** Array

## Requisites

**OrganicSitemap** add a middleware on your **Rails** project.

Uses a **Redis** connection to save sitemaps urls

## Installation
OrganicSearch is not available as a gem yet, you can load it using my github account.

Add in your Gemfile:

```gem 'organic-sitemap', :git => 'git://github.com/abelardogilm/organic-sitemap.git'```

Run ```bundle install.```

## Configuration

to be continued...