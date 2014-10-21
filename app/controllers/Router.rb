#!/usr/bin/env ruby

require 'Node.rb'
require 'Interface.rb'

class Router < Node
    attr_accessor :interfaces

    def initialize(name, numberOfInterfaces, type='Router')
        super(name, type)
        @interfaces = Array.new(numberOfInterfaces+1)

        for i in 0..numberOfInterfaces-1
            @interfaces[i] = Interface.new("if_h#{i+1}")
            if i == numberOfInterfaces-1
                @interfaces[i] = Interface.new("if_gateway")
            end
        end
    end
end
