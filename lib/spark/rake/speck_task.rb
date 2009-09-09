require 'spark'

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
        @files << 'specifications/**/*_specs.rb' if @files.empty?
        
        self.files += ENV['SPECK_FILES'].split(/[ ,]/) if ENV['SPECK_FILES']
        
        define
      end
      
      def define
        # XXX: Why the hell is this necessary? God, I hate Rake.
        Object.send :desc, @desc
        Object.send :task, name do
          [@files].flatten.map {|p| p.include?("*") ? Dir[p] : p }.flatten
            .each {|f| require File.expand_path(f) }
          checks = Speck::unbound.inject(Array.new) do |acc, speck|
            puts '-~- ' * 10 + '*' + ' -~-' * 10 if Speck::unbound.size > 1
            acc << Spark.playback(speck)
          end
          puts '-~- ' * 10 + '*' + ' -~-' * 10 if Speck::unbound.size > 1
          
          exit(1) if checks.map {|c| c[:failed].size }
            .inject {|acc,e| acc + e } > 0
        end
      end
      
    end
    
  end
end
