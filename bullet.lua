
dogFireRadius=32

rdrBlt=function(h)
  
--  dogfire[animstep]:setTranslation(h.x,h.y,-15-deathTileOffset/3)
--  gift
--  dogfire[animstep]:draw()u
--  addMsg('rdr gift')
  love.graphics.setColor(0,1,1)
  love.graphics.circle('line',h.x,h.y+game.yScroll,dogFireRadius)
  love.graphics.setColor(1,1,1)

end



updBlt=function(h)
  --trying to store this index as workaround
--  local bck=i
  
  --  local consumed = false
  --check if I touch an object that is damagable
  --TODO simplify, give a radius to each GO,
  -- and check coll before calling damage,
  -- try returning directly if coll
  for k,go in ipairs(game.gos)
  do
    if go.damage~=nil then
      consumed=go.damage(h.x,h.y,dogFireRadius,go)
      if consumed==true then
        break
      end
    end
  end

--if h.y > 16*mapTileWH*#curLvl or h.y<=0 then
if h.y > 16*mapTileWH+(-game.yScroll) or h.y<=(-game.yScroll) then
    addMsg('out of screen')
    h.done=true
    return
  end
  
  
  if h.x > 16*mapTileWH or h.x<0 then
    addMsg('out of screen')
    h.done=true
    return
  end
  
  
  if consumed==true then    
--    addMsg('consumed > reverse, remove bug')
    h.done=true
    return
  end
  

  if h.vx~=nil and h.vy~=nil 
--    and h.l~=nil 
    then
    
    --WIP bullet will not need this
--    addMsg('mv cld')
    h.x=h.x+h.vx 
    h.y=h.y+h.vy 
    
    if h.y<0 then h.y=0 end
--    h.elapsed=h.elapsed+math.abs(h.vy)+math.abs(h.vx) 
--    if h.elapsed>=h.l then
--      h.elapsed=0
--      h.vx=-h.vx 
--      h.vy=-h.vy
--    end
  
  end
  h.tx=math.floor(h.x/64)
  h.ty=math.floor(h.y/64)
  addMsg('blt tx ty '..h.tx..' '..h.ty)
  
  
  --if we are on rock solid stone, we disappear
  --TODO tilenum in lvl is wrong
  local tgtTnum=getTileNumInLvl(curLvl,h.tx,h.ty
--    ,true
    )
  --if tgt in move we cancel move
    addMsg('tile under dog aft scroll  '..tgtTnum)
  local blocked=checkBreakable(h.tx,h.ty)

  if (bgColl==true) and (tgtTnum == 3 or blocked 
  or consumed==true )
  then
    --we hit something hard
    addMsg('removed because hard bg')
--    table.remove(game.gos,i)
    h.done=true
  end
  
  
end

function bltDepth(h)
  --TODO should be z value to sort between all billboards
  return h.y
  
end

createBlt=function(x,y,vx,vy,l)
  ret={}
  ret.type='dogbullet'
  ret.x=x
  ret.y=y
  ret.tx=math.floor(x/8)
  ret.ty=math.floor(y/8)
  ret.vx=vx
  ret.vy=vy
  ret.l=l
  ret.elapsed=0
  ret.rdr=rdrBlt
  ret.upd=updBlt
  ret.billboard=true
  ret.getDepth=bltDepth
  return ret
end