function destroyGosOnScreen(nscr)
  print('destroy gos on scr '..nscr)
  for i,go in ipairs(game.gos)
  do
    if 
    go.type~='ply' and 
    go.nScr==nscr then
      print('go destroyed')
      go.done=true
    end 
  end
end

function outOfScreen(go)
  if go.y>((-game.yScroll)+1080) 
  or go.y<(-game.yScroll) 
  then
    return true
  end
  
  return false
end

--we check if blocked by non map object
function checkBreakable(tx,ty)
  local ret = false
  for i,go in ipairs(game.gos)
  do
    if go.type=='breakable' and go.tx==tx and go.ty==ty then
      ret=true
      break
    end
  end
  return ret
end

-- ennemies and crates logic
function updateGos()
  for i,go in ipairs(game.gos)
  do 
    go.upd(go,i)
  end

  --delete gos that are 'done=true'
  for i=#game.gos,1,-1
  do
    if (game.gos)[i].done==true then 
      table.remove(game.gos,i)
      --that way no hole or number rearrange
    end
  end

end

--rdr non billboard gos (was for 3d code)
function renderNBGos()
--  addMsg('rdr gos '..tbllngth(gos))
  for n,v in ipairs(game.gos)
  do
--    addMsg('rdr go')
    if v.billboard==nil then
      v:rdr()
    end
  end
end


--back to front render taking depth into account
function renderBGos()
--  addMsg('rdr gos '..tbllngth(gos))
  local filter={}
  for n,v in ipairs(game.gos)
  do
--    addMsg('rdr go')
    if v.billboard==true then
      table.insert(filter,v)
    end
  end
  
  
  --order bilb gos via getDepth
  local ordered=ordery(filter)
  
  local reverseOrder={}
  for n,v in ipairs(ordered)
  do
    table.insert(reverseOrder,1,v)
  end
  
  for n,v in ipairs(reverseOrder)
  do
      v:rdr()
  end
end

