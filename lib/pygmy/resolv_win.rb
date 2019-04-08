require 'colorize'

module Pygmy
  module ResolvWin

    def self.domain
      "docker.amazee.io"
    end

    def self.create_command
      "Set-ItemProperty -Path HKLM:\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters -Name Domain -Value #{self.domain}"
    end

    def self.remove_command
      "Clear-ItemProperty -Path HKLM:\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters -Name Domain"
    end

    def self.status_command
      "Get-ItemProperty -Path HKLM:\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters"
    end

    def self.create_resolver?
      puts "setting up DNS resolution".green
      PowerShell.run_command(self.create_command)
    end

    def self.clean?
      puts "Removing DNS configuration".green
      PowerShell.run_command(self.remove_command)
    end

    def self.resolver_status?
      status_command = PowerShell.run_command(self.status_command)
      lines = status_command.stdout.split("\n")
      lines.each do |line|
        if line.start_with?("Domain") and line.include?("#{self.domain}")
          return true
        end
      end
      false
    end

  end
end
