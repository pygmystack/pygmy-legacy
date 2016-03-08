require 'yaml'

module Dory
  class Config
    def self.filename
      "#{Dir.home}/.dory.yml"
    end

    def self.default_yaml
      %q(---
        :dory:
          # Be careful if you change the settings of some of
          # these services.  They may not talk to each other
          # if you change IP Addresses.
          # For example, resolv expects a nameserver listening at
          # the specified address.  dnsmasq normally does this,
          # but if you disable dnsmasq, it
          # will make your system look for a name server that
          # doesn't exist.
          :dnsmasq:
            :enabled: true
            :domain: docker      # domain that will be listened for
            :address: 127.0.0.1  # address returned for queries against domain
            :container_name: dory_dnsmasq
          :nginx_proxy:
            :enabled: true
            :container_name: dory_dinghy_http_proxy
          :resolv:
            :enabled: true
            :nameserver: 127.0.0.1
      ).split("\n").map{|s| s.sub(' ' * 8, '')}.join("\n")
    end

    def self.default_settings
      YAML.load(self.default_yaml)
    end

    def self.settings(filename = self.filename)
      if File.exist?(filename)
        self.default_settings.merge(YAML.load_file(filename))
      else
        self.default_settings
      end
    end

    def self.write_settings(settings, filename = self.filename)
      File.write(filename, settings)
    end

    def self.write_default_settings_file(filename = self.filename)
      self.write_settings(self.default_yaml, filename)
    end
  end
end
