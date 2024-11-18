# encoding: UTF-8

Window.width = WINDOW_WIDTH
Window.height = WINDOW_HEIGHT

Window.caption = "Rubir.io"
Window.load_icon("./resources/logo.ico")

# Map<int, List<Entity>> みたいな感じで使う
# [優先度: [Entity, ...], 優先度: [...], ...]
$entitiesMap = []

# ジェムエンティティの配列
$entitiesMap[3] = []

# ボットエンティティの配列
$entitiesMap[4] = []

require "./lib/math/Vector2f"
require "./lib/math/Pos"

require "./lib/entity/Entity"
require "./lib/entity/BallEntity"
require "./lib/entity/BotEntity"
require "./lib/entity/Player"
require "./lib/entity/ItemEntity"
require "./lib/entity/GemItemEntity"

require "./lib/scene/abstract/Scene"
require "./lib/scene/GameScene"
require "./lib/scene/abstract/AbstractMenuScene"
require "./lib/scene/menu/MenuScene"
require "./lib/scene/menu/SkinOptionScene"
require "./lib/scene/menu/GameoverScene"

require "./lib/widget/Button"
require "./lib/widget/TextButton"


$debugfont = Font.new(16)
$amount_of_debug_info = 0

def debugDrawText(str)
    Window.draw_font(3, 3 + 16 * $amount_of_debug_info, str, $debugfont)
    $amount_of_debug_info += 1
end

# デバッグ用の情報を表示する (DEBUG_MODE only)
def debugInfo()
    $amount_of_debug_info = 0

    debugDrawText("Scene: #{$scene.getId}")

    debugDrawText("Player(#{$player.x}, #{$player.y})")
    debugDrawText("Gems: #{$player.gems}")
    debugDrawText("Size: #{$player.size - 31}")
    debugDrawText("isMoving: #{$player.isMoving}")
    debugDrawText("speed: #{$player.speed.round()}")

    if ($scene.instance_of?(GameScene))
        debugDrawText("scale: #{$scene.scale.round(2)}") end
    
    debugDrawText("movingXCooldown: #{$player.movingXCooldown}")
    debugDrawText("movingYCooldown: #{$player.movingYCooldown}")

    if ($entitiesMap[3] != nil)
        debugDrawText("gemEntities: #{$entitiesMap[3].length}") end
    if ($entitiesMap[4] != nil)
        debugDrawText("botEntities: #{$entitiesMap[4].length}") end
    
end

# プレイヤー (Ballクラスを継承したPlayerクラスのインスタンス)
$player = Player.create()

# ボットの配列
$bots = []

# ボット数体召喚
for i in 1..(rand($maxBots))
    $bots.push(BotEntity.create())
end

$scene = GameScene.getOrCreate()

$gameScene = nil
$menuScene = nil

Window.loop do
    $scene.drawBackground()
    $scene.draw()

    $scene.gameLoop()

    $scene.onHover(Input.mouse_pos_x, Input.mouse_pos_y)

    if (Input.mousePush?(M_LBUTTON))
        $scene.onClick(Input.mouse_pos_x, Input.mouse_pos_y)
    end

    if (Input.keyPush?(K_ESCAPE))
        if ($scene.instance_of?(GameScene))
            $scene = MenuScene.getOrCreate()
        elsif ($scene.instance_of?(MenuScene))
            $scene = GameScene.getOrCreate()
        end
    end

    if (DEBUG_MODE)
        debugInfo()
    end
end