-- Made in 2 hours, copied a lot from tutorials by Jack Robbers
rotation = 0
createEnemyTimerMax = 0.4
createEnemyTimer = createEnemyTimerMax

computer = { x = 200, y = 710, speed = 300, img = nil }
love.graphics.setBackgroundColor(255,255,255)
enemyImg= nil
enemies = {}

isAlive = true
score = 0

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function love.load(arg)
	computer.img = love.graphics.newImage('assets/computer.png')
	enemyImg = love.graphics.newImage('assets/clock.png')
end

function love.update(dt)
	score = score + 1
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end
	if love.keyboard.isDown('left','a') then
		if computer.x > 0 then
			computer.x = computer.x - (computer.speed*dt)
		end
	elseif love.keyboard.isDown('right','d') then
		if computer.x < (love.graphics.getWidth() - computer.img:getWidth()) then
			computer.x = computer.x + (computer.speed*dt)
		end
	end
	if not isAlive and love.keyboard.isDown('r') then
		-- remove all our bullets and enemies from screen
		bullets = {}
		enemies = {}

		-- reset timers
		canShootTimer = canShootTimerMax
		createEnemyTimer = createEnemyTimerMax

		-- move computer back to default position
		computer.x = 50
		computer.y = 710

		-- reset our game state
		score = 0
		isAlive = true
	end

	createEnemyTimer = createEnemyTimer - (1 * dt)
	if createEnemyTimer < 0 then
		createEnemyTimer = createEnemyTimerMax

		-- Create an enemy
		randomNumber = math.random(10, love.graphics.getWidth() - 10)
		newEnemy = { x = randomNumber, y = -10, img = enemyImg }
		table.insert(enemies, newEnemy)
	end
	for i, enemy in ipairs(enemies) do
	enemy.y = enemy.y + (100 * dt)

	if enemy.y > 850 then -- remove enemies when they pass off the screen
		table.remove(enemies, i)
	end
	end
	for i, enemy in ipairs(enemies) do
		if CheckCollision(enemy.x, enemy.y, enemy.img:getWidth(), enemy.img:getHeight(), computer.x, computer.y, computer.img:getWidth(), computer.img:getHeight()) 
		and isAlive then
			table.remove(enemies, i)
			isAlive = false
		end
	end
end

function love.draw(dt)
	love.graphics.setColor(0, 255, 0, 255)
	love.graphics.print(score, 0, 0, 0, 2, 2)
	love.graphics.setColor(0,0,0)
	if isAlive then
		love.graphics.draw(computer.img, computer.x, computer.y, 0 , 3, 3)
	else
		love.graphics.print("Press 'R' to restart", love.graphics:getWidth()/2-50, love.graphics:getHeight()/2-10)
	end

	for i, enemy in ipairs(enemies) do
		rotation = rotation + 0.001
		love.graphics.draw(enemy.img, enemy.x, enemy.y, rotation)
	end

end
