
--initCrabHealth=30
initCrabHealth=3

crbFireInhib=60

crbCollRad=64

rdrCRB=function(h)
  
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
      1080*h.hp/initCrabHealth,
      mapTileWH/2
      )
    
    
  end
  
  if h.whitemod>0 then
    love.graphics.setColor(1.,0.*(15-h.whitemod)/15,0.*(15-h.whitemod)/15,1.)    
  end  
    
    
  love.graphics.circle('fill',h.x,h.y+game.yScroll,crbCollRad)
    
--    h.pic[1]:setTranslation(h.x,h.y,-15-deathTileOffset/3)
--    h.pic[1]:setRotation(math.pi/2,math.pi,math.pi)
--    h.pic[1]:setScale(25,25,25)
--    h.pic[1]:draw()

  love.graphics.setColor(1.,1.,1.,1.)
  
--  love.graphics.setColor(1.,0.,0.,1.)
--  love.graphics.rectangle('fill',h.x,h.y,64,64)
--  love.graphics.setColor(1.,1.,1.,1.)
  
  
end




updCRB=function(h)
--  print(h)
--  print('upd, crb  scr '..h.nScr..' main '..tostring(h.main))
  if outOfScreen(h)==true then
    return
  end
  
  
  if h.whitemod>0 then
    h.whitemod=h.whitemod-1
  end
  
  h.inhib=h.inhib+1 
  if h.inhib>=bcFireInhib then
    table.insert(game.gos,createBadBlt(h.x,h.y,0,2))
    table.insert(game.gos,createBadBlt(h.x,h.y,0.5,2))
    table.insert(game.gos,createBadBlt(h.x,h.y,-0.5,2))
    h.inhib=0
  end
  
  if radColl(h.x,h.y,game.px,game.py,6)==true and gameLoopState=='GAME' then
    addMsg('bad cloud touched')
          playSD(sperdu)

    toRestartLvl()
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

function crbDepth(h)
  return h.y
  
end

crbDamage=function(x,y,r,go)
  
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
createCRB=function(
    pic,
    x,
    y,
    vx,
    vy,
    l,
    parent,
    main
  )
  
  ret={}
  ret.main=main --boolean, if true damage display
  --and cancel explosion
  ret.whitemod=0
  ret.pic=pic
  ret.hp=initCrabHealth
  ret.blocksVictory=true
  ret.inhib=0
  ret.type='crabboss'
  ret.x=x
  ret.y=y
  ret.vx=vx
  ret.vy=vy
  ret.l=l
  ret.damage=crbDamage
  ret.nScr=math.floor(ret.y/(16*mapTileWH))+1
  ret.elapsed=0
  ret.rdr=rdrCRB
  ret.upd=updCRB
  ret.billboard=true
  ret.parent=parent
  ret.getDepth=bcDepth
  print('create crb '..ret.nScr..' main '..tostring(ret.main))
  return ret
end

createFullCrab=function(x,y)
  table.insert(
    game.gos,
    createCRB(
      nil,
      x,y,
      0,0,0,
      nil,
      true)
    )
  table.insert(game.gos,createCRB(
      nil,
      x-2*mapTileWH,y,
      0,0,0,
      nil,
      false)
    )
  table.insert(game.gos,createCRB(
      nil,
      x+2*mapTileWH,y,
      0,0,0,
      nil,
      false)
    )

end