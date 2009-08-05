module Config
  USER = "cdmon_host_user"
  MD5PASS = "cdmon_crypted_user_pass"
  EMAIL = "root@server"
  HOSTS = %w"kandalf.com.ar blog.kandalf.com.ar"
  DNS_NAMES = ["dinamic1.cdmon.net"]

  CDMON_OK_IP = "customok"
  CDMON_BAD_IP = "badip"
  CDMON_ERROR_LOGIN = "errorlogin"

  def self.user
    USER
  end

  def self.md5_password
    MD5PASS
  end

  def self.dns_names
    DNS_NAMES
  end

  def self.hosts
    HOSTS
  end

  def self.service_url
    "https://dinamico.cdmon.org/onlineService.php"  
  end

  def self.get_cdmon_ip_path
    "/onlineService.php?enctype=MD5&n=#{self.user}&p=#{self.md5_password}"
  end

  def self.cdmon_ip_path_for(address)
    "/onlineService.php?enctype=MD5&n=#{self.user}&p=#{self.md5_password}&cip=#{address}"
  end

end
