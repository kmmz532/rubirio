class Vector2f
    @x = 0
    @y = 0

    def initialize(x, y)
        @x = x
        @y = y
    end

    def add(x, y)
        @x += x
        @y += y
    end

    def add(vec)
        @x += vec.getX()
        @y += vec.getY()
    end

    def getX()
        return @x
    end

    def getY()
        return @y
    end

    def setX(x)
        @x = x
    end

    def setY(y)
        @y = y
    end

    def set(x, y)
        @x = x
        @y = y
    end

    def set(vec)
        @x = vec.getX()
        @y = vec.getY()
    end

    def diff(x, y)
        return new Vector2f(@x - x, @y - y)
    end

    def diff(vec)
        return diff(vec.getX(), vec.getY())
    end

    def getAsArray()
        return [@x, @y]
    end

    def equals(vec)
        return @x == vec.getX() && @y == vec.getY()
    end

    def ===(vec)
        return @x == vec.getX() && @y == vec.getY()
    end

    #alias_method :x :getX
    #alias_method :y :getY
    #alias_method :x= :setX
    #alias_method :y= :setY
end