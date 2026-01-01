
before_broadcast_filter do |m|
  # Filter anyone out who's ignoring the sending user
  m.dest = m.dest.reject { |x| members[x][:ignores] && members[x][:ignores].include?(m.from) }
end

message :body => /^\/fuckoff (.+)$/ do |m|
  who = /^\/fuckoff (.+)$/.match(m.body)[1]
  send_to m.from, "Ignoring #{who}"
  send_to members.except(m.from), "#{nick(m.from)} ignoring #{who}"
  members[m.from][:ignores] ||= []
  members[m.from][:ignores] << who
end

message :body => /^\/fuckon (.+)$/ do |m|
  who = /^\/fuckon (.+)$/.match(m.body)[1]
  send_to m.from, "No longer ignoring #{who}"
  send_to members.except(m.from), "#{nick(m.from)} no longer ignoring #{who}"
  members[m.from][:ignores].delete who if members[m.from][:ignores]
end
