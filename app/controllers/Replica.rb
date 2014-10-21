#!/usr/bin/env ruby

class Replica
    attr_accessor :name, :path

    def initialize(name, path)
        @name = name
        @path = path
    end
end
