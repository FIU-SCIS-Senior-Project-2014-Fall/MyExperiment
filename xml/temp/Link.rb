#!/usr/bin/env ruby

require './Node.rb'
require './Attribute.rb'
require './Ref.rb'

class Link < Node
    attr_accessor :attributes, :refs

    def initialize(name, type='Link')
        super(name, type)
        @attributes = Array.new(2)
        @ref        = Array.new(2)
end
