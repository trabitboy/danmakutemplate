


rdrBreakable=function(h)
  
--  local tz=-15
--  if h.z~=nil then 
--    tz=h.z
--  end
  
--  wcrate:setScale(h.zoom,h.zoom,h.zoom)
--  wcrate:setTranslation(h.tx*8,h.ty*8,tz)
--  wcrate:setRotation(math.pi/2,0,h.angle)
----  love.graphics.setColor(1.,0.,0.,1.)
--  wcrate:draw()
--  love.graphics.setColor(1.,1.,1.,1.)
--  addMsg('rdr h')
  
  love.graphics.setColor(1.,0.,0.,1.)
  love.graphics.rectangle('fill', h.tx*mapTileWH, h.ty*mapTileWH-(-game.yScroll), mapTileWH, mapTileWH)
  love.graphics.setColor(0.,1.,0.,1.)
  love.graphics.circle('line',h.tx*mapTileWH+mapTileWH/2, h.ty*mapTileWH+mapTileWH/2-(-game.yScroll),mapTileWH/2)
  love.graphics.setColor(1.,1.,1.,1.)
  
end



updBreakable=function(h,i)
  --TODO rotate
  --TODO pickup logic
  
--  if h.state=='spinning' then
    h.angle=h.angle+0.1
    
--    if radColl(game.px,game.py,h.tx*mapTileWH,h.ty*mapTileWH,mapTileWH) then
--      addMsg(' touched by ply '..i)
--      h.state='touched'
----      playSD(ping)
--      playSD(sheart)
--      --for some reason crazy error
----      if gameLoopState=='WELCOME' then
----        gameLoopState='GAME'
----      end
      
----      game.hearts=game.hearts+1
----      return
--    end 
--  elseif h.state=='touched' then
--    h.zoom=h.zoom-0.1
--    if h.zoom<=0 then
--      --delete
--      addMsg('heart removed '..i)
--      table.remove(game.gos,i)
--    end
--  end
  
end

breakableDamage=function(x,y,r,go)
  if radColl(x,y,go.tx*mapTileWH+mapTileWH/2,go.ty*mapTileWH+mapTileWH/2,r+go.rad)==true then
    addMsg('brk dmg>disappear')
    
    go.done=true
    
    return true
  end

  return false
end


createBreakable=function(tx,ty)
  ret={}
  --spinning, touched
--  ret.state='spinning'
  ret.type='breakable'
  ret.damage=breakableDamage --react to bullet
--  ret.liftable=true
  ret.billboard=true
  ret.tx=tx
  ret.ty=ty
--  ret.z=z
  ret.rdr=rdrBreakable
  ret.upd=updBreakable
  ret.angle=0
  ret.getDepth=bcDepth
  ret.rad=mapTileWH/2
--  ret.zoom=8
  return ret
end