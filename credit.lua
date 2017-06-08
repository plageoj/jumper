local st=0
local strs = '<< JUMPER >> VER 0.0.1...\n\n'..
  '...IS AN OPEN-SOURCE SOFTWARE.\n\n'..
  '...IS LICENSED UNDER\n'..
  'THE APACHE LICENSE 2.0.\n\n'..
  '...IS POWERED BY Love2d 0.10.2.\n'..
  'http://love2d.org\n\n'..
  'FOR MORE INFORMATION VISIT:\n'..
  'https://github.com/plageoj/jumper'
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
  love.graphics.print(strs,20,20,0,love.scaleFactor)
  love.graphics.print("SYSTEM: "..love.system.getOS()..
  "\nRESOLUTION: "..love.graphics.getWidth().."x"..love.graphics.getHeight(),20,love.graphics.getHeight()-100)
end
function love.keypressed()
  loadState("title")
end
function love.mousepressed()
  loadState("title")
end
