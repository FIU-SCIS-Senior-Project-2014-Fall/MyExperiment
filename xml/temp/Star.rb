#!/usr/bin/env ruby

class Star < Model
    def initialize(numberOfHosts)
        super(numberOfHosts)
        @routers = Array.new(1)
        @links   = Array.new(@hosts.length)
        @subs    = Array.new(1)
    end
end
