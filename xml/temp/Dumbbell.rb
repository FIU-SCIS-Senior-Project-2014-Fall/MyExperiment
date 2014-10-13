#!/usr/bin/env ruby

class Dumbbell < Model
    def initialize(numberOfHosts)
        super(numberOfHosts)
        @routers = Array.new(2)
        @links   = Array.new((@hosts.length*2)+1)
        @subs    = Array.new(2)
    end
end
