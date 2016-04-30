require_relative 'docker_service'

module Pygmy
  class SshAgent
    extend Pygmy::DockerService

    def self.image_name
      'amazeeio/ssh-agent'
    end

    def self.container_name
      'amazeeio-ssh-agent'
    end

    def self.run_cmd()
      "docker run -d " \
      "--restart=always " \
      "--name=#{Shellwords.escape(self.container_name)} " \
      "#{Shellwords.escape(self.image_name)}"
    end
  end
end
