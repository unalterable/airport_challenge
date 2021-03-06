require 'airport'
require 'plane'
require 'weather'

describe "Program Feature Test" do
  let(:bad_weather) {double(:weather, stormy?: true)}
  let(:good_weather) {double(:weather, stormy?: false)}
  # As an air traffic controller 
  # So I can get passengers to a destination 
  # I want to instruct a plane to land at an airport and 
  #   confirm that it has landed 
  it "instructs a plane to land at an airport and confirm 
                                     that it has landed " do
    plane = Plane.new(good_weather)
    airport = Airport.new
    plane.land(airport)
    plane.landed?
  end

  # As an air traffic controller 
  # So I can get passengers on the way to their destination 
  # I want to instruct a plane to take off from an airport 
  #   and confirm that it is no longer in the airport
  it "instructs a plane to take off from an airport and 
            confirm that it is no longer in the airport" do
    plane = Plane.new(good_weather)
    airport = Airport.new
    plane.land(airport)
    # plane.position == airport #should be true
    plane.take_off
    # plane.position != airport #should be true
  end

  # As an air traffic controller 
  # To ensure safety 
  # I want to prevent takeoff when weather is stormy
  it "prevent takeoff when weather is stormy" do
    plane = Plane.new(good_weather)
    airport = Airport.new
    weather = Weather.new
    plane.land(airport)
    plane.new_weather(weather)
    # plane.position == airport #should be true
    begin
      plane.take_off
    rescue
      "error"
    end
    # plane.position == airport #should be true
  end

  # As an air traffic controller 
  # To ensure safety 
  # I want to prevent landing when weather is stormy 
  it "prevent landing when weather is stormy" do
    plane = Plane.new(bad_weather)
    airport = Airport.new
    begin
      plane.land(airport)
    rescue
      "error"
    end
    # plane.position == airport #should be true
  end

  # As an air traffic controller  
  # To ensure safety
  # I want to prevent landing when the airport is full
  it "prevent landing when the airport is full" do
    test_capacity = rand(1..100)
    planes = []
    airport = Airport.new(test_capacity)
    test_capacity.times do |i|
      planes[i] = Plane.new(good_weather)
      planes[i].land(airport)
    end
    begin
      Plane.new.land(airport)
    rescue
      "error"
    end
  end

  # As the system designer
  # So that the software can be used for many different
  #  airports
  # I would like a default airport capacity that can be
  #  overridden as appropriate


end