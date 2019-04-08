module Pygmy
  class SshAgentAddKey
    def self.image_name
      'amazeeio/ssh-agent'
    end

    def self.container_name
      'amazeeio-ssh-agent-add-key'
    end

    def self.add_ssh_key(key = "#{Dir.home}/.ssh/id_rsa")
      if Gem.win_platform?
        key_agent = "windows-key-add"
        key_destination = "/key"
      else
        key_agent = "ssh-add"
        key_destination = "/#{key}"
      end
      if File.file?(key)
        system("docker run --rm -it " \
        "--volume=#{key}:#{key_destination} " \
        "--volumes-from=amazeeio-ssh-agent " \
        "--name=#{Shellwords.escape(self.container_name)} " \
        "#{Shellwords.escape(self.image_name)} " \
        "#{key_agent} #{key_destination}")
      else
        puts "ssh key: #{key}, does not exist, ignoring...".yellow
        return false
      end
    end

    def self.show_ssh_keys
      system("docker run --rm -it " \
      "--volumes-from=amazeeio-ssh-agent " \
      "--name=#{Shellwords.escape(self.container_name)} " \
      "#{Shellwords.escape(self.image_name)} " \
      "ssh-add -l")
    end

  end
end
