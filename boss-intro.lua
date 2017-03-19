function love.load()
  amount=255
  music=love.audio.newSource('music/se/boss-intro.mp3')
  music:play()
end
function love.update(dt)
  amount=amount-255/amount
  if amount<=0 then
    loadState('boss/boss'..love.stage)
  end
end
function love.draw()
  love.graphics.setColor(amount,amount,amount)
  love.graphics.rectangle('fill',0,0,love.graphics.getWidth(),love.graphics.getHeight())
end