# encoding: utf-8
class BotEntity < BallEntity

    @vectorQueue = []

    def initialize(x, y, size, priority = 4)
        super(x, y, size, priority, rand(5) + 1)
        @vectorQueue = []
    end

    def task()
        
        if (@vectorQueue.length <= 0)
            rx = (1 - rand(3)); ry = (1 - rand(3));
            #puts "rx, ry = #{rx}, #{ry}"

            rand(30).times {
                @vectorQueue.push([rx * 5, ry * 5])
            }
        else
            vector = @vectorQueue.pop()
            move(vector[0], vector[1])
        end

        if (rand(150) == 1)
            action("grow")
        end
    end

    def self.create2(x, y)
        return new(x, y, 32)
    end

    def self.create()
        x = rand(300) - 150
        y = rand(300) - 150
        return create2(x, y)
    end

    
end