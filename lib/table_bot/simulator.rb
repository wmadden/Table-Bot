module TableBot
  
  class Simulator
    attr_reader :width,
                :height,
                :robot_location,
                :robot_orientation
    
    def initialize
      @width = @height = 5
    end
    
    def place( location, orientation )
      if location[1] > @height ||
         location[1] < 0 ||
         location[0] > @width ||
         location[0] < 0
        raise Error.new("Requested location is outside world boundaries")
      end
      
      @robot_location = location
      @robot_orientation = orientation
    end
    
  end
  
end