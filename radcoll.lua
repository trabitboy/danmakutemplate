
radColl=function(x1,y1,x2,y2,r)
  sqr=r*r
  sqw=(x1-x2)*(x1-x2)
  sqh=(y1-y2)*(y1-y2)
  if sqr>=(sqw+sqh) then
    return true
  end
  
  return false
end