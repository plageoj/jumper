function love.load()
  music=love.audio.newSource('music/se/fatal.mp3')
  music:play()
end

function love.update()
end

function love.draw()
  love.graphics.print("Game Over",40,440,0,2,2)
  love.graphics.print("Press any key/touch screen",40,510,0)
end

function love.keypressed()
  loadState("title")
end

function love.touchpressed()
  loadState("title")
end

function love.mousepressed()
  loadState("title")
end
