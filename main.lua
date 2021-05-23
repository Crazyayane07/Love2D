
player = {}
player.x = 100
player.y = 100

bullets = {}
bullets_generation_tick = 30

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


enemies_list = {}

function love.load()
	player.image = love.graphics.newImage('images/player.png')
	player.explose_shoot = love.audio.newSource('sounds/shoot.mp3','static')
	music = love.audio.newSource('sounds/music.mp3','static')
	player_shoot_sound = love.audio.newSource('sounds/shoot.mp3','static')
	music:setLooping(true)
	love.audio.play(music)
end

function love.draw()
	love.graphics.print("Space Invaders Example", 400, 300)
	love.graphics.setColor(1,1,1)
    for it, bullet in pairs(bullets) do
		love.graphics.rectangle("fill",bullet.x, bullet.y, 5,20)
	end
	love.graphics.draw(player.image, player.x, 580, 0, 0.3)
end

function love.update()
	if love.keyboard.isDown('right') then
		if player.x > 750 then
			player.x = 750
		end
		print("Right key pressed")
		player.x = player.x + 5
	end
	if love.keyboard.isDown('left') then
		if player.x  < 10 then
			player.x = 10
		end
		print("Left key pressed")
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
end
