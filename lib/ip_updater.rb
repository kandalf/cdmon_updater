require 'socket'
require 'net/http'
require 'net/https'
require 'config'
require 'resolv'
require 'cdmon'

#include Config
#include CDMon
module CDMon
  class IPUpdater
     def initialize
     @resolver = Resolv::DNS.new(:nameserver => Config.dns_names, :search => ["localhost"], :dots => 1)
     CDMon.log_level = "DEBUG"
    end

     def update
      url = URI.parse(Config.service_url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == 'https')

      request = Net::HTTP::Get.new(Config.get_cdmon_ip_path)
#require 'debug'
       begin
       Config.hosts.each do |host|
         host_ip_by_cdmon = @resolver.getaddress(host).to_s
         values = parse_response(http.request(request).body)
         current_cdmon_ip = values["newip"] if values.has_key?("newip")
       
         unless host_ip_by_cdmon == current_cdmon_ip
           request = Net::HTTP::Get.new(Config.cdmon_ip_path_for(current_cdmon_ip))
           response = parse_response(http.request(request).body)
            case response["resultat"]
             when Config::CDMON_OK_IP
               CDMon.logger.info("IP Succesfully updated")
               CDMon.logger.debug("IP Succesfully updated")
             when Config::CDMON_BAD_IP
               CDMon.logger.info("Bad IP Provided")
               CDMon.logger.debug("Bad IP Provided")
             when Config::CDMON_ERROR_LOGIN
               CDMon.logger.info("Login Error")
               CDMon.logger.debug("Login Error")
           end
          end
        end
      rescue SocketError
       CDMon.logger.debug("SocketError: Probably the internet connection is broken")
      rescue Resolv::ResolvError
        CDMon.logger.debug("ResolvError: Cannot get DNS results")
      end

    end

    private 
    def parse_response(response)
     values = response.split("&")
     pairs = {}
     values.each do |val|
       key_val = val.split("=")
       pairs[key_val[0]] = key_val[1]
     end
     pairs
    end
  end

end
