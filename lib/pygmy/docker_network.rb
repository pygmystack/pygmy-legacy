require_relative 'docker_service'

module Pygmy
  class DockerNetwork
    extend Pygmy::DockerService

    def self.network_name
      'amazeeio-network'
    end

    def self.haproxy_name
      'amazeeio-haproxy'
    end

    def self.create_cmd
      "docker network create #{self.network_name}"
    end

    def self.connect_haproxy_cmd
      "docker network connect #{self.network_name} #{self.haproxy_name}"
    end

    def self.create
      unless self.exists?
        unless Sh.run_command(self.create_cmd).success?
          raise RuntimeError.new(
            "Failed to create #{self.network_name}.  Command #{self.create_cmd} failed"
          )
        end
      end
      self.exists?
    end

    def self.connect
      unless self.haproxy_connected?
        unless Sh.run_command(self.connect_haproxy_cmd).success?
          raise RuntimeError.new(
            "Failed to connect #{self.haproxy_name} to #{self.network_name}.  Command #{self.connect_haproxy_cmd} failed"
          )
        end
      end
      self.haproxy_connected?
    end

    def self.haproxy_connected?(network_name = self.network_name, haproxy_name = self.haproxy_name)
      !!(self.inspect_containers(network_name) =~ /#{haproxy_name}/)
    end

    def self.exists?(network_name = self.network_name)
      !!(self.ls =~ /#{network_name}/)
    end

    def self.inspect_containers(network_name = self.network_name)
      cmd = "docker network inspect #{self.network_name} -f '{{.Containers}}'"
      ret = Sh.run_command(cmd)
      if ret.success?
        return ret.stdout
      else
        raise RuntimeError.new("Failure running command '#{cmd}'")
      end
    end

    def self.ls
      cmd = "docker network ls"
      ret = Sh.run_command(cmd)
      if ret.success?
        return ret.stdout
      else
        raise RuntimeError.new("Failure running command '#{cmd}'")
      end
    end

  end
end
