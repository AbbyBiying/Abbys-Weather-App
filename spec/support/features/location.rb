module Features
  def submit_city(city_name = "Boston")
    fill_in "City Name", with: city_name
    click_on "Submit"
 	end
end
