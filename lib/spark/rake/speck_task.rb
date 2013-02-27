require 'spark'

require 'rake/tasklib'

module Spark
  module Rake
    
    class SpeckTask < ::Rake::TaskLib
      attr_accessor :name
      attr_accessor :description
      attr_accessor :files
      attr_accessor :batteries
      
      def initialize name = :specks, batteries = Array.new
        @name = name
        @batteries = batteries.is_a?(Array) ? batteries : [batteries]
        @files = []
        @description = "Recursively runs all unbound Specks"
        
        yield self if block_given?
        @files << 'specifications/**/*_specs.rb' if @files.empty?
        
        self.files += ENV['SPECK_FILES'].split(/[ ,]/) if ENV['SPECK_FILES']
        
        define
      end
      
      def define
        desc @description
        task @name do
          # TODO: AND SUDDENLY, UGLY CODES! KILOBYTES OF THEM!
          [@files].flatten.map {|p| p.include?("*") ? Dir[p] : p }.flatten
            .each {|f| require File.expand_path(f) }
          
          targets = @batteries.empty? ? Speck::unbound : @batteries
          checks = targets.inject(Array.new) do |acc, target|
            puts '-~- ' * 10 + '*' + ' -~-' * 10 if targets.size > 1
            target = target.call if target.respond_to? :call
            acc << Spark.playback(target)
          end
          puts '-~- ' * 10 + '*' + ' -~-' * 10 if targets.size > 1
          
          exit(1) if checks.map {|c| c[:failed] ? c[:failed].size : 0 }
            .inject {|acc,e| acc + e } > 0
        end
      end
      
    end
    
  end
end
