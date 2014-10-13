#!/usr/bin/env ruby

class Node
    attr_accessor :name, :type

    def initialize(name, type)
        @name = name
        @type = type
    end

    def to_json(*a)
        {
            "name" => @name,
            "type" => @type
        }.to_json(*a)
    end
end
