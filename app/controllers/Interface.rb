#!/usr/bin/env ruby

require 'Node.rb'
require 'Attribute.rb'

class Interface < Node
    attr_accessor :name, :type, :attributes

    def initialize(name, type='Interface')
        super(name, type)
        @attributes = Array.new(2)

        @attributes[0] = Attribute.new("bit_rate", 100000000)
        @attributes[1] = Attribute.new("latency", 0)
    end
end
