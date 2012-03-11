require 'spec_helper'
require File.dirname(__FILE__) + '/../lib/cdmon_updater/mailer'

describe CDMonUpdater::Mailer do

  before(:all) do
    server_options = {"server" => {"address" => "some.smtp.server", "port" => 25, "user_name" => "user", "password" => "smtp_password"}}
    
    @mailer = CDMonUpdater::Mailer.new(server_options)
  end

  it "should have class options set" do
    CDMonUpdater::Mailer.address.should == "some.smtp.server"
    CDMonUpdater::Mailer.port.should == 25
    CDMonUpdater::Mailer.credentials[:user_name].should == "user"
    CDMonUpdater::Mailer.credentials[:password].should == "smtp_password"
  end

  it "should have instance attributes" do
    @mailer.subject = "Test Mail"
    @mailer.message = "This is the body of the message"
    @mailer.from = "someuser@someserver.com"
    @mailer.to = "someotheruser@someserver.com"
    @mailer.stub!(:send_mail).and_return(true)
    @mailer.send_mail.should be_true
  end

  it "should send mail" do
    "This is a stub left in blank since I can't publish my smtp access data".should_not be_nil
    "You should fill your own data on ../config/cdmon.yml".should_not be_nil
    #Config.load("../config/cdmon.yml")

    #@mailer = CDMon::Mailer.new({"server" => Config.mailer})
    #@mailer.subject = "Test Mail"
    #@mailer.message = "This is the body of the message"
    #@mailer.from = "cdmon_updater@kandalf.com.ar"
    #@mailer.to = "some_real_address@some_server.com"
    #@mailer.send_mail.should be_true
  end
end
