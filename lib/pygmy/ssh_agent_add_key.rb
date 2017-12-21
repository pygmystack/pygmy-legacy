module Pygmy
  class SshAgentAddKey
    def self.image_name
      'amazeeio/ssh-agent'
    end

    def self.container_name
      'amazeeio-ssh-agent-add-key'
    end

    def self.add_ssh_key(key = nil)
      if key
        if File.file?(key)
          if system("docker run --rm -it " \
          "--volume=#{key}:/#{key} " \
          "--volumes-from=amazeeio-ssh-agent " \
          "--name=#{Shellwords.escape(self.container_name)} " \
          "#{Shellwords.escape(self.image_name)} " \
          "ssh-add #{key}")
            puts "Successfully added #{key}".green
            return true
          else
            puts "Error adding #{key}".yellow
            return false
          end
        else
          puts "ssh key: #{key}, does not exist, ignoring...".yellow
          return false
        end
      else
        suggested_keys = ["id_dsa", "id_rsa", "id_rsa1", "id_ecdsa", "id_ed25519"]
        success = true
        Dir.glob("#{Dir.home}/.ssh/id_*").each do |f|
          if suggested_keys.include?(File.basename f)
            success = self.add_ssh_key(f) && success
          end
        end
        return success
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
