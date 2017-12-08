require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Location, type: :model do

 # before :all do
 #  stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?APPID=myApiKey&q=Boston&units=Imperial").
 #           with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'api.openweathermap.org', 'User-Agent'=>'Ruby'}).
 #           to_return(status: 200, body: "", headers: {})
 # end

  describe "#initialize" do
    it "should print city name" do
      location = Location.new("New York")

      expect(location.city_name).to eql("New York")
    end
  end

  describe "#uri" do
    it "CLASSICIST should return the correct URI" do
      ENV['APIKEY'] = "myApiKey"
      location = Location.new("Boston")

      expect(location.uri).to eql URI("http://api.openweathermap.org/data/2.5/weather?APPID=myApiKey&units=Imperial&q=Boston")
    end

    it "MOCKIST should return the correct URI" do
      ENV['APIKEY'] = "myApiKey"
      location = Location.new("Boston")

      expect(location).to receive(:URI).with("http://api.openweathermap.org/data/2.5/weather?APPID=myApiKey&units=Imperial&q=Boston").and_return("blah")

      expect(location.uri).to eql "blah"
   end
 end

  describe "#get_temperature" do
    it "should make a HTTP call to URI and get temperature" do
      location = Location.new("Boston")
    
      expect(location).to receive(:uri).exactly(3).and_return(URI("http://myapiurl"))
 
      stub_request(:get, "http://myapiurl/").to_return(status: 200, body: "{\"coord\":{\"lon\":-71.06,\"lat\":42.36},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01n\"}],\"base\":\"stations\",\"main\":{\"temp\":29.91,\"pressure\":1015,\"humidity\":86,\"temp_min\":26.6,\"temp_max\":33.8},\"visibility\":16093,\"wind\":{\"speed\":13.13,\"deg\":253},\"clouds\":{\"all\":1},\"dt\":1512719760,\"sys\":{\"type\":1,\"id\":1951,\"message\":0.1661,\"country\":\"US\",\"sunrise\":1512734474,\"sunset\":1512767492},\"id\":4930956,\"name\":\"Boston\",\"cod\":200}", headers: {})
 
      location.get_temperature

      expect(location.temperature).to eql 29.91
    end

    it "should set error message and set temperature to nil" do
      location = Location.new("Typo")

      expect(location).to receive(:uri).exactly(3).and_return(URI("http://myapiurl"))
    
      stub_request(:get, "http://myapiurl/").to_return(status: 500, body:"{\"cod\":\"404\",\"message\":\"city not found\"}")
   
      location.get_temperature

      expect(location.error).to eql ("Sorry, city not found!")
   
      expect(location.temperature).to eql nil
    end
  end
end