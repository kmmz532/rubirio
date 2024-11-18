# encoding: utf-8

# gem item
class GemItemEntity < ItemEntity
    @@gemList = []

    @amount = 1

    @color = []

    def self.gemList()
        return @@gemList
    end
    
    def pickup(ball)
        remove()
        if (@@gemList.include?(self))
            @@gemList.delete(self)
        end
    end

    def amount()
        return @amount
    end

    def self.create(x, y)
        if (x >= $range[0] || x <= $range[2] || y >= $range[1] || y <= $range[3])
            return end

        return new(x, y)
    end

    def initialize(x, y)
        super(x, y, 8, 3)
        @@gemList.push(self)
        @amount = 1

        gameScene = GameScene.getOrCreate()
        screenSize = 8 * gameScene.scale
        @color = [176, rand(255), rand(255), rand(255)]
        setImage(Image.new(screenSize * 2, screenSize * 2).circle_fill(screenSize, screenSize, screenSize, @color))
    end

    def refresh()
        gameScene = GameScene.getOrCreate()
        screenSize = @size * gameScene.scale
        setImage(Image.new(screenSize * 2, screenSize * 2).circle_fill(screenSize, screenSize, screenSize, @color))
    end
end