require_relative 'docker_service'

module Pygmy
  class Amazee
    extend Pygmy::DockerService

    def self.pull(image_name)
      puts "Pulling Docker Image #{Shellwords.escape(image_name)}".yellow
      pull_cmd = "docker pull #{Shellwords.escape(image_name)}"
      success = Sh.run_command(pull_cmd).success?
      unless success
        raise RuntimeError.new(
            "Failed to update #{self.container_name}.  Command #{pull_cmd} failed"
        )
      end
    end

    def self.ls_cmd
      # cmd will not ever report non-0 exit codes, but we will
      # check the results below. This will prevent failures when
      # there are no amazee images pulled and the update command
      # is called. To do this, we add ' | cat' to the end of it.
      cmd = 'docker image ls --format "{{.Repository}}:{{.Tag}}" | grep amazeeio/ | grep -v none | grep -v ssh | grep -v haproxy | cat'
      list = Sh.run_command(cmd)
      unless list.success?
        raise RuntimeError.new(
            "Failed to list amazee docker images.  Command #{cmd} failed"
        )
      end
      list.stdout.split("\n")
    end

    def self.pull_all
      list = self.ls_cmd
      unless list.nil?
        list.each do |image|
          pull(image)
        end
      end
    end

  end
end
