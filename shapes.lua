
function rdrsq(color,x,y,l,r)
  love.graphics.push()
		love.graphics.translate( x, y)
  
    love.graphics.push()
    love.graphics.rotate(r)
    love.graphics.setColor(color.r,color.g,color.b)
    love.graphics.rectangle('fill',-l/2,-l/2,l,l)
    love.graphics.setColor(0.,0.,0.)
    love.graphics.rectangle('line',-l/2,-l/2,l,l)
    love.graphics.setColor(1.,1.,1.)
    love.graphics.pop()
  
  love.graphics.pop()
end

--template for sq cloud group
tstcloud={
    {x=-40,y=0,l=35},
    {x=0,y=0,l=50},
    {x=40,y=0,l=30}
  }


function rdrsqcloudm(mode,sc,r,z)
    if z==nil then
      z=1.
    end
    love.graphics.push()
      love.graphics.scale(z,z)
      for i,s in ipairs(sc)
      do
       love.graphics.push()
        love.graphics.translate(s.x,s.y)
        love.graphics.rotate(r)
        --line
        love.graphics.rectangle(mode,-s.l/2,-s.l/2,s.l,s.l)
       love.graphics.pop()
      end
  
    love.graphics.pop()
end

function rdrsqcloud(sc,x,y,r,col,z)
--  love.graphics.origin()  
  love.graphics.push()
--		love.graphics.translate( 540, 540)
	love.graphics.translate( x,y)
--  print(x,y)
  
--render all outlines, then all inside  
    love.graphics.setColor(components(red))
--    love.graphics.circle('line',0,0,200)
    rdrsqcloudm('line',sc,r,z)
    love.graphics.setColor(col.r,col.g,col.b)
    rdrsqcloudm('fill',sc,r,z)


  
  love.graphics.pop()
  
end

--############## start circle cloud

--template for sq cloud group
function getCircleCloud()
  return {
    {x=-40,y=0,l=35},
    {x=0,y=0,l=50},
    {x=40,y=0,l=30}
  }
end


function rdrcclcloudm(mode,cc,r,z)
    for i,s in ipairs(cc)
    do
     love.graphics.push()
      love.graphics.translate(s.x,s.y)
      love.graphics.rotate(r)
      --line
      love.graphics.circle(mode,0,0,s.l*z)
     love.graphics.pop()
    end
  
end

function rdrcccloud(cc,x,y,r,z)
  
  love.graphics.push()
		love.graphics.translate( x, y)
  
--render all outlines, then all inside  
    love.graphics.setColor(0.,0.,0.)
    rdrcclcloudm('line',cc,r,z)
    love.graphics.setColor(1.,1.,1.)
    rdrcclcloudm('fill',cc,r,z)


  
  love.graphics.pop()
  
end
--############## end circle cloud


pw=30
ph=40


function rdrsmb(mode,lr)
   love.graphics.rectangle(mode,-pw/2,-ph/2,pw,ph)
   love.graphics.circle(mode,0,-ph/2*(1+0.5*math.sin(lr)),pw/2*1.5)
  
end

function rdrsml(mode,lr)
   love.graphics.push()
    love.graphics.rotate(lr)
    love.graphics.rectangle(mode,-pw/2,ph/2,pw,ph)
    love.graphics.circle(mode,0,3*ph/2,pw/2)
   love.graphics.pop()
  
end


function rdraml(mode,h,xoff)
   love.graphics.push()
--    love.graphics.rotate(lr)
    love.graphics.circle(mode,xoff,ph/2,pw/4)
    love.graphics.rectangle(mode,xoff-pw/4,ph/2,pw/2,h)
    love.graphics.circle(mode,xoff,h+ph/2,pw/4)
   love.graphics.pop()
  
end


arm1h=ph
arm2h=-ph

--fill or outline,2 passes
function rdrsmdm(mode,lr)
   rdrsmb(mode,lr)
  
   --leg1
   rdrsml(mode,lr)
   
   --leg2
   rdrsml(mode,-lr)
   
   --arm1 state is passed via a global
   rdraml(mode,arm1h,-pw)
   
   --arm2
   rdraml(mode,arm2h,pw)
  
end

--render the stick man :)
function rdrsm(x,y,lr)
  love.graphics.push()
  
   love.graphics.translate(x,y)
  
   --body
   love.graphics.setColor(0.,0.,0.)
   
   rdrsmdm('line',lr)
   
   love.graphics.setColor(1.,1.,1.)
   rdrsmdm('fill',lr)
   
   
  love.graphics.pop()
end


--draw nice adaptative flowers
dfflwrad=20

ptlangles={
--  0,2*math.pi/5,2*2*math.pi/5
}

nptl=5

for i=1,nptl
do
 table.insert(ptlangles, i*2*math.pi/nptl)
end

local function drwptl(mode,pr)
  love.graphics.push()
   love.graphics.rotate(pr)
   love.graphics.translate(0,dfflwrad)
   love.graphics.circle(mode,0,0,dfflwrad)
   
  love.graphics.pop()
  
end

function rdrflwcm(mode,x,y,z)
  love.graphics.push()
   love.graphics.translate(x,y)
   --DBT
   love.graphics.scale(z,z)
   love.graphics.circle(mode,0,0,dfflwrad*(1+0.25*math.cos(tstr)))
  love.graphics.pop()
end

function rdrflwpm(mode,x,y,r,z)
  love.graphics.push()
   love.graphics.translate(x,y)
   love.graphics.rotate(r)
   love.graphics.scale(z,z)
  
   --center of flower
   for i,v in ipairs(ptlangles)
   do
    drwptl(mode,v)
   end
   
   
   
  love.graphics.pop()
end

function rdrflw(x,y,r,z)
  love.graphics.setColor(0.,0.,0.)
  rdrflwpm('line',x,y,r,z)
  love.graphics.setColor(1.,1.,1.)
  rdrflwpm('fill',x,y,r,z)
  love.graphics.setColor(0.,0.,0.)
  rdrflwcm('line',x,y,z)
  love.graphics.setColor(yellow.r,yellow.g,yellow.b)
  rdrflwcm('fill',x,y,z)
  love.graphics.setColor(1.,1.,1.)



end


--to generate a line of squares
function gensql(ret,x1,y1,x2,y2,div,tl)
--  ret={
    
--  }
  
  dx=(x2-x1) /div
  dy=(y2-y1)/div
  
  for i=0,div 
  do
    s={x=x1+dx*i,y=y1+dy*i,l=tl}
    --print('s x '..s.x..' y '..s.y)
    table.insert(ret,s)
  end
  return ret
end

--blit square lines
function rdrsql(sl,r)
  for i,s in ipairs(sl)
  do
    rdrsq(white,s.x,s.y,s.l,r)
  end
  
end

--title lines
--v=
function gentitle()
  --v
  ret=gensql({},100,200,0,0,10,20)
  ret=gensql(ret,100,200,200,0,10,20)
  --x
  txoff=250
  ret=gensql(ret,txoff+0,0,txoff+200,200,10,20)
  ret=gensql(ret,txoff+0,200,txoff+200,00,10,20)
  --r
  rxoff=500
  ret=gensql(ret,rxoff+0,0,rxoff+0,200,10,20)
  ret=gensql(ret,rxoff+0,100,rxoff+100,200,10,20)
  ret=gensql(ret,rxoff+0,0,rxoff+100,0,10,20)
  ret=gensql(ret,rxoff+100,0,rxoff+100,100,10,20)
  ret=gensql(ret,rxoff+0,100,rxoff+100,100,10,20)
  
  
  --r
  
  return ret
end

