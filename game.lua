local args={},jumper
local wy,jy,wx,jx
local jump,hit
local spd=love.stage*50+20
local inispd=spd
local jspd=-80

local OBSTACLE=0
local EARNING=1
local EOS=spd+205 --END OF STAGE SPEED 

local getRndY=function()
  return math.random(1,wy/32-1)*32
end
function love.load()
  music=love.audio.newSource('music/stg'..love.stage..'.mp3')
  music:setLooping(true)
  music:play()
  getCoin=love.audio.newSource('music/se/earn.mp3')
  jumper=love.graphics.newImage('img/jumper.png')
  obstc=love.graphics.newImage('img/obstc.png')
  earng=love.graphics.newImage('img/earning.png')
  score=love.graphics.newText(dotsfont)

  wy=love.graphics.getHeight()-32
  jy=50
  wx=love.graphics.getWidth()
  jx=36

  jump=false
  hit=true

  local i
  for i=1,20 do
    args[i]={
      img=obstc,
      x=math.random(0,wx/32)*32+wx,
      y=getRndY(),
      ys=10,
      kind=OBSTACLE
    }
  end
  for i=21,25 do
    args[i]={
      img=earng,
      x=math.random(0,wx/32)*32+wx,
      y=getRndY(),
      ys=10,
      kind=EARNING
    }
  end
end
function love.update(dt)
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
    k.x=k.x-spd*dt
    k.y=k.y+k.ys*dt
    if k.y>wy or k.y<16 then
      k.ys=-k.ys
    end
    if k.x < -32 then
      k.x=wx
      k.y=getRndY()
    end
    
    if math.abs(k.x - jx) < 8 and math.abs(k.y - jy) < 16 then
      if k.kind==OBSTACLE then
        loadState('gameover')
      elseif k.kind==EARNING then
        getCoin:seek(0)
        getCoin:play()
        love.score=love.score+500
      end
    end
    
    love.score=love.score+dt
    score:setf(math.floor(love.score/50),love.graphics.getWidth()-20,"right")
  end
  spd=spd+dt*2
  if spd>=EOS then
    loadState('boss-intro')
  end
end

function love.draw()
  pos=(spd-inispd)/(EOS-inispd)*wx
  love.graphics.line(0,wy+20,pos,wy+20,pos,wy+21,0,wy+21)
  love.graphics.draw(jumper,jx,jy,hit and 3.1415 or 0,2,2,8,8)
  for i,k in ipairs(args) do
    love.graphics.draw(k.img,k.x,k.y,0,2,2,8,8)
  end
  love.graphics.print("STAGE "..love.stage,20,20)
  love.graphics.draw(score,0,20)
end

function love.mousepressed()
end

function love.touchpressed()
  jump=true
end

function love.touchreleased()
  jump=false
end

function love.keypressed(key)
  if key=='space' then
    jump=true
  end
end

function love.keyreleased(key)
  if key=='space' then
    jump=false
  end
end
