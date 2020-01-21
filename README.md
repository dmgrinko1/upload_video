# README

### Prerequisites
You need to have the following prerequisites:
 - homebrew (for mac)
 - [Ruby 2.6.5] installed to be able to run this app. For OSX, try installing using homebrew
 - [FFmpeg ] installed to be able to run this app. For OSX, try installing using homebrew
 
### Getting the code 

When you have those configured then clone this repository to your
computer and install dependencies.
```shell
 $ git clone https://github.com/dmgrinko1/upload_video.git
 $ cd video_upload
 $ ./bin/setup
```

To start a dev server: `rails s`
See the running app at `http://localhost:3000`

* Ruby version
  `2.6.5`

* How to run Docker
    `docker-compose up mongo`
    `docker-compose up mongo_test`

* How to run Rubocop checks
    `bundle exec rubocop -D -c .rubocop.yml`
    `rubocop --safe-auto-correct`

* How to run the test suite
    `bundle exec rspec`

* Services (job queues, cache servers, search engines, etc.)
    `bundle exec sidekiq`
