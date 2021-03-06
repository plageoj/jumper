local state = nil

function clearState()
  if music ~= nil then
    love.audio.stop(music)
  end
  if state ~= nil then
    package.loaded[state] = nil
    _G[state] = nil
  end
end

function loadState(name)
  clearState()
  state = name
  require(name)
  love.load()
end

function love.load()
  dotsfont=love.graphics.newFont("assets/Minimal5x7.ttf",60)
  font=love.graphics.newFont('assets/Minimal5x7.ttf',130)
  love.graphics.setFont(dotsfont)
  love.graphics.setDefaultFilter('nearest')
  loadState('title')
end

function love.update()
end

function love.draw()
end

function love.keypressed()
end

function love.mousepressed()
end
