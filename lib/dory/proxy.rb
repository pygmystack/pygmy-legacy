require_relative 'docker_service'

module Dory
  class Proxy
    extend Dory::DockerService

    def self.dinghy_http_proxy_image_name
      'codekitchen/dinghy-http-proxy:2.0.3'
    end

    def self.container_name
      Dory::Config.settings[:dory][:nginx_proxy][:container_name]
    end

    def self.run_cmd
      "docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock -e " \
      "'CONTAINER_NAME=#{self.container_name}' --name " \
      "'#{self.container_name}' #{dinghy_http_proxy_image_name}"
    end
  end
end
