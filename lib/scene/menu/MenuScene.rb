# encoding: utf-8
class MenuScene < AbstractMenuScene

    def self.getOrCreate()
        if ($menuScene == nil)
            $menuScene = MenuScene.new end
        
        if ($gameScene == nil)
            $gameScene = GameScene.getOrCreate() end

        if (@@font == nil)
            @@font = Font.new(28) end
        
        return $menuScene
    end

    def initialize()
        super()
        startX = (WINDOW_WIDTH / 2 - 210)
        startY = (WINDOW_HEIGHT / 2 - 210)

        # Exitボタン
        exitBtn = TextButton.new(startX + 14, 416 - 34 + startY, 28, "Exit") {
            exit
        }

        addButton(exitBtn)
        # Resumeボタン (再開)
        resumeBtn = TextButton.new(416 - 24 - 80 + startX, 416 - 34 + startY, 28, "Resume") {
            $scene = GameScene.getOrCreate()
        }
        addButton(resumeBtn)

        skinOption = TextButton.new(startX + 32, startY + 32, 28, "スキン設定") {
            $scene = SkinOptionScene.getOrCreate()   
        }
        #controlOption = TextButton.new(startX + 208, startY + 32, 28, "操作設定")
        #save = TextButton.new(startX + 208, startY + 32, 28, "Save")

        addButton(skinOption)
        #addButton(controlOption)
    end

    def getId()
        return "menu"
    end

    # ゲームの主な処理
    def gameLoop()
        #super.gameLoop()
    end
end