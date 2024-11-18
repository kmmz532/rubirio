# encoding: utf-8

# 座標保持の描画オブジェクトの抽象クラス
class Entity
    @image
    @sprite

    # coordinate X, Y
    @x = 0; @y = 0

    # size
    @size = 32

    def initialize(x, y, size, priority = 0)
        if ($entitiesMap[priority] == nil) 
            $entitiesMap[priority] = []
        end
        $entitiesMap[priority].push(self)
        setPos(x, y)
        @size = size
    end

    def refresh()
        
    end

    # Image をセットしてSprite のインスタンスを生成する
    # @param [Image] DXRubyのImage
    def setImage(image)
        gameScene = GameScene.getOrCreate()
        screenSize = @size * gameScene.scale

        @image = image
        setSprite(Sprite.new(@x + WINDOW_WIDTH / 2 - screenSize, @y + WINDOW_HEIGHT / 2 - screenSize, @image))
    end

    def setSprite(sprite)
        @sprite = sprite
    end

    def sprite()
        return @sprite
    end

    def size=(size)
        @size = size
    end

    def size()
        return @size
    end

    # 描画する
    def draw()
        if (!self.instance_of?(Player))
            # Todo: 画面外のときは表示させない処理をつくるべき
            if (@x < $player.x + WINDOW_WIDTH / 2 && @x > $player.x - WINDOW_WIDTH / 2 && @y < $player.y + WINDOW_HEIGHT / 2 && @y > $player.y - WINDOW_HEIGHT / 2)
                @sprite.x = @x - $player.x + WINDOW_WIDTH / 2 - @size
                @sprite.y = @y - $player.y + WINDOW_HEIGHT / 2 - @size
                @sprite.draw()
            end
        else
            @sprite.draw()
        end
    end

    # 座標をセットする
    # @param [int] x ボール/プレイヤーのX座標
    # @param [int] y ボール/プレイヤーのY座標
    def setPos(x, y)
        @x = x
        @y = y
    end

    # 座標を加算する
    # @param [int] x X座標に加算する数値
    # @param [int] y Y座標に加算する数値
    def addPos(x, y)
        @x += x
        @y += y
    end

    # X座標を返す、エイリアスはx
    # @return [int] X座標
    def getX()
        return @x
    end

    # Y座標を返す、エイリアスはy
    # @return [int] Y座標
    def getY()
        return @y
    end

    def remove()
        for entities in $entitiesMap
            if (entities == nil) 
                next end

            if (entities.include?(self))
                entities.delete(self)
                break
            end
        end
    end

    # エイリアス
    alias_method :x, :getX
    alias_method :y, :getY
end

