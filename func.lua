function Setup()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  SCALE = 5
  
  char = {}
  char.img = love.graphics.newImage('assets/char.png')
  
  umbrella = {}
  umbrella.img = love.graphics.newImage('assets/umbrella.png')
  
  rain = {}
  rainImg = love.graphics.newImage('assets/rain.png')
end

function Reset()
  speed = 1
  score = 0
  alive = true
  
  char.item = 'none'
  char.health = 1
  char.x = (love.window.getWidth() + char.img:getWidth()) / 2 -- puts the character in the middle of the screen
  char.y = love.window.getHeight() - char.img:getHeight() * SCALE
  
  umbrella.x = 200 -- this will be set later to a random number
  umbrella.y = - 200
  UmbrellaSpawn(umbrella)
  umbrella.health = 5
  umbrella.timerMax = 500
  umbrella.timer = umbrella.timerMax
  
  rainTimerMax = .2
  rainTimer =  rainTimerMax
end  

function Gravity(object, stop, speed, dt) -- applies gravity to an object. Uses dt (delta time) to make sure everything is the same
	if stop == 0 then
    if object.y < love.window.getHeight() - object.img:getHeight() * SCALE then 
      object.y = object.y + 200 * speed * dt 
    end
  else
    if object.y < stop then
      object.y = object.y + 200 * speed * dt
    end
  end
end

function Collide(object, object1, sx, sy)
  return object.x < object1.x + object1.img:getWidth() * sx and
  object1.x < object.x + object.img:getWidth() * sx and
  object.y < object1.y  + object1.img:getHeight() * sy and
  object1.y < object.y + object.img:getHeight() * sy
end

function UmbrellaSpawn(umbrella)
  umbrella.x = math.random(0, love.window.getWidth())
  umbrella.y = - 200
  umbrella.timer = umbrella.timerMax
end 

