require_relative 'docker_service'

module Pygmy
  class Mailhog
    extend Pygmy::DockerService

    def self.image_name
      'mailhog/mailhog'
    end

    def self.container_name
      'mailhog.docker.amazee.io'
    end

    def self.domain
      'docker.amazee.io'
    end

    def self.addr
      '127.0.0.1'
    end

    def self.run_cmd(domain = self.domain, addr = self.addr)
      "docker run --restart=always -d -p 1025:1025 --expose 80 -u 0 --name=#{Shellwords.escape(self.container_name)} " \
      '-e "MH_UI_BIND_ADDR=0.0.0.0:80" ' \
      '-e "MH_API_BIND_ADDR=0.0.0.0:80" ' \
      '-e "AMAZEEIO=AMAZEEIO" ' \
      "#{Shellwords.escape(self.image_name)}"
    end
  end
end

