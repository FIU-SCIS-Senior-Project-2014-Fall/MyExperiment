#!/usr/bin/env ruby

class Attribute
    attr_accessor :name, :value

    def initialize(name, value)
        @name  = name 
        @value = value
    end
end
