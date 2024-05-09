
shipRad=32
shipHBRad=8

dogSpd=3

--just to mix with gos
function dummyUpd()
  --nothing on purpose
end  
  
--we refac ply as go so his rendering is common (z ordering)
function createTTPGOWrap()
  ret={}
  ret.type='ply'
  --minimal go interface for rendering
  ret.upd=dummyUpd
  ret.rdr=rdrTTP
  ret.billboard=true
  ret.getDepth=ttpGetDepth

  return ret
end 

function ttpGetDepth()
  return game.py
end



gravity=0.01

--L , R
--TODO D , U
ttpFacing='L'

function getTTPY()
  return game.py
  
end

function rdrTTP()

--  love.graphics.draw(
  rdrCentered(
    ply[animstep],game.px,game.py+game.yScroll)
  
  
  love.graphics.setColor(1,0,0,dbgAlpha)
  love.graphics.circle('line',game.px,game.py+game.yScroll,shipRad)
  love.graphics.circle('line',game.px,game.py+game.yScroll,shipHBRad)
  love.graphics.setColor(1,1,1,1)


  
end


--can be JUMP or WALK
ttdState= "WALK"




--TODO remove
function tileNum(tx,ty)
  return curLvl.mw*(ty-1)+tx
end


function fireDogBlt(gx,gy)
  table.insert(game.gos,createBlt(gx,gy,0,-5))
  playSD(spew)
  addMsg('b f')
end

function updTTP()
--  currentTile
--  addMsg('ttp update')
  
  

  --poc of not walk into other things than ground tile
  -- ( could be whitelisted to several )
  if ttdState=="WALK" then
    if game.pinhib>=0 then
      game.pinhib=game.pinhib-1
    end
    
    local scrollIncrement=0
    
    if game.yScroll<=game.maxScroll then
      
      if autoScroll==true and gameLoopState=="GAME" then
--        addMsg('scroll increment reached')
        scrollIncrement=scrollIncrement+scrollSpd --scrollspeed
      end
      if love.keyboard.isDown('f') then 
        scrollIncrement=scrollIncrement+1
      end
    end
  
    game.yScroll=game.yScroll+scrollIncrement
    if game.yScroll>game.maxScroll then 
      game.yScroll=game.maxScroll 
      scrollIncrement=0 --so ply doesnt autoscroll
    end
    
--    if game.yScroll>16*tileMapWH then
      game.nScr=math.floor( (-game.yScroll) / (16*mapTileWH))+1
--    end
--    addMsg('yscroll '.. game.yScroll ..'nscr '.. game.nScr)
    
    tgtx=game.px
    tgty=game.py-scrollIncrement

    --if we land in a brick due to scroll,
    --we remove scroll increment (dog is pushed back)
    tgtTx=math.floor((tgtx)/mapTileWH)
    tgtTy=math.floor((tgty)/mapTileWH)
    local tgtTnum=getTileNumInLvl(curLvl,tgtTx,tgtTy)
    --if tgt in move we cancel move
--    addMsg('tile under dog aft scroll  '..tgtTnum)
    local blocked=checkBreakable(tgtTx,tgtTy)

    if tgtTnum == 3 or blocked then
      --we cancel scroll contribution to move
      tgty=game.py
    end

    --TODO if pushed below yscroll, > death
    local bottomOfScreen=(-game.yScroll)+17*mapTileWH
--    addMsg('bottom of screen '..bottomOfScreen..' py '..game.py)
--    addMsg(' yscroll '..game.yScroll)
    if game.py>bottomOfScreen  then
      toRestartLvl()
      return
    end

    if gameLoopState~="WELCOME" then
      if love.keyboard.isDown('up') 
--      or touchUp==true
        or touchDY<0 
      then
        tgty=tgty-dogSpd
--        *touchDY
        touchDY=0
--        touchFire=true
      elseif love.keyboard.isDown('down') 
--      or touchDown==true 
        or touchDY>0 
--TO INTEGRATE and tgtx-dogSpd>game.yScroll
      then
        local tmp=tgty+dogSpd
        if tmp>=bottomOfScreen then
          --tgty=tgty
        else
          tgty=tmp
        end
--        *touchDY
        touchDY=0
--        touchFire=true
        
      end
      
      if (love.keyboard.isDown('left')
--      or touchLeft==true 
        or touchDX<0 
      )  
      then
        tgtx=tgtx-dogSpd
--        *touchDX
        touchDX=0
--        touchFire=true
      elseif love.keyboard.isDown('right') 
--      or touchRight==true 
        or touchDX>0 
      then
        tgtx=tgtx+dogSpd
--        *touchDX
        touchDX=0
--        touchFire=true
      end
    end
    
    --we check if tgt is flyable or wall or not
    --WIP why +4 ? 
    tgtTx=math.floor((tgtx)/mapTileWH)
    tgtTy=math.floor((tgty)/mapTileWH)
    tgtTnum=getTileNumInLvl(curLvl,tgtTx,tgtTy)
    --if tgt in move we cancel move
    local blocked=checkBreakable(tgtTx,tgtTy)
    if tgtTnum == 3 
    or blocked==true 
    then
      addMsg("blocked after move")
      return
    end
  
  
    --if so far, move is possible
    game.px=tgtx
    game.py=tgty

--    elseif love.keyboard.isDown('space') then
--    horiMove()
    
    if game.pinhib<=0 and (love.keyboard.isDown('space')
      or touchFire==true
--      or (touchJump==true ) 
        
      ) then
--      game.zsp=0.3
      --FIRE
      fireDogBlt(game.px,game.py)
      game.pinhib=15
      touchFire=nil
    end

  end
end