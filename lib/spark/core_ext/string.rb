class String
  
  ##
  # Provides some methods to colourize strings for output to the terminal.
  module ANSI
    
    # The available ANSI colour codes. The index in the array is the ANSI
    # code.
    Colours = [
      :black,
      :red,
      :green,
      :yellow,
      :blue,
      :magenta,
      :cyan,
      :white
    ]
    
    Colours.each.with_index do |colour, index|
      define_method colour do
        self.wrap_ansi "[3#{index}m"
      end
    end
    
    ##
    # Wraps this string in the given ANSI code.
    def wrap_ansi code
      "\033#{code}#{self}\033[0m"
    end
    
  end
  
  include ANSI
end
