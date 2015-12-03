require 'func'

function love.load(arg)
  Setup()
  Reset()
end
 
function love.update(dt)
  score = score + 1
  speed = speed + dt / 20
  rainTimer = rainTimer - dt
  rainTimerMax = rainTimerMax - dt / 100
  
  Gravity(umbrella, 0, speed, dt)
  
  if love.keyboard.isDown('escape') then
		love.event.quit()
  end
  
  if love.keyboard.isDown('left','a') then 
    char.x = char.x - 5
  elseif love.keyboard.isDown('right','d') then 
    char.x = char.x + 5
  end
      
  if Collide(char, umbrella, SCALE, SCALE) then
    char.item = 'umbrella'
    umbrella.timer = umbrella.timerMax
  end
  
  if rainTimer < 0 then
    --lastRain = newRain
    rainTimer = rainTimerMax
    newRain = { x = math.random(0, love.window.getWidth()), y = -50, img = rainImg}
   -- if lastRain.x < newRain.x + 50 and lastRain.x > newRain.x - 50 then
      newRain.x = - 100 

    table.insert(rain, newRain)
end
  
  for i, rain in ipairs(rain) do
    Gravity(rain, 1000, speed, dt)
    if char.item == 'umbrella' then
      umbrella.timer = umbrella.timer - dt
      if Collide(char, rain, 7, 10) then
        rain.y = 2000
        umbrella.health = umbrella.health - 1
      end
    else
      if Collide(char, rain, 3, 3) then
        char.health = char.health - 1
        alive = false
      end
    end
  end
  
  if umbrella.health < 0 and char.item == 'umbrella' then
    char.item = 'none'
    umbrella.y = -1000
    UmbrellaSpawn(umbrella)
    umbrella.health = 5
  end
  
  if alive == false then
    if love.keyboard.isDown('r') then
      Reset()
    end
  end
end

function love.draw(dt)
--  love.graphics.print(rainTimer, 0, 600)
  --love.graphics.print(rainTimerMax, 0,  500)
  --love.graphics.print(love.timer.getFPS())
  if alive == true then
    love.graphics.draw(char.img, char.x, char.y, 0, SCALE)
    love.graphics.print('score is  ' .. score, 0, 0, 0, 3)
      
    if char.item == 'umbrella' then
       love.graphics.draw(umbrella.img, char.x - 25, char.y - 120, 0, SCALE)
    else
      love.graphics.draw(umbrella.img, umbrella.x, umbrella.y, 0, SCALE)
    end
    
    for i, rain in ipairs(rain) do
      love.graphics.draw(rainImg, rain.x, rain.y, 0, SCALE)
    end
  else
    love.graphics.print('Press R to Reset!', 50,love.window.getHeight()- 200,0,5)
    love.graphics.print('DED', 0, 0, 0, 30)
  end
end