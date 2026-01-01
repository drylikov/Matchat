
require File.join(File.dirname(__FILE__), *%w[matchat room])

room = Matchat::Room.new ENV['JABBER_JID'], ENV['JABBER_PASSWORD'], ENV['JABBER_HOST'], ENV['MEMBERS'].split
room.run
