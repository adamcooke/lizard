require "tempfile"
require "lizard/color_profiles"
require "lizard/error"
require "lizard/histogram"

module Lizard
  class Image

    TYPES = ['jpeg', 'png', 'gif']

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

    def inspect
      "#<Lizard::Image type=#{type}, size=#{width}x#{height}, bytes=#{@data.bytesize}>"
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
      when/CMYK/i then "CMYK"
      when /RGB/i then "RBG"
      else nil
      end
    end

    def resize(width, height, mode = :resize_down_only, type = "jpeg")
      case mode
      when :default
        operator = ""
      when :resize_down_only
        operator = ">"
      when :fill
        operator = "^"
      when :ignore_aspect
        operator = "!"
      else
        raise InvalidResizeMode, "#{mode} is not a valid"
      end

      unless TYPES.include?(type)
        raise InvalidFileType, "#{type} is not valid. Choose from #{TYPES.join(', ')}"
      end

      command = [
        'convert', '-', '-profile', Lizard::COLOR_PROFILES["RGB"], '-flatten',
        '-resize', "#{width.to_i}x#{height.to_i}#{operator}",
        "#{type}:-"
      ]
      if self.color_model == "CMYK"
        command.insert(4, '-profile')
        command.insert(5, COLOR_PROFILES[self.color_model].to_s)
      end

      stdout, stderr, exit_code = Lizard.run_command(command, @data)
      if exit_code == 0
        Image.new(stdout)
      else
        raise ResizeFailed, "Image could not be resized (#{stderr})"
      end
    end

    def crop(width, height, type = "jpeg")
      unless TYPES.include?(type)
        raise InvalidFileType, "#{type} is not valid. Choose from #{TYPES.join(', ')}"
      end

      command = ['convert', '-', '-gravity', 'center', '-extent', "#{width.to_i}x#{height.to_i}", "#{type}:-"]
      stdout, stderr, exit_code = Lizard.run_command(command, @data)
      if exit_code == 0
        Image.new(stdout)
      else
        raise CropFailed, "Image could not be cropped (#{stderr})"
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
        width, height = size.split("x")
        {:type => type, :resolution => resolution, :width => width, :height => height, :size => size, :color_space => color_space}
      else
        raise NotAnImage, stderr
      end
    end

  end
end
