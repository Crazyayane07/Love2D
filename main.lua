love.window.setTitle("Space Invaders Karo")

player = {}
player.x = 100
player.y = 100

bullets = {}
bullets_generation_tick = 30

enemies_moving_tick = 150

level = {}
enemies = {}

gameOver = false

function level:tryMoveEnemies()
	if enemies_moving_tick <= 0 then
		enemies_moving_tick = 150
		for it, enemy in pairs(enemies) do
            enemy.y = enemy.y + 30
        end
	end
	if enemies_moving_tick <= 75 then
		for it, enemy in pairs(enemies) do
            enemy.x = enemy.x + 1
        end
	end
	if enemies_moving_tick > 75 then
		for it, enemy in pairs(enemies) do
            enemy.x = enemy.x - 1
        end
	end
end

function level:spawnEnemies()
	for i = 4, 1, -1
		do
			for j = 5, 1, -1
				do
					enemy = {}
					enemy.x = (love.graphics.getWidth() / 5) * j - 75
					enemy.y = 50 * i
					enemy.image = love.graphics.newImage('images/invader.png')
					table.insert(enemies, enemy)
			end
	end
end

function player:shoot()
	if bullets_generation_tick <= 0 then
		bullets_generation_tick = 30
		bullet = {}
		bullet.x = player.x + 15
		bullet.y = 520
		table.insert(bullets, bullet)
		love.audio.play(player_shoot_sound)
	end
end

function love.load()
	player.image = love.graphics.newImage('images/player.png')
	player.explose_shoot = love.audio.newSource('sounds/shoot.mp3','static')
	music = love.audio.newSource('sounds/music.mp3','static')
	player_shoot_sound = love.audio.newSource('sounds/shoot.mp3','static')
	music:setLooping(true)
	love.audio.play(music)
	
	level.spawnEnemies()
end

function love.draw()
    for it, bullet in pairs(bullets) do
		love.graphics.rectangle("fill",bullet.x, bullet.y, 5,20)
	end
	
	for it, enemy in pairs(enemies) do
        love.graphics.draw(enemy.image, enemy.x, enemy.y, 0, 0.3)
	end
				
	love.graphics.draw(player.image, player.x, 580, 0, 0.3)
end

function love.update()
	if love.keyboard.isDown('right') then
		if player.x > 750 then
			player.x = 750
		end
		player.x = player.x + 5
	end
	if love.keyboard.isDown('left') then
		if player.x  < 10 then
			player.x = 10
		end
		player.x = player.x - 5
	end
	if love.keyboard.isDown('space') then
		player.shoot()
	end
	if love.keyboard.isDown('q') then
		love.event.quit()
	end

	for it, bullet in pairs(bullets) do
		bullet.y = bullet.y - 5
	end


	bullets_generation_tick = bullets_generation_tick - 1
	enemies_moving_tick = enemies_moving_tick - 1
	
	level.tryMoveEnemies()
	
end
