#!/usr/bin/env ruby

require './Node.rb'
require './Attribute.rb'
require './Ref.rb'

class Link < Node
    attr_accessor :attributes, :refs

    def initialize(name, type='Link')
        super(name, type)
        @attributes = Array.new(2)
        @refs        = Array.new(2)
    end

    def to_json(*a)
        {
            "source" => @refs[0].name,
            "target" => @refs[1].name
        }.to_json(*a)
    end
end
