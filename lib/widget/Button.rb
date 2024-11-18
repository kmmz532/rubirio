# encoding: utf-8
class Button

    # ボタンの座標
    @x = 0
    @y = 0

    # ボタンのサイズ
    @width = 0
    @height = 0

    @actionBlock = nil
    @onHoverBlock = nil

    # コンストラクタ
    # @param [int] width ボタンの横幅
    # @param [int] height ボタンの高さ
    # @param [Block] actionBlock 押された時のブロック
    def initialize(x, y, width, height, actionBlock)
        @x = x
        @y = y
        @width = width
        @height = height
        @actionBlock = actionBlock
    end

    # ボタンがクリックされたら
    def onClick(mouseX, mouseY)
        if (@actionBlock != nil)
            @actionBlock.call end
        
    end

    # ボタンの上にポインターが存在する場合
    def onHover(mouseX, mouseY)
        if (@onHoverBlock != nil)
            @onHoverBlock.call end
        
    end

    def onHoverBlock=(onHoverBlock)
        @onHoverBlock = onHoverBlock
    end

    # @return [int] ボタンの頂点の座標
    def top()
        return @y
    end

    # @return [int] ボタンの底の座標
    def bottom()
        return @y + height
    end

    # @return [int] ボタンの右の座標
    def left()
        return @x
    end

    # @return [int] ボタンの左の座標
    def right()
        return @x + width
    end

    def x()
        return @x
    end

    def y()
        return @y
    end

    def x=(x)
        @x = x
    end

    def y=(y)
        @y = y
    end

    def width()
        return @width
    end

    def height()
        return @height
    end

    def width=(width)
        @width = width
    end

    def height=(height)
        @height = height
    end

    def draw()
        
    end
end