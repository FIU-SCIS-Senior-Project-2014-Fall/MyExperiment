#!/usr/bin/env ruby

class Node
    attr_accessor :name, :type

    def initialize(name, type)
        @name = name
        @type = type
    end
end
