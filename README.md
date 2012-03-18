# CdmonUpdater

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'cdmon_updater'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cdmon_updater

## Usage
After installation you'll have the command cdmon_config. 
Use it with -g or --generate to help you generate your config file.

It will ask your user data and generate the file /etc/cdmon.yml.
If you need to change the settings you can modify the config file 
later with any text editor.
The config file has the following structure:

general:
  dns:          dinamic1.cdmon.net
  email:        root@server
  log_level:    DEBUG
  service_url:  https://dinamico.cdmon.org/onlineService.php
  send_mail_on_error: no

users:
  cdmon_user:
    hosts: kandalf.com.ar blog.kandalf.com.ar
    md5pass: 1278323gfb37875f2749ju6cabd8io89

mailer:
  address: relay.someserver.com.ar
  port: 25
  domain: kandalf.com.ar
  user_name: someuser #without @domain
  password: plain_password

The cdmon_user is the user you have associated in your CDMon control panel with your domains.
As you can have multiple users in CDMon, you can add as many user sections as you need here.

The md5pass should be the user's password crypted as an MD5 hash. 
The cdmon_config script comes will encode your password for you 
when generating the config file. If you later change your password 
on the cdmon control panel, you can encode it using cdmon_config -e or --encode 
and then copy/paste the encoded string into the /etc/cdmon.yml config file.

For mail notification you must activate the the send_mail_on_error feature on 
the general section and properly configure your mail server.
Also, you have to define a valid email address for the email feature on the general section.

When these things are set up, an email will be sent to the email address defined on 
the general section with the message of the error and the time it was raised and 
the subject of "CDMon Updater ERROR".

After you have your settings, you can run the client manually or you can add the following line to your crontab

0/3 * * * * /usr/bin/cdmon_updater

For it to run every 3 minutes.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
