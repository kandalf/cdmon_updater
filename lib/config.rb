require 'yaml'

module Config
  USER = "cdmon_host_user"
  MD5PASS = "cdmon_crypted_user_pass"
  EMAIL = "root@server"
  HOSTS = %w"kandalf.com.ar blog.kandalf.com.ar"
  DNS_NAMES = ["dinamic1.cdmon.net"]

  CDMON_OK_IP = "customok"
  CDMON_BAD_IP = "badip"
  CDMON_ERROR_LOGIN = "errorlogin"

  @@config = {}

  def self.load(config_file)
    @@config = YAML::load_file(config_file)
  end

  def self.log_level
    @@config["general"]["log_level"] if @@config
  end

  def self.users
    @@config["users"]
  end

  def self.mailer
    @@config["mailer"]
  end

  def self.md5_password_for(user)
    @@config["users"][user.to_s]["md5pass"] if @@config
  end

  def self.hosts_for(user)
    @@config["users"][user.to_s]["hosts"].split(" ") if @@config
  end

  def self.dns
    @@config["general"]["dns"] if @@config
  end

  def self.hosts
    HOSTS
  end

  def self.service_url
    @@config["general"]["service_url"] if @@config
  end

  def self.get_cdmon_ip_path_for(user)
    "/onlineService.php?enctype=MD5&n=#{user.to_s}&p=#{self.md5_password_for(user)}"
  end

  def self.cdmon_ip_path_for(user, address)
    "/onlineService.php?enctype=MD5&n=#{user.to_s}&p=#{self.md5_password_for(user)}&cip=#{address}"
  end

end
