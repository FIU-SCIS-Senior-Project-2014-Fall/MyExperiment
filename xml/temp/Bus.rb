#!/usr/bin/env ruby

require './Model.rb'
require './Host.rb'
require './Router.rb'
require './Link.rb'
require './Replica.rb'

class Bus < Model
    def initialize(numberOfHosts, type='Bus')
        super(numberOfHosts, type)
        @routers     = Array.new(numberOfHosts-1)
        @links       = Array.new(@routers.length*2)
        @replicas    = Array.new(1)
    end

    def addHosts
        for i in 1..@hosts.length
            if i != 1 && i != @hosts.length
                @hosts[i] = Host.new("h#{i}", 2)
            else
                @hosts[i] = Host.new("h#{i}", 1)
            end
        end
    end

    def addRouters
        for i in 1..@routers.length
            @routers[i] = Router.new()
        end
    end

    def addLinks
        for i in 1..@links.length
            @links[i] = Link.new()
        end
    end

    def addReplicas
        for i in 1..@replicas.length
            @replicas[i] = Replica.new()
        end
    end
end
