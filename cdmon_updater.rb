#!/usr/bin/ruby

$:<< "lib/"
require 'ip_updater'

updater = CDMon::IPUpdater.new

updater.update
