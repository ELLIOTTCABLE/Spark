require 'speck'

require 'spark/core_ext'

module Spark
  Version = 0
  
  ##
  # “Plays” a `Speck` back, recursively. This consists of:
  # 
  # - Printing data about the `Speck`
  # - Executing the `Speck`
  # - Executing each `Check` belonging to the `Speck`
  # - Printing data about each `Check` and its result
  # - Recursively repeating the above for each child `Speck`
  def self.playback speck, indent = 0
    # TODO: FUCK FUCK FUCK THIS IS UGLY CODE ARRRGH
    puts ("  " * indent) + speck.target.inspect
    indent += 1
    
    speck.execute
    
    checks = speck.checks.group_by do |check|
      begin
        check.execute
        puts ("  " * indent) + (" # " + check.status.to_s).green
      rescue Speck::Exception::CheckFailed
        puts ("  " * indent) + (" # " + check.status.to_s).red
      end
      check.status
    end
    
    child_checks = speck.children
      .inject({:passed => [], :failed => []}) do |children_checks, speck|
        child_checks = Spark.playback speck, indent
        child_checks.each do |k,v|
          children_checks[k] ||= Array.new
          children_checks[k] += v || Array.new
        end
        children_checks
      end
    
    child_checks.each do |k,v|
      checks[k] ||= Array.new
      checks[k] += v || Array.new
    end
    
    
    indent -= 1
    
    # TODO: FUCK FUCK FUCK THIS IS EVEN UGLIER THAN THE ABOVE CODE!!!!1!1
    total = checks.inject(0) {|t, (k,v)| t + v.size }
    puts ("  " * indent) + "(#{
      checks[:failed].size > 0 ?
        checks[:passed].size.to_s.red : checks[:passed].size.to_s.green
      } of #{total})" unless total.zero?
    
    return checks
  end
  
end
