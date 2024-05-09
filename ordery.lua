--patched, calls function getDepth()

ordery =function( t )
  r={}
  
  for i,v in ipairs (t)
  do
--    print('looking '..v.y)
    if #r==0 then
--      print('insert '..v.y .. 'first')
      table.insert(r,v)
      
    else
--      print('looking content of r')
      for j,e in ipairs(r)
      do
--        print('comparing with '..e.y)
--        if v.y<=e.y then
        if v:getDepth()<=e:getDepth() then
            table.insert(r,j,v)
            break
        elseif e:getDepth() <=v:getDepth() then
          --if v.y <next element, we insert at next slot
          if r[j+1]==nil then
            table.insert(r,j+1,v)
--            print('insert '..v.y..' pos '..j+1)

            break
          elseif v:getDepth()<=r[j+1]:getDepth() then
            table.insert(r,j+1,v)
--            print('insert '..v.y..' pos '..j+1)
            break            
          end

          --we advance on this inner ipairs until found
          
        end
      end
    end
  end

  return r
end
