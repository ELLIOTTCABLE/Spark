module Spark
  module Rake
    class SpeckTask
      
      ##
      # Called from a Rake execution environment, will define a new Rake task
      # that executes all of your root Specks, recursively.
      def initialize
        desc 'Recursively runs all root Specks'
        task :run do
          Speck::specks.select {|s| s.parent == nil }
            .each {|speck| Spark.playback speck }
        end
        
      end
      
    end
  end
end
