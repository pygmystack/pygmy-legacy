require_relative 'docker_service'

module Pygmy
  class Portainer
    extend Pygmy::DockerService

    def self.image_name
      'portainer/portainer'
    end

    def self.container_name
      'portainer.docker.amazee.io'
    end

    def self.domain
      'docker.amazee.io'
    end

    def self.addr
      '127.0.0.1'
    end

    def self.run_cmd(domain = self.domain, addr = self.addr)
      "docker volume create portainer_data"
    end

    def self.run_cmd(domain = self.domain, addr = self.addr)
      "docker run --restart=always -d -p 9000:9000 --expose 80 -u 0 --name=#{Shellwords.escape(self.container_name)} " \
      '-v /var/run/docker.sock:/var/run/docker.sock ' \
      '-v portainer_data:/data ' \
      '-e "AMAZEEIO=AMAZEEIO" ' \
      "#{Shellwords.escape(self.image_name)}"
    end
  end
end

