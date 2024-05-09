



rdrBoss=function(h)
  
  if h.main==true then
    love.graphics.setColor(1.,0.,0.)
    love.graphics.rectangle(
      'fill',
      0,
      0,
      1080,
      mapTileWH/2
      )
    love.graphics.setColor(1.,1.,1.)
    love.graphics.rectangle(
      'fill',
      0,
      0,
      1080*h.hp/h.initHealth,
      mapTileWH/2
      )
    
    
  end
  
  if h.whitemod>0 then
    love.graphics.setColor(1.,0.*(15-h.whitemod)/15,0.*(15-h.whitemod)/15,1.)    
  end  
    
    
  love.graphics.circle('fill',h.x,h.y+game.yScroll,h.collRad)
    

  love.graphics.setColor(1.,1.,1.,1.)
  
end




updBoss=function(h)
  
  if outOfScreen(h)==true then
    return
  end
  
  if h.whitemod>0 then
    h.whitemod=h.whitemod-1
  end
  
  if h.pattern~=nil then
    runPattern(h)
    
  end
--  h.inhib=h.inhib+1 
--  if h.inhib>=bcFireInhib then
--    table.insert(game.gos,createBadBlt(h.x,h.y,0,2))
--    table.insert(game.gos,createBadBlt(h.x,h.y,0.5,2))
--    table.insert(game.gos,createBadBlt(h.x,h.y,-0.5,2))
--    h.inhib=0
--  end
  
  if radColl(h.x,h.y,game.px,game.py,6)==true and gameLoopState=='GAME' then
    addMsg('bad cloud touched')
          playSD(sperdu)

    toRestartLvl()
  end

--TODO remove if not used?
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

function bossDepth(h)
  --like ennemies
  return 2
  
end

dmgBoss=function(x,y,r,go)
  
  if radColl(x,y,go.x,go.y,r+crbCollRad)==true then
    
    go.hp=go.hp-1
    
    go.whitemod=15
    
    if go.hp<0 then
      go.done=true
      triggerexplosion(go.x,go.y)
      if go.main==true then
        print('cancel')
        addMsg('CANCEL')
        destroyGosOnScreen(go.nScr)
      end
--      table.remove(game.gos,nbgo)
      playSD(hoq2)
    else
      playSD(hoq1)
      
    end
    return true
  end

  return false
end

--if parent exists, children explode same time as parents
createBoss=function(
    pic,
    x,
    y,
    vx,
    vy,
    l,
    parent,
    main,
    pattern
  )
  
  ret={}
  ret.main=main --boolean, if true damage display
  --and cancel explosion
  ret.whitemod=0
  ret.pic=pic
  ret.initHealth=30
  ret.hp=ret.initHealth
  ret.blocksVictory=true
--  ret.inhib=0
  ret.type='genboss'
  ret.collRad=mapTileWH/2
  ret.x=x
  ret.y=y
  ret.vx=vx
  ret.vy=vy
  ret.l=l
  ret.elapsed=0
  ret.damage=dmgBoss
  ret.nScr=math.floor(ret.y/(16*mapTileWH))+1
  ret.rdr=rdrBoss
  ret.upd=updBoss
  ret.billboard=true
  ret.parent=parent
  ret.getDepth=bossDepth
  ret.pattern=pattern
  ret.ptimer=0
  ret.ppc=1
  print('create genboss '..ret.nScr..' main '..tostring(ret.main))
  return ret
end


--createFullCrab=function(x,y)
--  table.insert(
--    game.gos,
--    createCRB(
--      nil,
--      x,y,
--      0,0,0,
--      nil,
--      true)
--    )
--  table.insert(game.gos,createCRB(
--      nil,
--      x-2*mapTileWH,y,
--      0,0,0,
--      nil,
--      false)
--    )
--  table.insert(game.gos,createCRB(
--      nil,
--      x+2*mapTileWH,y,
--      0,0,0,
--      nil,
--      false)
--    )

--end