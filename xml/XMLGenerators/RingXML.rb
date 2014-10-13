#!/usr/bin/env ruby

require 'nokogiri'
require 'json'
require 'active_support/core_ext'

class RingXML
    attr_accessor :output

    def initialize(numberOfHosts)
        @hosts   = numberOfHosts
        @routers = 1
        @links   = 1
        @subs    = @hosts-1

        @subs    = 2..@subs
    end

    def buildXML
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
            xml.model(:'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema_instance', :'xsi:noNamespaceSchemaLocation' => 'primex.xsd'){
                xml.node(:name => 'topNet', :type => 'Net') {
                    xml.node(:name => 'routing', :type => 'ShortestPath') {}
                    xml.node(:name => 'sub1', :type => 'Net') {
                        xml.node(:name => 'routing', :type => 'ShortestPath') {}

                        # add hosts
                        xml.node(:name => "h1", :type => 'Host') {
                            xml.node(:name => 'if_0', :type => 'Interface') {
                                xml.attribute(:name => 'bit_rate', :value => '100000000') {}
                                xml.attribute(:name => 'latency', :value => '0') {}
                            }
                        }

                        # add router
                        xml.node(:name => 'r1', :type => 'Router') {
                            xml.node(:name => 'if_h1', :type => 'Interface') {
                                xml.attribute(:name => 'bit_rate', :value => '100000000') {}
                                xml.attribute(:name => 'latency', :value => '0') {}
                            }

                            xml.node(:name => 'if_gateway', :type => 'Interface') {
                                xml.attribute(:name => 'bit_rate', :value => '100000000') {}
                                xml.attribute(:name => 'latency', :value => '0') {}
                            }
                        }

                        # add links
                        xml.node(:name => 'l_h1', :type => 'Link') {
                            xml.attribute(:name => 'bandwidth', :value => '100000000') {}
                            xml.attribute(:name => 'delay', :value => '1') {}
                            xml.ref(:name => 'r1', :path => '..:r1:if_h1') {}
                            xml.ref(:name => 'h1', :path => '..:h1:if_0') {}
                        }
                    }
                    # add subs
                    for i in @subs
                        xml.replica(:name => "sub#{i}", :path => "sub1") {}

                        xml.node(:name => "l_sub#{i-1}_sub#{i}", :type => 'Link') {
                            xml.attribute(:name => 'bandwidth', :value => '100000000') {}
                            xml.attribute(:name => 'delay', :value => '1') {}
                            xml.ref(:name => 'r1', :path => "..:sub#{i-1}:r1:if_gateway") {}
                            xml.ref(:name => 'r1', :path => "..:sub#{i}:r1:if_gateway") {}
                        }
                    end
                    
                    xml.replica(:name => "sub#{@hosts}", :path => "sub1") {}

                    xml.node(:name => "l_sub#{@hosts}_sub1", :type => 'Link') {
                        xml.attribute(:name => 'bandwidth', :value => '100000000') {}
                        xml.attribute(:name => 'delay', :value => '1') {}
                        xml.ref(:name => 'r1', :path => "..:sub#{@hosts}:r1:if_gateway") {}
                        xml.ref(:name => 'r1', :path => "..:sub1:r1:if_gateway") {}
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
        filename = "ringWith#{@hosts}Nodes.xml"
        target = open(filename, 'w')
        target.write("#{output}")
    end
end

if __FILE__ == $0
    rx = RingXML.new(ARGV.first.to_i)
    rx.buildXML
    #bx.printXML
    rx.writeXML
end
