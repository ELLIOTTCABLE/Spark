require 'speck'

require 'spark/core_ext'

module Spark
  Version = 0
  
  ##
  # “Plays” a `Speck`, or `Speck:Battery`, recursively. This consists of:
  # 
  # - Printing data about the `Speck` or `Battery`
  # - Executing the `Battery`
  # - Executing the `Speck`(s)
  # - Executing each `Check` belonging to the `Speck`(s)
  # - Printing data about each `Check` and its result
  # - Recursively repeating the above for each child `Speck` or `Battery`
  def self.playback target, indent = 0
    if target.respond_to? :specks and target.respond_to? :targets
      target.specks.each {|speck| Spark::playback speck }
      target.targets.each {|object, battery| Spark::playback battery }
    else
      # TODO: FUCK FUCK FUCK THIS IS UGLY CODE ARRRGH
      puts ("  " * indent) + target.target.inspect if target.target
      indent += 1
      
      target.execute
      
      checks = target.checks.group_by do |check|
        begin
          check.execute unless check.status
        rescue Speck::Exception::CheckFailed
        end
        puts ("  " * indent) + case check.status
        when :passed then (" # " + check.status.to_s).green
        when :failed then (" # " + check.status.to_s).red
        when :future then (" # " + check.status.to_s).yellow
        else              (" # " + check.status.to_s).cyan
        end
        check.status
      end
      
      child_checks = target.children
        .inject({:passed => [], :failed => []}) do |children_checks, speck|
          child_checks = Spark::playback speck, indent
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
      passed = checks[:passed].size
      failed = checks[:failed].size
      other = checks.inject(0) {|t, (k,v)| t += v.size unless [:passed, :failed].include? k; t }
      puts ("  " * indent) + "(#{
        checks[:failed].size > 0 ?
          checks[:passed].size.to_s.red : checks[:passed].size.to_s.green
        }#{other &&! other.zero? ? '/' + other.to_s.cyan : nil } of #{total})" unless total.zero?
      
      return checks
    end
  end
  
end
