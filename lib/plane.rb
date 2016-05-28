require "weather"

class Plane
	CANNOT_LAND_ERROR_MSG = "cannot land plane"
	CANNOT_TAKE_OFF_ERROR_MSG =  "cannot take_off plane"
	SKY = Sky.new
	NO_WEATHER = NoWeather.new

	def initialize
		@position =  SKY
		@weather = NO_WEATHER
	end

	def land(airport)
		if !landed?
			if @weather.stormy?
				raise "error"
			else
				@position = airport if airport.accept_plane?(self)
			end
		else
			raise "error"
		end
		# change_position(airport)
	end

	def take_off
		if landed?
			if @weather.stormy?
				raise	"error"
			else
				@position = SKY
			end
		else 
			raise "error"
		end
		# change_position(SKY)
	end	

	def landed?
		@position.is_airport?
	end

	def get_position
		@position
	end

	def weather(weather)
		@weather = weather
	end

	private

	def change_position(new_position = SKY)
			if transition_ok?(new_position)
				transition(new_position)
			else; raise "error"; end
	end

	def transition_ok?(new_position)
		return false if @weather.stormy?
		return true if ([new_position,@position].select{|x| x.is_a?(Sky)}.count == 1) && new_position.accept_plane?(self)
		false
	end

	def transition(new_position)
		@position.release_plane(self) 
		new_position.receive_plane(self)
		@position = new_position
	end

end
