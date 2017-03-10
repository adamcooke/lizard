require 'tempfile'
require 'lizard/color_profiles'
require 'lizard/error'
require 'lizard/histogram'

module Lizard
  class Image

    def self.is_image?(data)
      image = Image.new(data)
      true
    rescue NotAnImage
      false
    end

    def initialize(data)
      @data = data
      @properties = identify
    end

    def data
      @data
    end

    def type
      @properties[:type]
    end

    def resolution
      @properties[:resolution]
    end

    def width
      @properties[:width].to_i
    end

    def height
      @properties[:height].to_i
    end

    def color_space
      @properties[:color_space].strip
    end

    def color_model
      case color_space
      when/CMYK/i then 'CMYK'
      when /RGB/i then 'RBG'
      else nil
      end
    end

    def resize(width, height)
      size = "#{width}x#{height}\\>"
      profile = "-profile " + Lizard::COLOR_PROFILES['RGB']
      if self.color_model == 'CMYK'
        profile = "-profile " + COLOR_PROFILES[self.color_model].to_s + " " + profile
      end
      stdout, stderr, exit_code = Lizard.run_command("convert - -flatten #{profile} -resize #{size} -", @data)
      if exit_code == 0
        Image.new(stdout)
      else
        raise ResizeFailed, "Image could not be resized (#{stderr})"
      end
    end

    def histogram
      @histogram ||= Histogram.new(@data)
    end

    private

    def identify
      stdout, stderr, exit_code = Lizard.run_command(%Q{identify -format "Lizard||%m||%[resolution.x]x%[resolution.y]||%wx%h||%r" -}, @data)
      if exit_code == 0 && stdout =~ /\ALizard\|\|/
        _, type, resolution, size, color_space = stdout.split("||")
        width, height = size.split('x')
        {:type => type, :resolution => resolution, :width => width, :height => height, :size => size, :color_space => color_space}
      else
        raise NotAnImage, stderr
      end
    end

  end
end
