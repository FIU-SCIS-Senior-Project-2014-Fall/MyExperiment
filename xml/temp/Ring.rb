#!/usr/bin/env ruby

class Ring < Model
    def initialize(numberOfhosts)
        super(numberOfHosts)
        @routers = Array.new(numberOfHosts)
        @links   = Array.new(@hosts.length*2)
        @subs    = Array.new(@hosts.length)
    end
end
