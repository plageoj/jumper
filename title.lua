local text={}
local pressed=""
function love.load()
  music=love.audio.newSource('music/title.mp3')
  music:setLooping(true)
  music:play()
  font=love.graphics.newFont('assets/Minimal5x7.ttf',130)
  text={
    {
      text=love.graphics.newText(font),
      x={
        stop = 0,
        pos = 0,
        spd = 0
      },
      y={
        stop = love.graphics.getHeight() / 8,
        pos = -100,
        spd = 200
      }
    },
    {
      text=love.graphics.newText(font,"PLAY"),
      x={
        stop = love.graphics.getWidth() / 2,
        pos = -love.graphics.getWidth(),
        spd = 800
      },
      y={
        stop = love.graphics.getWidth(),
        pos = love.graphics.getHeight() / 2 + 50,
        spd = 0
      }
    },
    {
      text=love.graphics.newText(font,"ABOUT"),
      x={
        stop = love.graphics.getWidth() / 2,
        pos = -love.graphics.getWidth(),
        spd = 800
      },
      y={
        stop = love.graphics.getWidth(),
        pos = love.graphics.getHeight() / 2 + 130,
        spd = 0
      }
    }
  }
  text[1].text:addf("<< JUMPER >>",love.graphics.getWidth(),"center",0,0,0,1,1.3)
  love.stage=1
  love.score=0
end

function love.update(dt)
  for i,t in ipairs(text) do
    if t.x.pos < t.x.stop then
      t.x.pos = t.x.pos + dt * t.x.spd
    end
    if t.y.pos < t.y.stop then
      t.y.pos = t.y.pos + dt * t.y.spd
    end
  end
end

function love.draw()
  for i,t in ipairs(text) do
    love.graphics.draw(t.text,t.x.pos,t.y.pos)
  end
  love.graphics.print(pressed,0,0)
end

function love.keypressed(key)
  if key=='escape' then
    love.event.push('quit')
  else
    pressed=key
  end
end

function love.touchpressed(id,x,y)
end

function love.mousepressed(x,y)
  local newState={"game","credit"}
  for i=2,3 do
    if x > text[i].x.pos and x < text[i].x.pos + text[i].text:getWidth() 
    and y > text[i].y.pos and y < text[i].y.pos + text[i].text:getHeight() then
      loadState(newState[i-1])
    end
  end
end

