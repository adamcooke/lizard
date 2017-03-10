require 'open3'

module Lizard
  def self.root
    File.expand_path('../../', __FILE__)
  end

  def self.run_command(command, input = nil)
    stdin, stdout, stderr, wait_thr = Open3.popen3(command)
    stdin.binmode
    stdout.binmode
    stderr.binmode
    stdin.write(input) if input
    stdin.close
    [stdout.read, stderr.read, wait_thr.value.to_i]
  end
end

require 'lizard/image'
