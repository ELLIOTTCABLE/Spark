require 'rake'
require 'rake/tasklib'

module Spark
  module Rake
    
    class SpeckTask < ::Rake::TaskLib
      attr_accessor :name
      attr_accessor :desc
      attr_accessor :files
      
      def initialize name = :specks
        @name = name
        @files = []
        @desc = "Recursively runs all unbound Specks"
        
        yield self if block_given?
        self.files += ENV['SPECK_FILES'].split(/[ ,]/) if ENV['SPECK_FILES']
        
        define
      end
      
      def define
        # XXX: Why the hell is this necessary? God, I hate Rake.
        Object.send :desc, @desc
        Object.send :task, name do
          [@files].flatten.map {|p| p.include?("*") ? Dir[p] : p }.flatten
            .each {|f| require File.expand_path(f) }
          Speck::unbound.each {|speck| Spark.playback speck }
        end
      end
    end
  end
end
