require 'speck'

require 'spark/core_ext'

module Spark
  Version = 0
  
  class <<self
    
    ##
    # “Plays” a `Speck` back, recursively. This consists of:
    # 
    # - Printing data about the `Speck`
    # - Executing the `Speck`
    # - Executing each `Check` belonging to the `Speck`
    # - Printing data about each `Check` and its result
    # - Recursively repeating the above for each child `Speck`
    def playback speck, indent = 0
      puts ("  " * indent) + speck.target.inspect
      indent += 1
      
      speck.execute
      
      speck.checks.each do |check|
        begin
          check.execute
          puts ("  " * indent) + check.description.ljust(72) + (" # => " + check.status.inspect).green
        rescue Speck::Exception::CheckFailed
          puts ("  " * indent) + check.description.ljust(72) + (" # !  " + check.status.inspect).red
        end
      end
      
      speck.children.each {|speck| Spark.playback speck, indent }
    end
    
  end
end
