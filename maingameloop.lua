

deathTileMaxOffset=2
deathTileSpeed=0.1
deathTileOffset=0

function checkVictory()
  --is it last screen?
  if game.nScr>1 then 
    return false
  end
  
  --we are on last screen, is there any go on this screen
  --that blocks victory
  for i,go in ipairs(game.gos)
  do
    
    if go.nScr==1 and go.blocksVictory==true then
--      addMsg('blocking go on screen 1')
      return false
    end
  end
  --if we encounter no blocking ennemy on last screen of level,
  --level is won
  return true
  
end


function toRestartLvl()
  gameLoopState='RESTART'
  restartTimer=60
  
end

-- WELCOME
--GAME , RESTART,
-- FINISHED, PAUSE
gameLoopState='WELCOME'
--gameLoopState='GAME'
restartTimer=60

function hoverDeathTime()
  deathTileOffset=deathTileOffset+deathTileSpeed
  if math.abs(deathTileOffset)>=deathTileMaxOffset then
    deathTileSpeed=-deathTileSpeed
  end
end

function gameRender()
    love.graphics.setCanvas(
--      {crt,depth=true}
      crt
      )
--    love.graphics.clear(0.,0.,0.,0.)
--    love.graphics.clear(50/255,100/255,.7)
--    love.graphics.clear(1.,1.,1.,1.)
    love.graphics.clear(.9,.9,1.,1.)
    

    love.graphics.setColor(1.,1.,1.,.5)
    -- TODO bg blit
--    for i=1,#bgsaturn 
--    do
--      local yoff=6*8
--      if (i % 2 == 0) then yoff=0 end
--      bgsaturn[i]:setRotation(math.pi/2,0,0)
--      bgsaturn[i]:setTranslation(
--        8*8+16*8*(i-1),
--        4*8+yoff,
--        game.z
--        -6
--        )
--      bgsaturn[i]:setScale(40,40,40)
--      bgsaturn[i]:draw()
    
--    end
    
    
    love.graphics.setColor(1.,1.,1.,1.)
    
    rdrMap()
    
    
    
--    drawAxis()
--    ttp:setTranslation(game.px,game.py,gz)
--    ttp:draw()
    
--    renderNBGos()
    renderBGos()
    --ttp rdr now part of gos
--    rdrTTP()

--    moon:draw()
--    heart:draw()
    --G3D GL THING tex with alpha clash with skybox (maybe resolution of alpha+depth?)
--    background:draw()
--    blueskybg:draw()
--    rejoiceGuy[1]:draw()
--    herocube:draw()
    
    
    if gameLoopState=='RESTART' then
      love.graphics.setColor(1.,1.,1.,1.-restartTimer/60)
      love.graphics.rectangle('fill',0,0,320,240)
      love.graphics.setColor(1.,1.,1.,1.)
    end
    
--    love.graphics.print('py '..game.py..' px '..game.px
--                        ..'pz '..game.z
--                        ..' ctx '..game.currentTile.tx
--                        ..' cty '..game.currentTile.ty
--                        ,0,0)
    if gameLoopState=='WELCOME' then
      love.graphics.setColor(.2,.2,1.,1.)
      love.graphics.print(
        'BHJ 24'
        ,
        50,
        50
,
        math.pi/16,
        5,
        5
      )
--      love.graphics.setColor(1.,1.,1.,1.)
      love.graphics.setColor(.2,.2,1.,1.)
--      titleBanner[a2step]:setRotation(0,math.pi,math.pi)
--      titleBanner[a2step]:setTranslation(20,10,-10)
--      titleBanner[a2step]:draw()
      
      love.graphics.print(
        'space + arrow keys'
        ,
        100,
        200
,
        -math.pi/16,
        1,
        1
      )   
      love.graphics.setColor(1.,1.,1.,1.)
    end
    
    if gameLoopState=="PAUSE" then
      love.graphics.setColor(.2,.2,1.,1.)
--      titleBanner[a2step]:setRotation(0,math.pi,math.pi)
--      titleBanner[a2step]:setTranslation(20,10,-10)
--      titleBanner[a2step]:draw()
      
      love.graphics.print(
        'pause'
        ,
        100,
        200
,
        -math.pi/16,
        1,
        1
      )   
      love.graphics.setColor(1.,1.,1.,1.)
      
    
    end
    
    if gameLoopState=='FINISHED' then
      love.graphics.print(
        'GAME FINISHED'
        ,
        50,
        50
,
        math.pi/16,
        5,
        5
      )
      
      if numLvl<#lvls then
        addMsg('next level')
--        love.graphics.draw(nextLevelBanner[1],50,0,0,0.2,0.2)
      else
--        love.graphics.draw(victoryBanner[1],50,0,0,0.2,0.2)
        
        
        love.graphics.print(
          'restart to replay ^^'
          ,
          100,
          200
  ,
          -math.pi/16,
          5,
          5
        )
      end
    end
    
--    love.graphics.circle('line',80,120,100)
--    addMsg("game "..game.px..' '..game.py)
    love.graphics.setCanvas()
    crt:setFilter('nearest','nearest')
    love.graphics.draw(crt,0,0,0,
--        sx,sy
        sy,sy
        )
    if dbgmsg==true then
      msgToCvs()
    end


  
end

function gameLoopUpd(dt)
  hoverDeathTime()
  tickanimstep()
--  updateTView(dt)
    
    if 
--    false
    checkVictory()==true 
    then
        addMsg('victory (^o^)')
        game.pauseTimer=game.pauseTimer-1
--        gameLoopState='FINISHED'
        if numLvl==#lvls then
          gameLoopState='FINISHED'
        end

        
        if game.pauseTimer<=0 and numLvl<#lvls then
          initLvl(numLvl+1,#(lvls[numLvl+1]))
          return
        end
        
        
    else
    
      if gameLoopState=='RESTART' then
        restartTimer=restartTimer-1 
        if restartTimer<0 then
          addMsg('restart lvl '..numLvl..' scr '..game.nScr)
          initLvl(numLvl,game.nScr+1)
          gameLoopState='GAME'
          return
        end
      elseif gameLoopState=='GAME' 
          or gameLoopState=='WELCOME'     
        then
        updTTP()
        if gameLoopState=='GAME' then
          updateGos()
        end
        if (love.keyboard.isDown('space')
--          or touchJump==true
          or touchFire==true
          
          ) and gameLoopState=="WELCOME" then
          gameLoopState='GAME'
          return
        end
      end

--      elseif gameLoopState=='WELCOME' then
--      end
    end
--    cameraBehindPlayer()
    if love.keyboard.isDown "escape" then
        love.event.push "quit"
    end


end