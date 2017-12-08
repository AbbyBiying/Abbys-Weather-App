require 'json'
require 'net/http'

class Location
  include ActiveModel::Validations
  attr_accessor :city_name, :temperature, :error

  validates_presence_of :city_name 

  def initialize(city_name)
    @city_name = city_name
  end

  def get_temperature
    @response = Net::HTTP.start(uri.host, uri.port) do |http|
      request = Net::HTTP::Get.new(uri)
      http.request(request)
    end

    if @response.code == "200"
      @temperature = (JSON.parse @response.body)["main"]["temp"]
    elsif @response.code == "301" 
      @error = "Sorry, this URL Moved Permanently."
    elsif city_name =~ /^\s/
      @error = "Sorry, please type a real city name."
    elsif @response.code == "500" 
      @error = "Sorry, something went wrong, please try again later!"
    elsif @response.code == "503"  
      @error = "Sorry, something went wrong with API, please try again later!"   
    elsif (@response.code == "400") || (@response.code == "404") 
      @error = "Sorry, city not found!"
    else
      @error = (JSON.parse @response.body)["message"]
    end
  end

  def uri
    @uri ||= URI("http://api.openweathermap.org/data/2.5/weather?APPID=#{ENV['APIKEY']}&units=Imperial&q=#{@city_name}")
  end
end 