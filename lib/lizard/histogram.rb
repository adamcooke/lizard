require 'lizard/color'
module Lizard
  class Histogram

    def initialize(data)
      stdout, stderr, exit_code = Lizard.run_command("convert - -colors 16 -depth 8 -format %c histogram:info:-", data)
      if exit_code == 0
        stdout = stdout.split(/\n/)
        @colors = stdout.each_with_object(Array.new) do |line, colors|
          if line =~ /\A\s*(\d+)\:.*\#([A-F0-9]{6}).*\z/
            colors << Color.new($1.to_i, $2)
          end
        end.sort_by(&:frequency)
      else
        raise Error, "Could not get histogram"
      end
    end

    def colors
      @colors ||= []
    end

  end
end
