#!/usr/bin/env ruby

require 'Model.rb'

class Bus < Model
    def initialize(numberOfHosts, type='Bus')
        super(numberOfHosts, type)
        @routers     = Array.new(numberOfHosts-1)
        @links       = Array.new(@routers.length*2)
        @replicas    = Array.new(1)

        self.addHosts
        self.addRouters
        self.addLinks
        self.addReplicas
    end

    def addHosts
        for i in 0..@hosts.length-1
            if i != 0 && i != @hosts.length
                @hosts[i] = Host.new("h#{i+1}", 2)
            else
                @hosts[i] = Host.new("h#{i+1}", 1)
            end
        end
    end

    def addRouters
        for i in 0..@routers.length-1
            @routers[i] = Router.new("r#{i+1}", 2)
        end
    end

    def addLinks
        for i in 1..@links.length
            if i != 1 && i != @links.length
                r = i - (i / 2)
                h = (i - (i / 2)) + ((i - 1) % 2)
                @links[i-1] = Link.new("l_h#{i}_h#{i+1}")
                @links[i-1].refs[0] = Ref.new("r#{r}", "..:r#{r}:if_h#{h}")
                @links[i-1].refs[1] = Ref.new("h#{h}", "..:h#{h}:if_#{i%2}")
            elsif i == 1
                @links[i-1] = Link.new("l_h#{i}")
                @links[i-1].refs[0] = Ref.new("r1", "..:r1:if_h1")
                @links[i-1].refs[1] = Ref.new("h1", "..:h1:if_0")
            else
                @links[i-1] = Link.new("l_h#{i}")
                @links[i-1].refs[0] = Ref.new("r#{@routers.length}", "..:r#{@routers.length}:if_h#{@hosts.length}")
                @links[i-1].refs[1] = Ref.new("h#{@hosts.length}", "..:h#{@hosts.length}:if_0")
            end

        end
    end

    def addReplicas
        for i in 0..@replicas.length-1
            @replicas[i] = Replica.new("sub1", "Net")
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

        for i in 0..@hosts.length-1
            json += @hosts[i].to_json
            json += ","
        end

        for i in 0..@routers.length-1
            json += @routers[i].to_json
            if i != @routers.length-1
                json += ","
            end
        end

        json += "]"

        #prettify input
        #puts JSON.pretty_generate(JSON.parse(json))
        target.write(JSON.pretty_generate(JSON.parse(json)))

        # links
        links_filename = "links.json"
        target = open(links_filename, 'w')

        json = "["

        for i in 0..@links.length-1
            json += @links[i].to_json
            if i != @links.length-1
                json += ","
            end
        end

        json += "]"

        json = JSON.parse(json)
      
        for i in 1..@links.length
            if i != 1 && i != @links.length
                r = i - (i / 2)
                h = (i - (i / 2)) + ((i - 1) % 2)
                json[i-1]["source"] = (@hosts.length - 1) + r
                json[i-1]["target"] = h - 1
            elsif i == 1
                json[i-1]["source"] = @hosts.length
                json[i-1]["target"] = 0
            else
                json[i-1]["source"] = (@hosts.length - 1) + @routers.length
                json[i-1]["target"] = (@hosts.length - 1)
            end
        end

        #prettify input
        #puts JSON.pretty_generate(json)
        target.write(JSON.pretty_generate(json))
    end

end
