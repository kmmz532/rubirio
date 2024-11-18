# encoding: utf-8
class SkinOptionScene < AbstractMenuScene
    @@scene
    @@font
    @image

    def self.getOrCreate()
        if (@@scene == nil)
            @@scene = SkinOptionScene.new end
        
        if (@@font == nil)
            @@font = Font.new(28) end
        
        return @@scene
    end

    def initialize()
        super()
        startX = (WINDOW_WIDTH / 2 - 210)
        startY = (WINDOW_HEIGHT / 2 - 210)




        # Backボタン
        backBtn = TextButton.new(416 - 24 - 45 + startX, 416 - 34 + startY, 28, "Back") {
            $scene = MenuScene.getOrCreate()
        }

        # <
        ballChange_prev = TextButton.new(WINDOW_WIDTH / 2 - 80, startY + 96 + 32, 28, "<") {
            $player.skinId -= 1
            
            if (0 > $player.skinId)
                $player.skinId = $colorList.length - 1
            end
            $player.refresh()
        }

        # >
        ballChange_next = TextButton.new(WINDOW_WIDTH / 2 + 68, startY + 96 + 32, 28, ">") {
            $player.skinId += 1
            
            if ($colorList.length < $player.skinId + 1)
                $player.skinId = 0
            end
            $player.refresh()
            
        }
        addButton(backBtn)
        addButton(ballChange_next)
        addButton(ballChange_prev)

        #save = TextButton.new(startX + 208, startY + 32, 28, "Save")

    end

    def getId()
        return "skin_option_menu"
    end

    # ゲームの主な処理
    def gameLoop()
        startX = (WINDOW_WIDTH / 2 - 210)
        startY = (WINDOW_HEIGHT / 2 - 210)
        #super.gameLoop()
        @image = Image.new(96, 96).circle_fill(48, 48, 48, C_WHITE).circle_fill(48, 48, 46, $colorList[$player.skinId])
        Window.draw(WINDOW_WIDTH / 2 - 48, startY + 96, @image)
    end
end