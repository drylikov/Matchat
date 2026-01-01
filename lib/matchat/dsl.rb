
module Matchat
  module DSL
    def augment_dsl(method = nil, &block)
      if method.nil?
        self.instance_eval &block
      else
        self.define_singleton_method method, &block
      end
    end

    def send_to(dest, body, xhtml = nil)
      case dest
      when Hash
        dest = dest.keys
      when Array
        dest = dest
      else
        dest = [dest]
      end

      dest.each do |d|
        next unless my_roster[d]
        m = Blather::Stanza::Message.new(d)
        m.body = body
        m.xhtml = xhtml unless xhtml.nil?
        write_to_stream m
      end
    end

    def before_broadcast_filter(&block)
      @filters ||= []
      @filters << block
    end

    def before_filters
      @filters || []
    end
  end
end
