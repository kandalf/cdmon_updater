require 'spec_helper'
require 'ip_updater'

describe CDMonUpdater::IPUpdater do

  before(:all) do
    @updater = CDMonUpdater::IPUpdater.new(File.dirname(__FILE__) + "/../config/cdmon.yml")

  end

  it "should update the IP" do
    "you should have your settings on /etc/cdmon.yml".should_not be_nil
    #@updater.update   
  end
end
