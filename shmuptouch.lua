touchDY=0
touchDX=0

function love.touchmoved(id,x,y,dx,dy)
  touchDX=dx
  touchDY=dy
--  addMsg('touch move press dx dy '..touchDX..' '..touchDY)
  touchFire=true
end

function love.touchpressed(id,x,y,dx,dy)
  touchDX=dx
  touchDY=dy
--  addMsg('touch press dx dy '..touchDX..' '..touchDY)
  
end

function love.touchreleased(id,x,y,dx,dy,pressure)
  touchDX=0
  touchDY=0
  addMsg('touch release dx dy '..touchDX..' '..touchDY)

end
