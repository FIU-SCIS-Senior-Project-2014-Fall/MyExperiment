#!/usr/bin/env ruby

class Ref
    attr_accessor :name, :path

    def initialize(name, path)
        @name = name
        @path = path
    end
end
