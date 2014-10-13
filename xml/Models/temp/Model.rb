#!/usr/bin/env ruby

class Model
    attr_accessor :hosts, :routers, :links, :replicas, :type

    def initialize(numberOfHosts, type)
        @hosts   = Array.new(numberOfHosts)
        @type    = type
    end
end
