module Config
  USER = "kandalf"
  MD5PASS = "7522323b8b37875f2749ba6cabd8cc47"
  EMAIL = "root@server"
  HOSTS = %w"kandalf.com.ar blog.kandalf.com.ar"
  DNS_NAMES = %w"dinamic1.cdmon.net dinamic2.cdmon.net dinamic3.cdmon.net"

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
