module Dory
  module Linux
    def self.bash(command)
      system("bash -c '#{command}'")
    end

    def self.ubuntu?
      self.bash(self.ubuntu_cmd)
    end

    def self.fedora?
      self.bash(self.fedora_cmd)
    end

    def self.arch?
      self.bash(self.arch_cmd)
    end

		def self.osx?
      self.bash('uname -a | grep "Darwin" > /dev/null')
		end

    def self.ubuntu_cmd
      %q(
        if $(which lsb_release >/dev/null 2>&1); then
            lsb_release -d | grep --color=auto "Ubuntu" > /dev/null
        else
            uname -a | grep --color=auto "Ubuntu" > /dev/null
        fi
      )
    end

    def self.fedora_cmd
     %q(
        if $(which lsb_release >/dev/null 2>&1); then
            lsb_release -d | grep --color=auto "Fedora" > /dev/null
        else
            uname -r | grep --color=auto "fc" > /dev/null
        fi
      )
    end

    def self.arch_cmd
     %q(
        if $(which lsb_release >/dev/null 2>&1); then
            lsb_release -d | grep --color=auto "Arch" > /dev/null
        else
            uname -a | grep --color=auto "ARCH" > /dev/null
        fi
      )
    end
  end
end
