-- explosion x y radius
explosionbhv=function(e,idx)
  e.radius = e.radius -1
  if e.radius <0 then
--      table.remove(gos,idx)
    e.done=true
  end
end

explosionrdr=function(e)
--  print('exp rdr')
--  addMsg('explosion rdr')
  rdrcccloud(e.cc,e.x,e.y-(-game.yScroll),e.initradius,e.radius/e.initradius)  
  --dbg
--  love.graphics.circle('fill',e.x,e.y,e.radius)
end

triggerexplosion= function( lx,ly )
      print(' trigger exp ')
      lexp={x=lx,y=ly,radius=100,initradius=100,collide=false}
      lexp.billboard=true
      
      lexp.upd=explosionbhv
      lexp.rdr=explosionrdr
      lexp.cc=getCircleCloud()
      lexp.getDepth=bcDepth
      table.insert(game.gos,lexp)
end
