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
      "docker run -d -p 53:53/tcp -p 53:53/udp --name=#{self.container_name} " \
      "--cap-add=NET_ADMIN #{self.dnsmasq_image_name} #{self.domain} #{self.addr}"
    end
  end
end
