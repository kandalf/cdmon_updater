require File.dirname(__FILE__) + "/cdmon_updater/version"
require File.dirname(__FILE__) + "/cdmon_updater/config"
require File.dirname(__FILE__) + "/cdmon_updater/mailer"
require "logger"

module CDMonUpdater
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
    case  level
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

  def self.log_all(message)
    logger.info(message)
    logger.debug(message)
    logger.warn(message)
    logger.error(message)
    self.send_error_mail(message) if Config.mail_on_error?
  end

  protected
  def self.send_error_mail(message)
    mailer = Mailer.new({"server" => Config.mailer})
    mailer.from = "cdmon_updater@#{Mailer.domain}"
    mailer.to = Config.mail_to
    mailer.subject = "CDMon Updater ERROR"
    mailer.message = message
    unless mailer.send_mail
      logger.debug("Cannot send mail")
      logger.info("Cannot send mail")
    end
  end
end
