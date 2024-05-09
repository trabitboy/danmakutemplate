mapTileWH=64

--gz=-20

----MAP tiles are center coordinates
----1,1 is 8, 8 in camera coords
----so tile 1,1 begins at 4,4 and finishes at 12,12

--nHalfBox=2

----0 1 2 4 10 11
--heights={
----  gz,gz+3
--  }
--heights[0]=gz
--heights[1]=gz
--heights[2]=gz+4

--heights[3]=gz+8 --1x crate

--heights[4]=gz +12   --1.5x skyscraper
--heights[21]=gz +12   --1.5x skyscraper + heart

----WIP to CLOSE levels without impairing visibility
--heights[5]=gz+3
-- --skyscraper
--heights[6]=gz-5 -- fire or spike tile
----heights[6]=gz -- fire or spike tile
--heights[10]=gz --shearts
--heights[11]=gz --gift
--heights[12]=gz --sad guy
--heights[13]=gz --bad cloud
--heights[14]=gz --bad cloud left 2
--heights[15]=gz --bad cloud down 2
--heights[16]=gz --bad cloud down 2



function rdrMap()
    --   tx=5
--    ty=-20
--    tz=0
    local yoff=0
    
    for k,scr in ipairs(curLvl)
    do
      --blit bg
      love.graphics.draw(scr.gfx,0,yoff+game.yScroll)
      
      for j=0,scr.mh-1
      do
        for i=0,scr.mw-1
        do
  --        tnum=curLvl[8*j+i]
          --TODO map is 16 wide, display incorrect

          local tnum=scr.map[scr.mw*(j)+i+1]
--          local wx=i*mapTileWH
--          local wy=j*mapTileWH+yoff-game.yScroll
          
--          if tnum==2 then
--            --destructible
--            --available
--            --4 height bump
----            wcrate:setTranslation(i*8,j*8,gz)
--            wcrate:setTranslation(wx,wy,gz)
--  --          myCrate:setRotation(s.rx,s.ry,0)
--            wcrate:draw()
--          else
          if tnum==3 then
--            nonwalktmp:setTranslation(wx,wy,gz)
--            nonwalktmp:draw()
            
              love.graphics.rectangle('fill',i*mapTileWH,yoff+j*mapTileWH+game.yScroll,mapTileWH,mapTileWH)
--            moonrock:setTranslation(wx,wy,gz)
--            moonrock:draw()
            
          end
        end
      end
      yoff=yoff+mapTileWH*16 --tilewidth * tile num of scr
    end
  
  
  
end