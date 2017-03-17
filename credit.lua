local st=0
local strs = '<< JUMPER >>\n\n'..
  'M.Nakano\nPHYSICS, ANIMATION\n\n'..
  'M.Sugahara\nMUSIC, PROGRAMMING\n\n'..
  'S.Ohya\nLEVEL DESIGN\n\n'..
  'K.Watanabe\nTESTING\n\n'..
  'POWERED BY Love2d\n'..
  'http://love2d.org'
function love.load()
  music = love.audio.newSource('music/stg2.mp3')
  love.audio.play(music)
  love.graphics.setFont(dotsfont)
end
function love.update(dt)
  st=st+dt*2
  if st/4.7>31 then
    loadState('title')
  end
end
function love.draw()
  love.graphics.print(strs,20,20)
end
function love.keypressed()
  loadState("title")
end
function love.mousepressed()
  loadState("title")
end