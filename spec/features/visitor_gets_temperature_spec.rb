require "rails_helper"

RSpec.feature "get temperature", :type => :feature do
  scenario "user visits homepage" do 
    visit '/'

    expect(page).to have_content('Welcome to Abbys weather app!')
    expect(page).to have_content('Submit')
 end

  scenario "user get redirect to homepage when typo" do
    visit '/'

    ENV['APIKEY'] = "myApiKey"
    stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?APPID=myApiKey&units=Imperial&q=Typo").to_return(status: 500, body:"{\"cod\":\"404\",\"message\":\"city not found\"}")

    submit_city("Typo")

    expect(page).to have_content('Sorry, city not found!')
    expect(current_path).to eql "/"
  end

  scenario "user get temperature" do   
    visit '/'

    ENV['APIKEY'] = "myApiKey"
    stub_request(:get, "http://api.openweathermap.org/data/2.5/weather?APPID=myApiKey&units=Imperial&q=Boston").to_return(status: 200, body: "{\"coord\":{\"lon\":-71.06,\"lat\":42.36},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01n\"}],\"base\":\"stations\",\"main\":{\"temp\":29.91,\"pressure\":1015,\"humidity\":86,\"temp_min\":26.6,\"temp_max\":33.8},\"visibility\":16093,\"wind\":{\"speed\":13.13,\"deg\":253},\"clouds\":{\"all\":1},\"dt\":1512719760,\"sys\":{\"type\":1,\"id\":1951,\"message\":0.1661,\"country\":\"US\",\"sunrise\":1512734474,\"sunset\":1512767492},\"id\":4930956,\"name\":\"Boston\",\"cod\":200}", headers: {})

    submit_city("Boston")

    expect(page).to have_content("29.91")
  end
end