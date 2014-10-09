#!/usr/bin/env ruby

require 'nokogiri'
require 'json'
require 'active_support/core_ext'

class BusXML
    attr_accessor :output

    def initialize()
        @hosts   = ARGV.first.to_i
        @routers = @hosts - 1
        @links   = @routers * 2

        @hosts   = 1..@hosts
        @routers = 1..@routers
        @links   = 1..@links
    end

    def buildXML
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
            xml.model(:'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema_instance', :'xsi:noNamespaceSchemaLocation' => 'primex.xsd'){
                xml.node(:name => 'topNet', :type => 'Net') {
                    xml.node(:name => 'routing', :type => 'ShortestPath') {}
                    xml.node(:name => 'sub1', :type => 'Net') {
                        xml.node(:name => 'routing', :type => 'ShortestPath') {}
                        for i in @hosts
                            xml.node(:name => "h#{i}", :type => 'Host') {
                                xml.node(:name => 'if_0', :type => 'Interface') {
                                    xml.attribute(:name => 'bit_rate', :value => '100000000') {}
                                    xml.attribute(:name => 'latency', :value => '0') {}
                                }
                                if i != @hosts.min && i != @hosts.max
                                    xml.node(:name => 'if_1', :type => 'Interface') {
                                        xml.attribute(:name => 'bit_rate', :value => '100000000') {}
                                        xml.attribute(:name => 'latency', :value => '0') {}
                                    }
                                end
                            }
                        end
                        for i in @routers
                            xml.node(:name => "r#{i}", :type => 'Router') {
                                xml.node(:name => "if_h#{i}", :type => 'Interface') {
                                    xml.attribute(:name => 'bit_rate', :value => '100000000') {}
                                    xml.attribute(:name => 'latency', :value => '0') {}
                                }
                                xml.node(:name => "if_h#{i+1}", :type => 'Interface') {
                                    xml.attribute(:name => 'bit_rate', :value => '100000000') {}
                                    xml.attribute(:name => 'latency', :value => '0') {}
                                }
                                xml.node(:name => 'if_gateway', :type => 'Interface') {
                                    xml.attribute(:name => 'bit_rate', :value => '100000000') {}
                                    xml.attribute(:name => 'latency', :value => '0') {}
                                }
                            }
                        end
                        for i in @links
                            if i != @links.min && i != @links.max
                                r = i - (i / 2)
                                h = (i -  (i / 2)) + ((i - 1) % 2) 
                                xml.node(:name => "l_h#{i}_#{i+1}", :type => 'Link') {
                                    xml.attribute(:name => 'bandwidth', :value => '100000000') {}
                                    xml.attribute(:name => 'delay', :value => '1') {}
                                    xml.ref(:name => "r#{r}", :path => "..:r#{r}:if_h#{h}") {}
                                    xml.ref(:name => "h#{h}", :path => "..:h#{h}:if_#{i % 2}") {}
                                }
                            else
                                if i == @links.min
                                    xml.node(:name => "l_h#{@hosts.min}", :type => 'Link') {
                                        xml.attribute(:name => 'bandwidth', :value => '100000000') {}
                                        xml.attribute(:name => 'delay', :value => '1') {}
                                        xml.ref(:name => "r#{@routers.min}", :path => "..:r#{@routers.min}:if_h#{@hosts.min}") {}
                                        xml.ref(:name => "h#{@hosts.min}", :path => "..:h#{@hosts.min}:if_0") {}
                                    }
                                else
                                    xml.node(:name => "l_h#{@hosts.max}", :type => 'Link') {
                                        xml.attribute(:name => 'bandwidth', :value => '100000000') {}
                                        xml.attribute(:name => 'delay', :value => '1') {}
                                        xml.ref(:name => "r#{@routers.max}", :path => "..:r#{@routers.max}:if_h#{@hosts.max}") {}
                                        xml.ref(:name => "h#{@hosts.max}", :path => "..:h#{@hosts.max}:if_0") {}
                                    }
                                end
                            end
                        end
                    }
                }
            }
        end
        @output = builder.to_xml(:indent => 4)
    end

    def printXML
        puts "#{output}"
        puts "\n\n"
        #j = Hash.from_xml("#{output}").to_json
        #puts "#{j}"
        #puts "\n\n"
        j = JSON.pretty_generate(Hash.from_xml("#{output}")) 
        puts "#{j}"
    end
end

if __FILE__ == $0
    bx = BusXML.new()
    bx.buildXML
    bx.printXML
end
