# encoding: UTF-8

################################
## Configuration

# デバッグモード
DEBUG_MODE = true

# 操作キーの表示
DISPLAY_CONTROL_KEY = true

# カラーリストの定義
$colorList = [
    [255, 255, 0, 0],
    [255, 0, 255, 0],
    [255, 0, 0, 255],
    [255, 255, 255, 0],
    [255, 0, 255, 255],
    [255, 255, 0, 255],
]

# 最大生成ボット数
$maxBots = 15

# 最大生成ジェム数
$maxGems = 3000

# 最大移動範囲 (nilの場合、無限となるので注意)
# [x1, y1, x2, y2]
#$range = [2048, 2048, -2048, -2048]
$range = [256, 256, -256, -256]

# 出現/復活時の無敵時間 (デフォルト: 5秒)
$invincibility_frame = 60 * 5



################################
## Message
$control_key_message = <<-EOD
[Space]: grow\n
[ESC]: Open menu\n
[W, ↑]: Up\n
[A, ←]: Left\n
[S, ↓]: Down\n
[D, →]: Right\n
EOD

$gameover_message = "ゲームを続けますか？"