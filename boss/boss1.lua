local args={},jumper
local wy,jy,wx,jx
local ey,ex
local jump,hit
local spd=255
local jspd=-80
local action={{p=-200,a=.4,d=1},{p=60,a=.2,d=1},{p=260,a=.5,d=2},{p=-60,a=.3,d=3}}
local active,phz
local elife = 4
local mt = 3
local pause=false

local createItem=function(typ,iny)
  if typ == 1 or not hit then
    table.insert(args,{
        x= (typ==-1)and 50 or wx-70,
        y=iny,
        ty=typ,
      })
  end
end
function love.load()
  math.randomseed(love.timer.getTime())
  love.graphics.setColor(255,255,255)
  beam=love.audio.newSource('music/se/beam.mp3')
  music=love.audio.newSource('music/boss/boss1.mp3')
  music:setLooping(true)
  music:play()
  love.graphics.setDefaultFilter('nearest')
  jumper=love.graphics.newImage('img/jumper.png')
  obstc=love.graphics.newImage('img/beam.png')

  if jy==nil then
    wy=love.graphics.getHeight()-32
    jy=50
    wx=love.graphics.getWidth()
    jx=36
  end
  ex=wx-60
  ey=wy-16
  jump=false
  hit=true

  phz = 3
end
function love.update(dt)
  if not pause then
    mt = mt - dt
    --enemy
    if phz > 0 then
      phz = phz - dt
    else
      active = math.random(1,#action)
      phz = action[active].d
    end
    if active ~= nil then
      ey = (ey + action[active].p * dt) % wy
      if action[active].a ~= 0 and phz % action[active].a < 0.01 then
        createItem(1,ey)
      end
    end
    --jumper
    if jump and not hit then
      jspd = 220
    else
      jspd=jspd-4
    end
    jy=jy-jspd*dt
    if jy<20 then
      jspd = 0
      hit = true
    end
    if jy>wy then
      jspd = 4
      hit = false
    end
    for i,k in ipairs(args) do
      k.x=k.x-k.ty*spd*dt
      if k.x < -32 or k.x > wx+20 then
        table.remove(args,i)
      end

      if math.abs(k.x - jx) < 8 and math.abs(k.y - jy) < 16 then
        loadState('gameover')
      end
      if math.abs(k.x - ex) < 8 and math.abs(k.y - ey) < 16 then
        if mt < 0 then
          beam:play()
          elife = elife -1
          mt = 3
          if elife == 0 then
            love.stage=2
            loadState('game')
          end
        end
      end
    end
    spd=spd+dt*2
  end
end

function love.draw()
  love.graphics.print(string.format('%02d',elife),wx-60,20)
  love.graphics.line(0,wy+20,wx,wy+20,wx,wy+21,0,wy+21)
  love.graphics.draw(jumper,jx,jy,hit and 3.1415 or 0,2,2,8,8)
  love.graphics.draw(jumper,ex,ey,0,2,2)
  for i,k in ipairs(args) do
    love.graphics.draw(obstc,k.x,k.y,(k.ty-1)/2*3.1415,2,2,8,8)
  end
end

function love.mousepressed()
end

function love.touchpressed()
  createItem(-1,jy)
  jump=true
end

function love.touchreleased()
  jump=false
end

function love.keypressed(key)
  if key=='space' and not pause then
    createItem(-1,jy)
    jump=true
  elseif key=='escape' then
    pause=not pause
  end
end

function love.keyreleased(key)
  if key=='space' then
    jump=false
  end
end
