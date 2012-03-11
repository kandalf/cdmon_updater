require 'net/smtp'

module CDMonUpdater
  class Mailer < Net::SMTP
    attr_accessor :subject, :message, :from, :to

    if Config.mailer
      @@address = Config.mailer["address"]
      @@port = Config.mailer["port"]
      @@domain = Config.mailer["domain"]
      @@credentials[:user_name] = Config.mailer["user_name"]
      @@credentials[:password] = Config.mailer["password"]
    else
      @@address = nil
      @@port = nil
      @@credentials = {:user_name => nil, :password => nil}
    end

    def initialize(options = {})
      if options.has_key?("server") && options["server"].is_a?(Hash) && options["server"].keys.any?
        server_options = options.delete("server")

        @@address = server_options["address"]
        @@port = server_options["port"]
        @@domain = server_options["domain"]
        @@credentials[:user_name] = server_options["user_name"]
        @@credentials[:password] = server_options["password"]
      end
    end

    #class methods
    def self.address
      @@address
    end
    def self.address=(address)
      @@address = address
    end
    
    def self.port
      @@port
    end
    def self.port=(port)
      @@port = port
    end
  
    def self.domain
      @@domain
    end
    def self.domain=(domain)
      @@domain = domain
    end
    def self.credentials
      @@credentials
    end
    def self.credentials=(data = {:user_name => nil, :password => nil})
      @@credentials = data
    end

    #instance methods
    def send_mail
      body = mail_headers
      body << "#{Time.now.to_s} - #{@message}"

      begin
        @to.split(",").each do | to |

            Net::SMTP.start(@@address, @@port, @from, @@credentials[:user_name], @@credentials[:password], :login)  do |smtp|
              
              smtp.send_message(body, @from, to.strip)

            end
         end
         true
       rescue
        CDMon.log_all("Cannot send email")
        false
       end
    end

    private
    def mail_headers
      body =  "From: #{@from} <#{@from}>\n" 
      body << "To: #{@to}<#{@to}>\n"
      body << "Subject: #{@subject}\n"
      body << "Date: #{Time.now}\n"
      body << "Importance:high\n"
      body << "MIME-Version:1.0\n"
      body << "\n\n\n"
      body
    end
  end
end
