#!/usr/bin/env ruby

require './Node.rb'
require './Interface/rb'

class Host < Node
    attr_accessor :interfaces

    def initialize(name, numberOfInterfaces, type='Host')
        super(name, type)
        @interfaces = Array.new(numberOfInterfaces)

        for i in 1..numberOfInterfaces
            @interfaces[i] = Interface.new("if_#{i-1}")
        end
    end
end
