
message :body => /^\/(space)?dicks\s*([\d])*\s*$/ do |m|
  matches = /^\/(space)?dicks\s*([\d]*)\s*$/.match(m.body)
  length = matches[2].length > 0 ? matches[2].to_i : (3 + rand(7))
  prefix = matches[1] ? ' %%>' : ''
  suffix = (rand(2) == 1)? ' ~o' : ''
  send_to members, "[#{nick m.from}] #{prefix}8#{'=' * length}D#{suffix}"
end
