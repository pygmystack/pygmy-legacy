require 'ostruct'

module Dory
  module Sh
    def self.run_command(command)
      stdout = `#{command}`
      OpenStruct.new({
        success?: $?.exitstatus == 0,
        exitstatus: $?.exitstatus,
        stdout: stdout
      })
    end
  end

  module Bash
    def self.run_command(command)
      stdout = `bash -c "#{command}"`
      OpenStruct.new({
        success?: $?.exitstatus == 0,
        exitstatus: $?.exitstatus,
        stdout: stdout
      })
    end
  end
end
