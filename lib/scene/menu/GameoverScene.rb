# encoding: utf-8
class GameoverScene < AbstractMenuScene

    def self.getOrCreate()
        if ($gameoverScene == nil)
            $gameoverScene = GameoverScene.new end
        
        if ($gameScene == nil)
            $gameScene = GameScene.getOrCreate() end

        if (@@font == nil)
            @@font = Font.new(28) end
        
        return $gameoverScene
    end

    def initialize()
        super()
        startX = (WINDOW_WIDTH / 2 - 210)
        startY = (WINDOW_HEIGHT / 2 - 210)

        # Exitボタン
        exitBtn = TextButton.new(startX + 14, 416 - 34 + startY, 28, "Exit") {
            exit
        }

        # Continueボタン (続ける)
        continueBtn = TextButton.new(416 - 24 - 90 + startX, 416 - 34 + startY, 28, "Continue") {
            $player.sprite.vanish()
            $player = Player.create()
            $scene = GameScene.getOrCreate()
        }

        addButton(exitBtn)
        addButton(continueBtn)
    end

    def getId()
        return "menu"
    end

    # ゲームの主な処理
    def gameLoop()
        startX = (WINDOW_WIDTH / 2 - 210)
        startY = (WINDOW_HEIGHT / 2 - 210)
        Window.draw_font_ex(WINDOW_WIDTH / 2 - @@font.get_width($gameover_message) / 2, startY + 100, $gameover_message, @@font)

        msg = "スコアは #{$player.score} でした"
        Window.draw_font_ex(WINDOW_WIDTH / 2 - @@font.get_width(msg) / 2, startY + 150, msg, @@font)
        #super.gameLoop()
    end
end