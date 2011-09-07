module TableBot
  
  class Simulator
    attr_reader :width,
                :height,
                :robot_location
    
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
    
    def move
      current_location = robot_location
      
      case robot_orientation
      when :north
        current_location[1] += 1
      when :south
        current_location[1] -= 1
      when :east
        current_location[0] += 1
      when :west
        current_location[0] -= 1
      end
      
      place( current_location, robot_orientation )
    end
    
    def robot_orientation
      case @robot_orientation % 360
      when 0
        :east
      when 90
        :north
      when 180
        :west
      when 270
        :south
      end
    end
    
  end
  
end