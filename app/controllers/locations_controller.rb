class LocationsController < ApplicationController
  def new
    @location = Location.new(nil) 
  end

  def show
    @location = Location.new(params["city_name"])
    if @location.valid?
      @location.get_temperature 
      p @location
      if !@location.temperature
        flash.now[:error] = @location.error
        render :new
      end 
    else
      flash.now[:error] = "Please type a valid city name!"
      render :new
    end 
  end
end
