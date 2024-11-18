# encoding: utf-8
class Scene

    @buttonList = []

    def initialize()
        @buttonList = []
    end

    def getId()
        return "none"
    end

    # 描画
    def draw()

    end

    # 背景の描画
    def drawBackground()
        
    end

    # ゲームの主な処理
    def gameLoop()
        
    end

    # 画面がクリックされたら
    def onClick(mouseX, mouseY)
        if (@buttonList == nil) 
            return
        end

        if (DEBUG_MODE)
            puts "clicked scene at (#{mouseX}, #{mouseY})" end

        for button in @buttonList
            #puts "button check #{button.x}, #{button.y}"
            if (mouseX >= button.left && mouseY >= button.top && mouseX <= button.right && mouseY <= button.bottom)
                #puts "clicked button"
                button.onClick(mouseX, mouseY)
            end
        end
    end

    def onHover(mouseX, mouseY)
        if (@buttonList == nil) 
            return
        end

        for button in @buttonList
            if (mouseX >= button.left && mouseY >= button.top && mouseX <= button.right && mouseY <= button.bottom)
                button.onHover(mouseX, mouseY)
            end
        end
    end

    # Buttonを追加する
    # @param Button
    def addButton(button)
        #if (!button.instance_of?(Button))
        #    raise 'button is not instance of Button class' end
        
        @buttonList.push(button)
    end

    # Buttonを取得
    # @param [int] index
    # @return Button
    def getButton(index)
        return @buttonList[index]
    end
end