require_relative 'docker_service'

module Pygmy
  class Haproxy
    extend Pygmy::DockerService

    def self.image_name
      'amazeeio/haproxy'
    end

    def self.container_name
      'amazeeio-haproxy'
    end

    def self.run_cmd
      "docker run -d " \
      "-p 80:80 -p 443:443 " \
      "--volume=/var/run/docker.sock:/tmp/docker.sock " \
      "--restart=always " \
      "--name=#{Shellwords.escape(self.container_name)} " \
      "#{Shellwords.escape(self.image_name)}"
    end
  end
end
