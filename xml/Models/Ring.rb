#!/usr/bin/env ruby

require './Model.rb'

class Ring < Model
    def initialize(numberOfHosts, type='Ring')
        super(numberOfHosts, type)
        @routers  = Array.new(numberOfHosts)
        @links    = Array.new(@hosts.length * 2)
        @replicas = Array.new(@hosts.length)

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
            @routers[i] = Router.new("r#{i+1}", 3)
        end
    end

    def addLinks
        for i in 0..@max_links-1
            @links[i] = Link.new("l_h#{i+1}")
            @links[i].refs[0] = Ref.new("", "")
            @links[i].refs[1] = Ref.new("", "")
        end
    end

    def addReplicas
        for i in 0..@replicas.length-1
            @replicas[i] = Replica.new("sub", "Net")
        end
    end

    def generateXML
    end

    def d3ify
        #nodes
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

        #links
        links_filename = "links.json"
        target = open(links_filename , 'w')
        json ="["

        for i in 0..@max_links-1
            json += @links[i].to_json
            if i != @max_links-1
                json += ","
            end
        end

        json += "]"
        json = JSON.parse(json)

        link_index = 0

        for i in 0..@max_hosts-1
            json[link_index]["source"] = i
            json[link_index]["target"] = @max_hosts + i
            link_index += 1
        end

        for i in 0..@max_routers-1
            json[link_index]["source"] = (@max_hosts - 1) + (i + 1)
            json[link_index]["target"] = (@max_hosts - 1) + (((i + 1) % @max_routers) + 1)
            link_index += 1
        end

        target.write(JSON.pretty_generate(json))
    end
end

if __FILE__ == $0
    r = Ring.new(3)
    r.d3ify
end
