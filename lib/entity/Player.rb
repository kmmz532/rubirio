# encoding: utf-8

# player class
class Player < BallEntity
    
    # Image をセットしてSprite のインスタンスを生成する
    # @param [Image] DXRubyのImage
    def setImage(image)
        gameScene = GameScene.getOrCreate()
        screenSize = @size * gameScene.scale

        @image = image
        setSprite(Sprite.new(WINDOW_WIDTH / 2 - screenSize, WINDOW_HEIGHT / 2 - screenSize, @image))
    end

    def initialize(x, y, size, priority = 5)
        super(x, y, size, priority)
        #setImage(Image.load("resources/skin1.png").circle_fill(size, size, size, C_WHITE).circle_fill(size, size, size - 2, C_RED))
    end

    def self.create2()
        return new(0, 0, 32)
    end
end
