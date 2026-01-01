
subscription :request? do |s|
  write_to_stream s.approve!
end
