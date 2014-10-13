#!/usr/bin/env ruby

require './Node.rb'

class Router < Node
    attr_accessor :interfaces

    def initialize(name, numberOfInterfaces, type='Router')
        super(name, type)
        @interfaces = Array.new(numberOfInterfaces+1)

        for i in 1..numberOfInterfaces
            @interfaces[i] = Interface.new("if_h#{i}")
        end

        @intefaces[numberOfInterfaces+1] = Interface.new("if_gateway")
    end
end
