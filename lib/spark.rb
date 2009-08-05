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
    def playback speck
      speck.execute
    
      speck.checks.each do |check|
        begin
          check.execute
          puts check.description.ljust(72) + (" # => " + check.status.inspect).green
        rescue Speck::Exception::CheckFailed
          puts check.description.ljust(72) + (" # !  " + check.status.inspect).red
        end
      end
    
      speck.children.each {|speck| Spark.playback speck }
    end
  
  end
end
