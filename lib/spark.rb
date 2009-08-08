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
      # TODO: FUCK FUCK FUCK THIS IS UGLY CODE ARRRGH
      puts ("  " * indent) + speck.target.inspect
      indent += 1
      
      speck.execute
      
      checks = speck.checks.partition do |check|
        begin
          check.execute
          puts ("  " * indent) + check.target.ljust(72) + (" # " + check.expectation).green
          true
        rescue Speck::Exception::CheckFailed
          puts ("  " * indent) + check.target.ljust(72) + (" # " + check.expectation).red
          false
        end
      end
      
      child_checks = speck.children.inject([[],[]]) do |children_checks, speck|
        child_checks = Spark.playback speck, indent
        children_checks.map.with_index {|e,i| e += child_checks[i] }
      end
      checks = checks.map.with_index {|e,i| e += child_checks[i] }
      
      indent -= 1
      
      # TODO: FUCK FUCK FUCK THIS IS EVEN UGLIER THAN THE ABOVE CODE!!!!1!1
      puts ("  " * indent) + "(#{
        checks.first.size == checks.flatten.size ? checks.first.size.to_s.green : checks.first.size.to_s.red} of #{
        checks.flatten.size})"
      
      return checks
    end
    
  end
end
