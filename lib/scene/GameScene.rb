# encoding: utf-8
class GameScene < Scene
    @@font = Font.new(24)
    @@font2 = Font.new(20)

    @@scale = 1

    @revCooldown = 0

    # getするかcreateするか
    def self.getOrCreate()
        if ($gameScene == nil)
            $gameScene = GameScene.new() end

        if (@@font == nil)
            @@font = Font.new(24) end
        
        return $gameScene
    end

    # コンストラクタ (インスタンス生成の最初の処理)
    # GameScene.getOrCreate() でしか基本的には使わない
    def initialize()
        super()
        @revCooldown = 0
    end

    # シーンID (デバッグで開いている画面を表示するためのものであってぶっちゃけそれ以外では使わないとおもう)
    def getId()
        return "game"
    end

    # 文字やエンティティの描画
    def draw()
        Window.draw_font_ex(3, WINDOW_HEIGHT - 24 - 3, "Score: #{$player.score}", @@font)

        gemStr = "Gem #{$player.gems}"
        Window.draw_font_ex(WINDOW_WIDTH - 5 - @@font.get_width(gemStr), WINDOW_HEIGHT - 24 - 3, gemStr, @@font)

        if (DISPLAY_CONTROL_KEY)
            arr = $control_key_message.split("\n")
            i = 0
            for str in arr
                Window.draw_font_ex(WINDOW_WIDTH - 5 - @@font2.get_width(str), 0 + i * 10, str, @@font2)
                i += 1
            end
        end

        # プレイヤーを含むエンティティをすべて描画
        for i in 0..($entitiesMap.length - 1)
            if ($entitiesMap[i] == nil) 
                next end

            for entity in $entitiesMap[i]
                entity.draw()
            end
        end
    end

    # 描画データの再生成
    def refresh()
        @@scale = (1.00 - (($player.size - 31) / 50).ceil() * 0.25).round(2)
        if (@@scale < 0.25)
            @@scale = 0.25
        end

        # プレイヤーを含むエンティティをすべて描画
        for i in 0..($entitiesMap.length - 1)
            if ($entitiesMap[i] == nil) 
                next end

            for entity in $entitiesMap[i]
                entity.refresh()
            end
        end
    end

    def scale()
        return @@scale
    end

    def scale=(scale)
        @@scale = scale
    end

    # 背景の描画処理
    def drawBackground()
        $math = (32 * @@scale).round()

        $mod_x = $player.x % $math
        $mod_y = $player.y % $math

        if (@@scale <= 0.25) 
            return end

        # 白線を引く処理
        for i in 0..(WINDOW_WIDTH / $math + 1).floor do
            Window.draw_line(i * $math - $mod_x, 0 - $mod_y, i * $math - $mod_x, WINDOW_HEIGHT - $mod_y + $math, [196, 196, 196])
        end

        for i in 0..(WINDOW_HEIGHT / ($math - 10) + 1).floor do
            Window.draw_line(0 - $mod_x, i * $math - $mod_y, WINDOW_WIDTH - $mod_x + $math, i * $math - $mod_y, [196, 196, 196])
        end
    end

    # キー入力の処理
    def handleInput()
        ## Move
        if (Input.keyDown?(K_UP) || Input.keyDown?(K_W))
            # W, ↑ key
            $player.isMoving = true
            $player.move(0, -5)
        end
        if (Input.keyDown?(K_DOWN) || Input.keyDown?(K_S))
            # S, ↓ key
            $player.isMoving = true
            $player.move(0, 5)
        end
        if (Input.keyDown?(K_RIGHT) || Input.keyDown?(K_D))
            # D, → key
            $player.isMoving = true
            $player.move(5, 0)
        end
        if (Input.keyDown?(K_LEFT) || Input.keyDown?(K_A))
            # A, ← key
            $player.isMoving = true
            $player.move(-5, 0)
        end
    
        ## Action
        if (Input.keyPush?(K_SPACE))
            $player.action("grow")
        end
    end

    def gameLoop()
        $player.isMoving = false

        # キー入力の処理をする関数
        handleInput()
    
        if ($player.movingXCooldown > 0)
            $player.movingXCooldown -= 1 end
        if ($player.movingYCooldown > 0)
            $player.movingYCooldown -= 1 end

        if ($player.isMoving) 
            $player.onMoving()
        else
            if (@revCooldown > 0)
            @revCooldown -= 1 end
        end

        # pickup item
        for gemItemEntity in GemItemEntity.gemList
            # ジェムを拾ったときの処理
            if ($player.sprite === gemItemEntity.sprite)
                $player.addGems(gemItemEntity.amount)
                $player.score += gemItemEntity.amount
                gemItemEntity.pickup($player)
            end

            for bot in $bots
                if (bot.sprite === gemItemEntity.sprite)
                    bot.addGems(gemItemEntity.amount)
                    bot.score += gemItemEntity.amount
                    gemItemEntity.pickup(bot)
                end
            end
        end

        # ボールがほかのボールを吸収する処理
        $allball = $bots.clone
        $allball.push($player)
        for ball in $allball
            # ここでついでに無敵の時間を処理する
            
            for ball2 in $allball
                if (ball == ball2) then next end

                # 衝突範囲をコピーする
                ball.sprite.collision = [ball.size / 2, ball.size / 2, ball.size - 12]
                
                if (ball.sprite === ball2.sprite)

                    # ballがball2より大きいとき
                    if (ball.size > ball2.size)

                        # 差を求める、僅差なら呑み込めない
                        diff = ball.size - ball2.size
                        if (diff >= 4)
                            ball.score += ball2.score + 20
                            ball.gems += ball2.gems + 20
                            if (ball2.instance_of?(Player))
                                gameover()
                            end

                            if (ball2.instance_of?(BotEntity))
                                $bots.delete(ball2)
                                $allball.delete(ball2)
                                ball2.remove()
                            end
                        end
                    end
                end

                ball.sprite.collision = nil
            end
        end

        # 敵のタスクを処理する
        for bot in $bots
            bot.task()
        end
    
        # ジェムの生成をする
        # 1frameに1/100の確率で1つ生成、1/200の確率で2つ同時に生成する
        if ($entitiesMap[3].length <= $maxGems)
            $r = rand(25)
            if ($r == 1 || $r == 2)
                GemItemEntity.create($player.x + 200 - rand(400), $player.y + 200 - rand(400))
                for bot in $bots
                    GemItemEntity.create(bot.x + 200 - rand(400), bot.y + 200 - rand(400))
                end
            end
            if ($r == 3)
                GemItemEntity.create($player.x + 200 - rand(400), $player.y + 200 - rand(400))
                GemItemEntity.create($player.x + 200 - rand(400), $player.y + 200 - rand(400))
            end
        end

        # ボット召喚
        diff = $maxBots - $entitiesMap[4].length
        if (diff > 0 && rand(300) == 1)
            $bots.push(BotEntity.create())
        end
    end

    # ゲームオーバーのとき
    def gameover()
        $scene = GameoverScene.getOrCreate()
    end

    def revCooldown()
        return @revCooldown
    end

    def revCooldown=(revCooldown)
        @revCooldown = revCooldown
    end
end
