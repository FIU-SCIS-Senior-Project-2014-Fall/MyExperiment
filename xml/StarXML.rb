#!/usr/bin/env ruby

require 'nokogiri'
require 'json'
require 'active_support/core_ext'

class StarXML
    attr_accessor :output

    def initialize()
        @hosts   = ARGV.first.to_i
        @routers = 1
        @links   = @hosts

        @hosts   = 1..@hosts
        @links   = 1..@links
    end

    def buildXML
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
            xml.model(:'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema_instance', :'xsi:noNamespaceSchemaLocation' => 'primex.xsd'){
                xml.node(:name => 'topNet', :type => 'Net') {
                    xml.node(:name => 'routing', :type => 'ShortestPath') {}
                    xml.node(:name => 'sub1', :type => 'Net') {
                        xml.node(:name => 'routing', :type => 'ShortestPath') {}

                        # add hosts
                        for i in @hosts
                            xml.node(:name => "h#{i}", :type => 'Host') {
                                xml.node(:name => 'if_0', :type => 'Interface') {
                                    xml.attribute(:name => 'bit_rate', :value => '100000000') {}
                                    xml.attribute(:name => 'latency', :value => '0') {}
                                }
                            }
                        end
                        
                        # add routers
                        xml.node(:name => "r1", :type => 'Router') {

                            for i in @hosts
                                xml.node(:name => "if_h#{i}", :type => 'Interface') {
                                    xml.attribute(:name => 'bit_rate', :value => '100000000') {}
                                    xml.attribute(:name => 'latency', :value => '0') {}
                                }
                            end

                            xml.node(:name => 'if_gateway', :type => 'Interface') {
                                xml.attribute(:name => 'bit_rate', :value => '100000000') {}
                                xml.attribute(:name => 'latency', :value => '0') {}
                            }
                        }
                        
                        # add links
                        for i in @links
                            xml.node(:name => "l_h#{i}", :type => 'Link') {
                                xml.attribute(:name => 'bandwidth', :value => '100000000') {}
                                xml.attribute(:name => 'delay', :value => '1') {}
                                xml.ref(:name => "r1", :path => "..:r1:if_h#{i}") {}
                                xml.ref(:name => "h#{i}", :path => "..:h#{i}:if_0") {}
                            }
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
        #j = JSON.pretty_generate(Hash.from_xml("#{output}")) 
        #puts "#{j}"
    end

    def writeXML
        filename = "starWith#{@hosts.max}Nodes.xml"
        target = open(filename, 'w')
        target.write("#{output}")
    end
end

if __FILE__ == $0
    bx = StarXML.new()
    bx.buildXML
    #bx.printXML
    bx.writeXML
end
