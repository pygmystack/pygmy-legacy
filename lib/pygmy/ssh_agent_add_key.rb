module Pygmy
  class SshAgentAddKey
    def self.image_name
      'amazeeio/ssh-agent'
    end

    def self.container_name
      'amazeeio-ssh-agent-add-key'
    end

    def self.add_ssh_key(key = "#{Dir.home}/.ssh/id_rsa")
      if File.file?(key)
        system("docker run --rm -it " \
        "--volume=#{key}:/#{key} " \
        "--volumes-from=amazeeio-ssh-agent " \
        "--name=#{Shellwords.escape(self.container_name)} " \
        "#{Shellwords.escape(self.image_name)} " \
        "ssh-add #{key}")
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
