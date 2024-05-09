--lvl util
--TODO should take vertical position into account

function getTileNumInLvl(lvl,tx,ty,dbg)
  local ret=-1 --in case we are out of level (x too big ?)
  --WIP get tile on screen (taking level scroll into account)
  --screen is 16*8 (16 tiles)
  
  local scrNum = math.floor(ty/16)+1
--  local scrNum=1 --calculation to be done when scroll implemented
  
  --we divide by 16 to determine current screen
  if scrNum>#curLvl then
    return ret
  end
  
  local scr = lvl[scrNum]
  
  local map=scr.map
  
  --we keep rest of division by 16 to have x on current screen
  local scrTy=ty%16
  
  ret=map[16*(scrTy)+tx+1]
  
  if dbg==true then
    addMsg("scr num "..scrNum .." x in scr "..tx.." y "..scrTy.. " ret "..ret)
  end
  
  return ret
end