require_relative 'docker_service'

module Dory
  class Dnsmasq
    extend Dory::DockerService

    def self.dnsmasq_image_name
      'freedomben/dory-dnsmasq'
    end

    def self.container_name
      Dory::Config.settings[:dory][:dnsmasq][:container_name]
    end

    def self.domain
      Dory::Config.settings[:dory][:dnsmasq][:domain]
    end

    def self.addr
      Dory::Config.settings[:dory][:dnsmasq][:address]
    end

    def self.run_cmd(domain = self.domain, addr = self.addr)
      "docker run -d -p 53:53/tcp -p 53:53/udp --name=#{Shellwords.escape(self.container_name)} " \
      "--cap-add=NET_ADMIN #{Shellwords.escape(self.dnsmasq_image_name)} " \
      "#{Shellwords.escape(self.domain)} #{Shellwords.escape(self.addr)}"
    end
  end
end
