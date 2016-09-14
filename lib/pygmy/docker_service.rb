require 'shellwords'

module Pygmy
  module DockerService
    def start
      unless self.running?
        success = if self.container_exists?
                    Sh.run_command(self.start_cmd).success?
                  else
                    Sh.run_command(self.run_cmd).success?
                  end
        unless success
          raise RuntimeError.new(
            "Failed to run #{self.container_name}.  Command #{self.run_cmd} failed"
          )
        end
      end
      self.running?
    end

    def pull
      puts "Pulling Docker Image #{Shellwords.escape(self.image_name)}".yellow
      success = Sh.run_command("docker pull #{Shellwords.escape(self.image_name)}").success?
      unless success
        raise RuntimeError.new(
          "Failed to update #{self.container_name}.  Command #{self.pull_cmd} failed"
        )
      end
    end

    def running?(container_name = self.container_name)
      !!(self.ps =~ /#{container_name}/)
    end

    def container_exists?(container_name = self.container_name)
      !!(self.ps(true) =~ /#{container_name}/)
    end

    def ps(all = false)
      cmd = "docker ps#{all ? ' -a' : ''}"
      ret = Sh.run_command(cmd)
      if ret.success?
        return ret.stdout
      else
        raise RuntimeError.new("Failure running command '#{cmd}'")
      end
    end

    def has_docker_client?
      Sh.run_command('which docker').success?
    end

    def stop(container_name = self.container_name)
      Sh.run_command("docker stop -t 1 #{Shellwords.escape(container_name)}") if self.running?
      !self.running?
    end

    def delete(container_name = self.container_name)
      if self.container_exists?
        self.stop if self.running?
        Sh.run_command("docker rm #{Shellwords.escape(container_name)}")
      end
      !self.container_exists?
    end

    def start_cmd
      "docker start #{Shellwords.escape(self.container_name)}"
    end
  end
end
