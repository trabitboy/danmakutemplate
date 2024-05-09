--badPlyDetect=6

badFireWidth=4

--we advance one instruction in the pattern
advanceInstruction=function(h)
      
      h.ppc=h.ppc+1
      if h.ppc > #h.pattern then
        h.ppc =1
      end
      local newInst=h.pattern[h.ppc]
      return newInst
end


--execute single instruction
executeSingleInstruction=function(h,inst)
  
      if inst.ins=='T' then
        --we shoot targeting player
        --TODO parameterize speed 
        local dx,dy = calculateTraj(h.x,h.y,game.px,game.py,5
          ,inst.a
          )
        
        table.insert(game.gos,createBadBlt(h.x,h.y,dx,dy))
      elseif inst.ins=='M' then
        --these will move the boss until instruction is finished
        --  {ins='M',t=30,dx=-200,dy=0}
        h.dx=inst.dx/inst.t
        h.dy=inst.dy/inst.t
        print('pat move, dx '..h.dx..' dy '..h.dy)
      elseif inst.ins=='J' then
        --{ins='J',t=0,jmp=-4,rep=4},        
        if h.rep==nil then
          --we enter rep
          h.rep=3
          h.ppc=h.ppc+inst.jmp --generally negative and result above 0
        else
          h.rep=h.rep-1
          if h.rep<=0 then
            --we move forward, go further in inst
            h.rep=nil
          else
            h.ppc=h.ppc+inst.jmp --generally negative and result above 0
          end
        end
        
      end

end

--executes one or more immediate instructions 
--(if t=0 for subsequent instructions> all executed before returning)
executeImmediatePatternInstructions=function(h)
      local pt=h.pattern
      h.ptimer=0
      
      inst=advanceInstruction(h)
      executeSingleInstruction(h,inst)
      
      --while current instruction time code is 0,
      -- we step to next and execute it also (this is used for simultaneous fire)
      while inst.t==0 
      do
        inst=advanceInstruction(h)
        executeSingleInstruction(h,inst)
      end
      
end

function processLastingInstructions(h)
  --processing lasting "M" instructions
  if h.dx~=nil and h.dy~=nil then
    h.x=h.x+h.dx
    h.y=h.y+h.dy
  end
end


--pattern common code
-- runs on gos that has a .pattern and a .ptimer
runPattern=function(h)
      
      --move instructions acts until time out to next inst
      processLastingInstructions(h)
      
      local pt=h.pattern
    h.ptimer=h.ptimer+1
    
    local inst=pt[h.ppc]
    --if timer is over instruction count, we increase pc and execute new
    if h.ptimer>inst.t then
      --clear lasting instructions
      h.dx=nil
      h.dy=nil
      --step to next instruction(s)
      executeImmediatePatternInstructions(h)
    end

  
end

--rdrCentered=function(pic,x,y)
--  love.graphics.draw(pic,x-pic:getWidth()/2,y-pic:getHeight()/2)  
--end

rdrBadBlt=function(h)
  
  local pic=pinkshot[animstep]
  
  rdrCentered(pic,h.x,h.y+game.yScroll)
--  love.graphics.draw(pic,h.x-pic:getWidth()/2,h.y+game.yScroll-pic:getHeight()/2)
  
  love.graphics.setColor(1,0,0,dbgAlpha)
  love.graphics.circle('line',h.x,h.y+game.yScroll,badFireWidth)
  love.graphics.setColor(1,1,1,1)
  
--  addMsg('rdr gift')
end



updBadBlt=function(h,i)
  
  if h.x > 16*mapTileWH or h.x<1 then
--    addMsg('bb disappear')
    h.done=true
    return
  end
  if h.y > 16*mapTileWH*#curLvl or h.y<1 then
    addMsg('out of screen')
    h.done=true
    return
  end

  
  
  -- could be interesting to have baddies breaking blocks?
  --check if I touch an object that is damagable
--  for k,go in ipairs(game.gos)
--  do
--    if go.damage~=nil then
--      consumed=go.damage(h.x,h.y,badFireWidth/2,go,k)
--      if consumed==true then
--        table.remove(game.gos,i)
--        return
--      end
--    end
--  end
  
  if radColl(h.x,h.y,game.px,game.py,badFireWidth+shipHBRad)==true 
--  and          gameLoopState=='GAME' 
  then
    addMsg('ply touched')
          playSD(sperdu)

    toRestartLvl()
  end

  if h.vx~=nil and h.vy~=nil 
--    and h.l~=nil 
    then
    
    --WIP bullet will not need this
--    addMsg('mv cld')
    h.x=h.x+h.vx 
    h.y=h.y+h.vy 
--    h.elapsed=h.elapsed+math.abs(h.vy)+math.abs(h.vx) 
--    if h.elapsed>=h.l then
--      h.elapsed=0
--      h.vx=-h.vx 
--      h.vy=-h.vy
--    end
  
  end
    if h.x > 16*mapTileWH or h.x<1 then
--    addMsg('bb disappear')
    h.done=true
    return
  end
  if h.y > 16*mapTileWH*#curLvl or h.y<1 then
    addMsg('out of screen')
    h.done=true
    return
  end

  h.tx=math.floor(h.x/mapTileWH)
  h.ty=math.floor(h.y/mapTileWH)
  
  --if we are on rock solid stone, we disappear
  local tgtTnum=getTileNumInLvl(curLvl,h.tx,h.ty)
  --if tgt in move we cancel move
--    addMsg('tile under dog aft scroll  '..tgtTnum)
  local blocked=checkBreakable(h.tx,h.ty)

  if tgtTnum == 3 or blocked then
    --we hit something hard
--    table.remove(game.gos,i)
    h.done=true
  end

end

function badBltDepth(h)
  --above ennemies
  return 3
  
end

createBadBlt=function(x,y,vx,vy,l)
  ret={}
  ret.type='badbullet'
  ret.x=x
  ret.y=y
  ret.tx=math.floor(x/8)
  ret.ty=math.floor(y/8)
  ret.vx=vx
  ret.vy=vy
  ret.l=l
  ret.elapsed=0
  ret.rdr=rdrBadBlt
  ret.upd=updBadBlt
  ret.billboard=true
  ret.getDepth=badBltDepth
  return ret
end