#!/usr/bin/env ruby

require 'java'

java_import Java::slingshot.wizards.topology.XmlTree

class Test
    def initialize
            xmlt = XmlTree.new
            xmlt.Loadfile("Dumbell.xml")
            xmlt.setRoot(xmlt.getRoot().getChild(0))
            xmlt.WriteXml("NewDumbell.xml")
    end
end

if __FILE__ == $0
    t = Test.new()
end
