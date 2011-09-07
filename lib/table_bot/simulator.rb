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
      raise Error.new("Requested location is outside world boundaries") unless valid_position?( location )
      
      @robot_location = location
      self.robot_orientation = orientation
    end
    
    def move
      new_location = robot_location
      
      case robot_orientation
      when :north
        new_location[1] += 1
      when :south
        new_location[1] -= 1
      when :east
        new_location[0] += 1
      when :west
        new_location[0] -= 1
      end
      
      place( new_location, robot_orientation ) if valid_position?( new_location )
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