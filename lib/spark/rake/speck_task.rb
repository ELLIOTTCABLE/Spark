module Spark
  module Rake
    class SpeckTask
      
      ##
      # Called from a Rake execution environment, will define a new Rake task
      # that executes all of your unbound Specks, recursively (thus running
      # all defined specks).
      def initialize
        desc 'Recursively runs all unbound Specks'
        task :run do
          Speck::unbound.each {|speck| Spark.playback speck }
        end
        
      end
      
    end
  end
end
