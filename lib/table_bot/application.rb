require "table_bot/simulator"

module TableBot
  
  class Application
    
    def initialize
      @simulator = Simulator.new
    end
    
    def run
      while line = gets
        parse line
      end
    end
    
    def parse( line )
      words = line.split
      command = words.first.to_sym
      
      return unless command == :PLACE || @simulator.robot_placed?
      
      case command
      when :PLACE
        x, y, orientation = words[1].split(',')
        @simulator.place( [ x.to_i, y.to_i ], orientation.downcase.to_sym )
      when :MOVE
        @simulator.move
      when :LEFT
        @simulator.turn(:left)
      when :RIGHT
        @simulator.turn(:right)
      when :REPORT
        puts "#{@simulator.robot_location.join(',')} #{@simulator.robot_orientation}"
      end
    end
    
  end
  
end