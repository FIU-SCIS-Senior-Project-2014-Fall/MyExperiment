#!/usr/bin/env ruby

require './Model.rb'

class Dumbbell < Model
    def initialize(numberOfHosts, type='Dumbbel')
        super(numberOfHosts, type)
        @routers  = Array.new(2)
        @links    = Array.new((@hosts.length*2)+1)
        @replicas = Array.new(2)

        @max_hosts   = @hosts.length
        @max_routers = @routers.length
        @max_links   = @links.length

        self.addHosts
        self.addRouters
        self.addLinks
        self.addReplicas
    end

    def addHosts
        for i in 0..@max_hosts-1
            @hosts[i] = Host.new("h#{i+1}", 1)
        end
    end

    def addRouters
        for i in 0..@max_routers-1
            @routers[i] = new Router.new("r#{i+1}", @max_hosts)
        end
    end
    
    def addLinks
        link_index = 0

        #link refs don't have proper paths
        for i in 0..@max_routers-1
            for j in 0..@max_hosts-1
                @links[link_index] = Link.new("l_h#{j}")
                @links[link_index].refs[0] = Ref.new("r", "..:r:if_h")
                @links[link_index].refs[1] = Ref.new("h", "..:h:if_")
                link_index += 1
            end
        end

        #link for two routers/replicas
        @links[link_index] = Link.new("")
        @links[link_index].refs[0] = Ref.new("", "")
        @links[link_index].refs[1] = Ref.new("", "")
    end

    #replicas dont have proper names
    def addReplicas
        for i in 0..@replicas.length-1
            @replicas[i] = Replica.new("sub", "Net")
        end
    end

    #unfinished
    def generateXML
    end

    def d3ify
        # nodes
        nodes_filename = "nodes.json"
        target = open(nodes_filename, 'w')
        json = "["

        for i in 0..@max_hosts-1
            json += @hosts[i].to_json
            json += ","
        end

        for i in 0..@max_routers-1
            json += @routers[i].to_json
            if i != @max_routers-1
                json += ","
            end
        end

        json += "]"
        target.write(JSON.pretty_generate(JSON.parse(json)))

        # links
        links_filename = "links.json"
        target = open(links_filename, 'w')
        json = "["

        for i in 0..@max_links.length-1
            json += @links[i].to_json
            if i != @max_links-1
                json += ","
            end
        end

        json += "]"
        json = JSON.parse(json)

        for
            
        end

        target.write(JSON.pretty_generate(json))
    end
end

if __FILE__ == $0
    d = Dumbbell.new(3)
end
