require_relative 'docker_service'

module Pygmy
  class Dnsmasq
    extend Pygmy::DockerService

    def self.image_name
      'andyshinn/dnsmasq:2.78'
    end

    def self.container_name
      'amazeeio-dnsmasq'
    end

    def self.domain
      'docker.amazee.io'
    end

    def self.addr
      '127.0.0.1'
    end

    def self.run_cmd(domain = self.domain, addr = self.addr)
      "docker run -d -p 6053:53/tcp -p 6053:53/udp --name=#{Shellwords.escape(self.container_name)} " \
      "--cap-add=NET_ADMIN #{Shellwords.escape(self.image_name)} -A /#{Shellwords.escape(domain)}/#{Shellwords.escape(addr)}"
    end
  end
end
