# encoding: utf-8
class TextButton < Button
    @font = Font.new(28)
    @text = ""

    # コンストラクタ
    # @param [int] x ボタンのX座標
    # @param [int] y ボタンのY座標
    # @param [int] width ボタンの横幅
    # @param [int] height ボタンの高さ
    # @param [Block] actionBlock 押された時のブロック
    def initialize(x, y, height, text, &actionBlock)
        super(x, y, width, height, actionBlock)
        @font = Font.new(28)
        @text = text
        @width = @font.get_width(@text)
    end

    def draw()
        Window.draw_font_ex(@x, @y, @text, @font)
        
        if (DEBUG_MODE)
            #Window.draw_line(@x, @y + 28, @x + @width, @y + 28, [200, 96, 150, 255])
        end
    end

    def onHover(mouseX, mouseY)
        Window.draw_line(@x, @y + 28, @x + @width, @y + 28, [200, 96, 150, 255])
    end

    def font()
        return @font
    end

    def font=(font)
        @font = font
    end
end