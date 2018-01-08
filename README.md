# Weather-App

This is a Ruby on Rails web app to demo Weather API - OpenWeatherMap. It is deployed on AWS Elastic Beanstalk.   
<!-- # http://production.hhee9ssiuj.us-east-1.elasticbeanstalk.com/ -->

# Implementation
 
* The app is implemented with Rails 5. Ruby on Rails is a full-stack web framework.
  
* Net::HTTP, an HTTP client API for Ruby, is used to call the OpenWeatherMap API. 

* Rendering is done on the server side with erb. 
 

# Testing

* Rspec is used for unit tests. 
* Capybara is used for intergration tests with WebMock, a Library for stubbing and setting expectations on HTTP requests in Ruby. 
# Build / Run

If you check out this source code you can run it on your local machine.

* Install ruby-2.4.2 (via apt, brew, or rvm)
* Install Rails at the command prompt if you haven't yet:

 $ gem install rails
* gem install bundler
* bundle install
* bundle exec puma