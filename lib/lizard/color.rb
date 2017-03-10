module Lizard
  class Color
    attr_reader :frequency, :hex

    def initialize(frequency, hex)
      @frequency = frequency
      @hex = hex
    end

    def red
      @hex[0,2].to_i(16)
    end

    def green
      @hex[2,2].to_i(16)
    end

    def blue
      @hex[4,2].to_i(16)
    end
  end
end
