#!/usr/bin/env ruby

require './Node.rb'
require './Interface.rb'

require 'json'

class Host < Node
    attr_accessor :interfaces

    def initialize(name, numberOfInterfaces, type='Host')
        super(name, type)
        @interfaces = Array.new(numberOfInterfaces)

        for i in 0..numberOfInterfaces-1
            @interfaces[i] = Interface.new("if_#{i}")
        end
    end
end
