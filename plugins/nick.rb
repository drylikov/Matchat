
augment_dsl do
  def nick(jid)
    members[jid][:nick] || jid.node
  end

  def set_nick(jid, nick)
    members[jid][:nick] = nick
  end
end

before_broadcast_filter do |m|
  m.body = "[#{nick m.from}] #{m.body}"
  m.xhtml_body = "[#{nick m.from}] #{m.xhtml_body}"
end

message :body => /^\/(?:nick|alias) (.+)$/ do |m|
  nick = /^\/(?:nick|alias) (.+)$/.match(m.body)[1]
  old_nick = nick m.from
  set_nick m.from, nick
  send_to members, "#{old_nick} changed their nick to #{nick}"
  halt
end
