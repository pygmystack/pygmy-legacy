module Pygmy
  class SshAgentAddKey
    def self.image_name
      'amazeeio/ssh-agent'
    end

    def self.container_name
      'amazeeio-ssh-agent-add-key'
    end

    def self.add_ssh_key(key = "$HOME/.ssh/id_rsa")
      system("docker run --rm -it " \
      "--volume=#{key}:/#{key} " \
      "--volumes-from=amazeeio-ssh-agent " \
      "--name=#{Shellwords.escape(self.container_name)} " \
      "#{Shellwords.escape(self.image_name)} " \
      "ssh-add #{key}")
    end
  end
end
