
require 'blather/jid'

def keyify(jid)
  Blather::JID.new(jid).stripped.to_s
end

module Matchat
  class MembershipList < Hash
    def initialize(vals)
      case vals
      when Array
        super()
        vals.each { |x| self[x] = {} }
      else
        super()
        self.merge(vals)
      end
    end

    def [](key)
      super(keyify(key))
    end

    def []=(key, val)
      super(keyify(key), val)
    end

    def except(key)
      result = dup
      result.delete(keyify(key))
      result
    end
  end
end
