module TableBot
  
  class Simulator
    attr_reader :width,
                :height,
                :robot_location
    
    def initialize
      @width = @height = 5
      @robot_orientation = 0
    end
    
    def robot_placed?
      not @robot_location.nil?
    end
    
    def valid_position?( position )
      position[1] < @height &&
      position[1] >= 0 &&
      position[0] < @width &&
      position[0] >= 0
    end
    
    def place( location, orientation )
      if location[1] > @height ||
         location[1] < 0 ||
         location[0] > @width ||
         location[0] < 0
        raise Error.new("Requested location is outside world boundaries")
      end
      
      @robot_location = location
      robot_orientation = orientation
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
    
    def turn( direction )
      case direction
      when :left
        @robot_orientation += 90
      when :right
        @robot_orientation -= 90
      end
    end
    
    ORIENTATION_MAP = {
      :east => 0,
      :north => 90,
      :west => 180,
      :south => 270
    }
    
    def robot_orientation
      ORIENTATION_MAP.key( @robot_orientation % 360 )
    end
    
    def robot_orientation=( new_orientation )
      @robot_orientation = ORIENTATION_MAP[ new_orientation ]
    end
    
  end
  
end