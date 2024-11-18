# encoding: utf-8
class AbstractMenuScene < Scene
    @@scene = nil
    @@gameScene
    @@font = Font.new(28)

    @overlaySprite = nil
    @menuSprite = nil

    def self.getOrCreate()
        if ($gameScene == nil)
            $gameScene = GameScene.getOrCreate() end

        if (@@font == nil)
            @@font = Font.new(28) end
        return nil
    end

    def initialize()
        super()
    end

    def getId()
        return "abstract_menu"
    end

    # 描画
    def draw()
        for button in @buttonList
            button.draw()
        end
    end
 
    # 背景の描画
    def drawBackground()
        $gameScene.drawBackground()
        $gameScene.draw()

        if (@overlaySprite == nil)
            image = Image.new(WINDOW_WIDTH, WINDOW_HEIGHT).box_fill(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, [128, 75, 75, 75])
            @overlaySprite = Sprite.new(0, 0, image)
        end
        @overlaySprite.draw()

        if (@menuSprite == nil)
            image = Image.new(420, 420).box_fill(0, 0, 420, 420, [210, 255, 255, 255]).box_fill(3, 3, 416, 416, [210, 16, 16, 16])
            @menuSprite = Sprite.new(WINDOW_WIDTH / 2 - 210, WINDOW_HEIGHT / 2 - 210, image)
        end
        @menuSprite.draw()
    end

    # ゲームの主な処理
    def gameLoop()
        
    end
end