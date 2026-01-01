
require 'chronic_duration'

augment_dsl do
  def snoozing?(jid)
    members[jid][:dnduntil] && members[jid][:dnduntil] > Time.now
  end

  def snooze(jid, snooze)
    members[jid][:dnduntil] = snooze && Time.now + snooze
  end
end

before_broadcast_filter do |m|
  snooze m.from, false

  # Filter anyone out who's currently snoozing
  m.dest = m.dest.reject { |x| snoozing? x }
end

message :body => /^\/(?:snooze|sleep) (.+)$/ do |m|
  duration = ChronicDuration.parse /^\/(?:snooze|sleep) (.+)$/.match(m.body)[1]
  send_to m.from, "Sleeping for #{ChronicDuration.output duration}"
  send_to members.except(m.from), "#{nick(m.from)} sleeping for #{ChronicDuration.output duration}"
  snooze m.from, duration
end
