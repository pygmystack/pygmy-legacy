require 'colorize'

module Pygmy
  module Resolv
    def self.common_resolv_file
      '/etc/resolv.conf'
    end

    def self.ubuntu_resolv_file
      #'/etc/resolvconf/resolv.conf.d/base'
      # For now, use the common_resolv_file
      self.common_resolv_file
    end

    def self.file_comment
      '# added by pygmy'
    end

    def self.nameserver
      "127.0.0.1"
    end

    def self.file_nameserver_line
      "nameserver #{self.nameserver}"
    end

    def self.nameserver_contents
      "#{self.file_nameserver_line}  #{self.file_comment}"
    end

    def self.resolv_file
      if Linux.ubuntu?
        return self.ubuntu_resolv_file if Linux.ubuntu?
      elsif Linux.fedora? || Linux.arch? || File.exist?(self.common_resolv_file)
        return self.common_resolv_file
      else
        raise RuntimeError.new(
          "Unable to determine location of resolv file"
        )
      end
    end

    def self.configure
      # we want to be the first nameserver in the list for performance reasons
      # we only want to add the nameserver if it isn't already there
      prev_conts = self.resolv_file_contents
      unless self.contents_has_our_nameserver?(prev_conts)
        if prev_conts =~ /nameserver/
          prev_conts.sub!(/nameserver/, "#{self.nameserver_contents}\nnameserver")
        else
          prev_conts = "#{prev_conts}\n#{self.nameserver_contents}"
        end
        prev_conts.gsub!(/\s+$/, '')
        self.write_to_file(prev_conts)
      end
      self.has_our_nameserver?
    end

    def self.clean
      prev_conts = self.resolv_file_contents
      if self.contents_has_our_nameserver?(prev_conts)
        prev_conts.gsub!(/#{Regexp.escape(self.nameserver_contents + "\n")}/, '')
        prev_conts.gsub!(/\s+$/, '')
        self.write_to_file(prev_conts)
      end
      !self.has_our_nameserver?
    end

    def self.write_to_file(contents)
      # have to use this hack cuz we don't run as root :-(
      puts "Requesting sudo to write to #{self.resolv_file}".green
      Bash.run_command("echo -e '#{contents}' | sudo tee #{Shellwords.escape(self.resolv_file)} >/dev/null")
    end

    def self.resolv_file_contents
      File.read(self.resolv_file)
    end

    def self.has_our_nameserver?
      self.contents_has_our_nameserver?(self.resolv_file_contents)
    end

    def self.contents_has_our_nameserver?(contents)
     !!((contents =~ /#{self.file_comment}/) || (contents =~ /#{self.file_nameserver_line}/))
    end
  end
end
