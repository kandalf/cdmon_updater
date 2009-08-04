require 'logger'

module CDMon

  def self.logger
    @@logger ||= 
      begin
        @@logger = Logger.new("/var/log/cdmon.log", 10, 1024000)
      rescue Errno::EACCES
        @@logger = Logger.new("#{ENV["HOME"]}/.cdmon.log")
      end
      @@logger
  end
  
  def self.log_level=(level)
    case level
      when "WARN"
        logger.level = Logger::WARN
      when "INFO"
        logger.level = Logger::INFO
      when "ERROR"
        logger.level = Logger::ERROR
      when "FATAL"
        logger.level = Logger::FATAL
      when "DEBUG"
        logger.level = Logger::DEBUG
    end
  end

end
