# encoding: UTF-8

# ball (character) class
class BallEntity < Entity
    @isMoving = false
    @speed = 100
    @movingXCooldown = 0
    @movingYCooldown = 0
    @gems = 0
    @score = 0

    @skinId = 0

    @invincibilityCooldown = 0

    def initialize(x, y, size, priority = 5, skinId = 0)
        super(x, y, size, priority)
        @skinId = skinId

        setImage(Image.new(size * 2, size * 2).circle_fill(size, size, size, C_WHITE).circle_fill(size, size, size - 2, $colorList[@skinId]))
        @isMoving = false
        @speed = 100
        @movingXCooldown = 0
        @movingYCooldown = 0
        @gems = 0
        @score = 0

        @invincibilityCooldown = $invincibility_frame
    end

    def self.create()
        new(0, 0, 32)
    end

    def skinId()
        return @skinId
    end

    def skinId=(skinId)
        @skinId = skinId
    end

    def move(x, y)
        speed = @speed.round()

        if (x != 0)
            
            if (@movingXCooldown > 0)
                x = 0
            else
                if (speed > 100 - 5)
                    if (x > 0)
                        x += speed - 100
                    else
                        x -= speed - 100
                    end
                else
                    if (x > 0)
                        x = 1
                    else
                        x = -1
                    end
                end
                    
                if (speed < 100 - 5)
                    @movingXCooldown = 100 - speed
                end
            end
        end

        if (y != 0)
            
            if (@movingYCooldown > 0)
                y = 0
            else
                if (speed > 100 - 5)
                    if (y > 0)
                        y += speed - 100
                    else
                        y -= speed - 100
                    end
                else
                    if (y > 0)
                        y = 1
                    else
                        y = -1
                    end
                end
                
                if (speed < 100 - 5)
                    @movingYCooldown = 100 - speed
                end
            end
        end

        if ($range != nil)
            if (@x + x >= $range[0] || @x + x <= $range[2] || @y + y >= $range[1] || @y + y <= $range[3])
                return end
        end

        addPos(x, y)
    end

    def isMoving=(b)
        @isMoving = b
    end

    def isMoving()
        return @isMoving
    end

    def onMoving()
        gameScene = GameScene.getOrCreate()
        if (gameScene.revCooldown <= 50)
            gameScene.revCooldown += 1 end
    end

    def speed()
        return @speed
    end

    def speed=(speed)
        @speed = speed
    end
    
    def movingXCooldown()
        return @movingXCooldown
    end

    def movingXCooldown=(movingXCooldown)
        @movingXCooldown = movingXCooldown
    end
    
    def movingYCooldown()
        return @movingYCooldown
    end

    def movingYCooldown=(movingYCooldown)
        @movingYCooldown = movingYCooldown
    end

    def score()
        return @score
    end

    def score=(score)
        @score = score
    end

    def getGems()
        return @gems
    end

    def gems=(amount)
        @gems = amount
    end

    def addGems(amount)
        @gems += amount
    end

    def action(act)
        # Action: grow
        if (act == "grow")
            # use 10 gems
            if (@gems >= 10)
                addGems(-10)
                @size += 1
                @speed -= 0.02
                gameScene = GameScene.getOrCreate()
                gameScene.refresh()

                screenSize = @size * gameScene.scale
                setImage(Image.new(screenSize * 2, screenSize * 2).circle_fill(screenSize, screenSize, screenSize, C_WHITE).circle_fill(screenSize, screenSize, screenSize - 2, $colorList[@skinId]))
            end
        end
    end

    # 描画データを再設定 (色や画像、拡大率を変更した場合はrefreshすること)
    def refresh()
        gameScene = GameScene.getOrCreate()
        screenSize = @size * gameScene.scale
        setImage(Image.new(screenSize * 2, screenSize * 2).circle_fill(screenSize, screenSize, screenSize, C_WHITE).circle_fill(screenSize, screenSize, screenSize - 2, $colorList[@skinId]))
    end

    alias_method :gems, :getGems
end