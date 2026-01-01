
require 'rdiscount'

before_broadcast_filter do |m|
  m.xhtml_body = RDiscount.new(m.xhtml_body).to_html
  m.xhtml_body.gsub!('<code>', '<font face="monospace">')
  m.xhtml_body.gsub!('</code>', '</font>')
end
