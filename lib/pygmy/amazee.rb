require_relative 'docker_service'
require 'colorize'

module Pygmy
  class Amazee
    extend Pygmy::DockerService

    def self.prefix
      "amazeeio/"
    end

    def self.ignore_list
      %w(none ssh-agent haproxy)
    end

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
      cmd = 'docker image ls --format "{{.Repository}}:{{.Tag}}"'
      list = Sh.run_command(cmd)

      # For better handling of containers, we should compare our
      # results against a whitelist instead of preferential
      # treatment of linux pipes.
      containers = list.stdout.split("\n")
      amazee_containers = []
      containers.each do |container|
        # Selectively target amazeeio/* images.
        if container.include?(self.prefix)
          include_container = true
          # Filter out items which we don't want.
          self.ignore_list.each do |item|
            if container.include?(item)
              include_container = false
            end
          end
          amazee_containers.push(container) if include_container
        end
      end
      amazee_containers
    end

    def self.pull_all
      list = self.ls_cmd
      unless list.nil?
        list.each do |image|
          self.pull(image)
        end
      end
    end

  end
end
