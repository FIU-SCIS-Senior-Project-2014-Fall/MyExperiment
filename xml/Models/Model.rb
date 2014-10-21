#!/usr/bin/env ruby

require './Host.rb'
require './Router.rb'
require './Link.rb'
require './Ref.rb'
require './Replica.rb'

require 'json'
require 'active_support/core_ext'

class Model
    attr_accessor :hosts, :routers, :links, :replicas, :type

    def initialize(numberOfHosts, type)
        @hosts   = Array.new(numberOfHosts)
        @type    = type
    end
end
