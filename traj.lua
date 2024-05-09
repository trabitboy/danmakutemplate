
function calculateTraj(x1,y1,x2,y2,s,a) --s=step in pixel , a=angle to rotate traj
  -- 
  dx=x2-x1
  dy=y2-y1
  
  --we need to normalize
  h=math.sqrt(dx*dx+dy*dy)

  if h==0 then
    return 0,0
  end

  dx=dx/h
  dy=dy/h
  
  --let's respect pixel step provided
  dx=dx*s
  dy=dy*s
  
  if a~=nil then
    tdx=math.cos(a)*dx-math.sin(a)*dy
    tdy=math.sin(a)*dx+math.cos(a)*dy
    dx=tdx
    dy=tdy
  end
  
  return dx,dy
end