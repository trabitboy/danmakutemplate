bcFireInhib=60

bcRad=32

rdrBC=function(h)
  if h.pic~=nil then
--    love.graphics.draw(
      rdrCentered(
        h.pic[animstep]
      ,h.x,h.y+game.yScroll)
  end
  
  love.graphics.setColor(1,0,0,
    dbgAlpha
--      0.3
    )
  love.graphics.circle('line',h.x,h.y+game.yScroll,bcRad)
  love.graphics.setColor(1,1,1,1)
  
  
--  cloudcat[1]:setTranslation(h.x,h.y,-15-deathTileOffset/3)
--  cloudcat[1]:setScale(6,6,6)
--  cloudcat[1]:setRotation(math.pi/2,0,0)
--  cloudcat[1]:draw()
end



updBC=function(h)
  if outOfScreen(h)==true then
    return
  end
  
  if h.pattern~=nil then
    runPattern(h)
--    local pt=h.pattern
--    --WIP plug programmable patterns
--    h.ptimer=h.ptimer+1
    
--    local inst=pt[h.ppc]
--    --if timer is over instruction count, we increase pc and execute new
--    if h.ptimer>inst.t then
--      --instruction finished
--      h.ptimer=0
--      h.ppc=h.ppc+1
--      if h.ppc > #pt then
--        h.ppc =1
--      end
--      --execute new instruction
--      inst=pt[h.ppc]
--      if inst.ins=='T' then
--        --TODO we shoot targeting player
--        --TODO parameterize speed 
--        local dx,dy = calculateTraj(h.x,h.y,game.px,game.py,5
--          ,inst.a
--          )
        
--        table.insert(game.gos,createBadBlt(h.x,h.y,dx,dy))
        
--      end
      
--    end
    
  else
    --default bullet behavior
    h.inhib=h.inhib+1 
    if h.inhib>=bcFireInhib then
      addMsg('blt fired')
      table.insert(game.gos,createBadBlt(h.x,h.y,0,2))
      h.inhib=0
    end
  end

  if h.vx~=nil and h.vy~=nil and h.l~=nil then
--    addMsg('mv cld')
    h.x=h.x+h.vx 
    h.y=h.y+h.vy 
    h.nScr=math.floor(h.y/(16*mapTileWH))+1
    
    h.elapsed=h.elapsed+math.abs(h.vy)+math.abs(h.vx) 
    if h.elapsed>=h.l then
      h.elapsed=0
      h.vx=-h.vx 
      h.vy=-h.vy
    end
  end
end

function bcDepth(h)
--  return h.y
    --ennemy,height 2
    return 2
end

bcDamage=function(x,y,r,go)
  
  if radColl(x,y,go.x,go.y,r+bcRad)==true then
    playSD(hoq1)
    --WIP I disappear
--    table.remove(game.gos,nbgo)
    addMsg('bc damage')
    triggerexplosion(go.x,go.y)
    go.done=true
    return true
  end

  return false
end

createBC=function(x,y,vx,vy,l,pattern,pic)
  
  ret={}
  ret.pic=pic
  ret.blocksVictory=true
  ret.inhib=0
  ret.type='badcloud'
  ret.x=x
  ret.y=y
  ret.vx=vx
  ret.vy=vy
  ret.l=l
  ret.damage=bcDamage
  ret.nScr=math.floor(y/(16*mapTileWH))+1
  ret.elapsed=0
  ret.rdr=rdrBC
  ret.upd=updBC
  ret.billboard=true
  ret.getDepth=bcDepth
  ret.pattern=pattern
  ret.ptimer=0 --pattern timer
  ret.ppc=1 --pattern program counter
  return ret
end