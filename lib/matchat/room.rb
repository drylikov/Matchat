
require 'blather/client/dsl'

require File.join(File.dirname(__FILE__), 'dsl')
require File.join(File.dirname(__FILE__), 'membership_list')

module Matchat
  class Room
    include Blather::DSL
    include DSL

    attr_accessor :members

    def initialize(username, password, host, members)
      setup username, password, host
      @members = MembershipList.new members
    end

    def run
      Dir[File.join(File.dirname(__FILE__), %w(.. .. plugins *.rb))].each do |file|
        instance_eval(File.read(file), file)
      end

      # Notify us when we succesfully connect
      when_ready { puts "Connected! Send messages to #{jid.stripped}." }

      before :message do |s|
        halt if members[s.from].nil?
      end

      # Finally, register our default broadcast handler
      message :chat?, :body do |m|
        message = Struct.new(:from, :body, :xhtml_body, :dest).new(m.from, m.body, m.body, members)

        before_filters.each do |f|
          begin
            f.call message
          rescue StandardError => e
            send_to message.from, <<-EOF
              Message processing raised exception #{e.message}

              #{e.backtrace.join("\n")}
            EOF
            halt
          end
        end

        send_to message.dest.except(message.from), message.body, message.xhtml_body
      end

      # Now that we're all set up, start the client
      EM.run { client.run }
    end
  end
end
