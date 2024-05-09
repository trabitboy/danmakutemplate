--helper to cycle through level list ( next +1, previous -1)
function changeLevel(off)
  local tgtLvl=numLvl+off
  
  if tgtLvl>#lvls then
    tgtLvl=1
  end
  
  initLvl(tgtLvl,1)
  
end

--main function to handle lvl init
function initLvl(num,nscr)
  numLvl=num
--  curLvl=levels[numLvl]
--  curLvl=lvls[numLvl]

  curLvl=lvls[numLvl]
  --not used so far
  game={}
  game.gos={}
  -- we create gos based on tile num
  --tile num 10 is a heart (TODO floor +heart)
  
  --TODO lvl now have multiple maps (one per screen)
    local yoff=0

    for k,scr in ipairs(curLvl)
    do

      for j=1,scr.mh 
      do
        for i=1,scr.mw 
        do
          
          local tnum=scr.map[(j-1)*scr.mw +i]
          
          if tnum==2 then
            addMsg('breakable')
            table.insert(game.gos, createBreakable(i,j+yoff/mapTileWH))
          end
          
          if tnum==10 then
              addMsg('static turret')
              table.insert(game.gos, 
                createBC(
                  i*mapTileWH,
                  j*mapTileWH+yoff,
                  0,
                  3
))
    --          table.insert(game.gos,createDTW(i*8,j*8))
    --          table.insert(game.gos,createSadGuy(i,j))
          end

          if tnum==12 then
              addMsg(' moving tank')
              
              table.insert(game.gos, createBC(
                  i*mapTileWH,
                  j*mapTileWH+yoff,
                  0,
                  1,
                  1024,
                  { --shotpattern
                    {ins='W', t=5},
                    {ins='T', t=5, tgt='ply'},
                    {ins='W', t=5},
                    {ins='T', t=5, tgt='ply'},
                    {ins='W', t=5},
                    {ins='T', t=5, tgt='ply'},
                    {ins='W', t=60},
                  },
                  tank
                  
                  ))
    --          table.insert(game.gos,createDTW(i*8,j*8))
    --          table.insert(game.gos,createSadGuy(i,j))
          end


          if tnum==9 then
              addMsg('flying volley')
--              table.insert(game.gos,createSPK(i*8+xoff,j*8))
                table.insert(
                    game.gos,
                    createBoss(
                      nil,
                      i*mapTileWH,j*mapTileWH+yoff,
                      0,0,0,
                      nil,
                      true,                      
                      { --shotpattern
                        {ins='W',t=2}, --work around, first inst is skipped
                        {ins='M',t=60,dx=200,dy=100},
                        {ins='T', t=1, tgt='ply',a=0},
                        {ins='T', t=1, tgt='ply',a=0},
                        {ins='T', t=1, tgt='ply',a=0},
--                        {ins='T', t=1, tgt='ply',a=math.pi/8},
--                        {ins='T', t=1, tgt='ply',a=15*math.pi/8},
                        {ins='M',t=30,dx=100,dy=-1000},
                      }
                    )
                  )
              
--              table.insert(game.gos,createHeart(i+xoff/8,j))
--    --          table.insert(game.gos,createSadGuy(i,j))
          end
          if tnum==13 then
              addMsg('flying volley right')
--              table.insert(game.gos,createSPK(i*8+xoff,j*8))
                table.insert(
                    game.gos,
                    createBoss(
                      nil,
                      i*mapTileWH,j*mapTileWH+yoff,
                      0,0,0,
                      nil,
                      true,                      
                      { --shotpattern
                        {ins='W',t=2}, --work around, first inst is skipped
                        {ins='M',t=60,dx=-200,dy=100},
                        {ins='T', t=1, tgt='ply',a=0},
                        {ins='T', t=1, tgt='ply',a=0},
                        {ins='T', t=1, tgt='ply',a=0},
--                        {ins='T', t=1, tgt='ply',a=math.pi/8},
--                        {ins='T', t=1, tgt='ply',a=15*math.pi/8},
                        {ins='M',t=30,dx=-100,dy=-1000},
                      }
                    )
                  )
              
--              table.insert(game.gos,createHeart(i+xoff/8,j))
--    --          table.insert(game.gos,createSadGuy(i,j))
          end
          if tnum==11 then
              addMsg('c gatling boss')
              if num==1 then
                --first level boss
                createFullCrab(i*mapTileWH,j*mapTileWH+yoff)
              elseif num==2 then
                table.insert(
                    game.gos,
                    createBoss(
                      nil,
                      i*mapTileWH,j*mapTileWH+yoff,
                      0,0,0,
                      nil,
                      true,                      
                      { --shotpattern
                        {ins='W', t=5},
                        {ins='T', t=1, tgt='ply',a=0},
                        {ins='T', t=1, tgt='ply',a=math.pi/8},
                        {ins='T', t=1, tgt='ply',a=2*math.pi/8},
                        {ins='T', t=1, tgt='ply',a=3*math.pi/8},
                        {ins='T', t=1, tgt='ply',a=4*math.pi/8},
                        {ins='T', t=1, tgt='ply',a=5*math.pi/8},
                        {ins='T', t=1, tgt='ply',a=6*math.pi/8},
                        {ins='T', t=1, tgt='ply',a=7*math.pi/8},
                        {ins='T', t=1, tgt='ply',a=8*math.pi/8},
                        {ins='T', t=1, tgt='ply',a=9*math.pi/8},
                        {ins='T', t=1, tgt='ply',a=10*math.pi/8},
                        {ins='T', t=1, tgt='ply',a=11*math.pi/8},
                        {ins='T', t=1, tgt='ply',a=12*math.pi/8},
                        {ins='T', t=1, tgt='ply',a=13*math.pi/8},
                        {ins='T', t=1, tgt='ply',a=14*math.pi/8},
                        {ins='T', t=1, tgt='ply',a=15*math.pi/8},
                      }
                    )
                  )
              elseif num==3 then
                table.insert(
                    game.gos,
                    createBoss(
                      nil,
                      i*mapTileWH,j*mapTileWH+yoff,
                      0,0,0,
                      nil,
                      true,                      
                      { --shotpattern --continuous fire that follows player(spiral)
                        {ins='T', t=0, tgt='ply',a=0},
                        {ins='T', t=0, tgt='ply',a=-math.pi/8},
                        {ins='T', t=0, tgt='ply',a=math.pi/8},
                        {ins='T', t=0, tgt='ply',a=-2*math.pi/8},
                        {ins='T', t=0, tgt='ply',a=2*math.pi/8},
                        {ins='W', t=10},
                        {ins='J',t=0,jmp=-7,rep=4},
                        {ins='M',t=30,dx=800,dy=0},
                        {ins='T', t=0, tgt='ply',a=0},
                        {ins='T', t=0, tgt='ply',a=-math.pi/8},
                        {ins='T', t=0, tgt='ply',a=math.pi/8},
                        {ins='T', t=0, tgt='ply',a=-2*math.pi/8},
                        {ins='T', t=0, tgt='ply',a=2*math.pi/8},
                        {ins='W', t=10},
                        {ins='J',t=0,jmp=-7,rep=4},
--                        {ins='W', t=60},
                        {ins='M',t=30,dx=-400,dy=800},
                        {ins='T', t=0, tgt='ply',a=0},
                        {ins='T', t=0, tgt='ply',a=-math.pi/8},
                        {ins='T', t=0, tgt='ply',a=math.pi/8},
                        {ins='T', t=0, tgt='ply',a=-2*math.pi/8},
                        {ins='T', t=0, tgt='ply',a=2*math.pi/8},
                        {ins='W', t=10},
                        {ins='J',t=0,jmp=-7,rep=4},
--                        {ins='W', t=60},
                        {ins='M',t=30,dx=-400,dy=-800}
                      }
                    )
                  )
              end
--                { --shotpattern --continuous fire that follows player(spiral)
--                  {ins='W', t=5},
--                  {ins='T', t=1, tgt='ply',a=0},
--                }
          
          end
--          if tnum==21 then
--              addMsg('c h')
--    --          table.insert(game.gos,createHeart(i,j,gz+15))
--          end
--          if tnum==12 then
            
--              addMsg('c s g')
--    --          table.insert(game.gos,createSadGuy(i,j))
--          end
--          if tnum==13 then
            
--    --          addMsg('c s g')
--    --          table.insert(game.gos,createBC(i*8,j*8))
--          end
--          if tnum==14 then
            
--    --          addMsg('c s g')
--    --          table.insert(game.gos,createBC(i*8,j*8,0.1,0,16))
--          end
--          if tnum==15 then
            
--    --          addMsg('c s g')
--    --          table.insert(game.gos,createBC(i*8,j*8,0,0.1,16))
--          end
--          if tnum==16 then
            
--    --          addMsg('c s g')
--    --          table.insert(game.gos,createBC(i*8,j*8,0,-0.1,16))
--          end

        end
      end
      yoff=yoff+mapTileWH*16 --tilewidth * tile num of scr

    end  
  --we add ttp go as a workaround for z order (last minute)
  table.insert(game.gos,createTTPGOWrap())
  
--  table.insert(game.gos,createCLD(0,20,0))
--  table.insert(game.gos,createCLD(10,15,0))
--  table.insert(game.gos,createCLD(25,20,0))
--  table.insert(game.gos,createCLD(40,15,0))
--  table.insert(game.gos,createCLD(55,20,0))
--  table.insert(game.gos,createCLD(70,15,0))
--  table.insert(game.gos,createCLD(85,20,0))

--  print(curLvl)
  game.yScroll=-(nscr-1)*16*mapTileWH
  print(' yscroll '..game.yScroll)
  game.currentTile={
    --false, but shouldnt have impact
    --WARN screen 1 is the last one
    tx=curLvl[nscr].px,
    ty=curLvl[nscr].py,
  }
  game.px=curLvl[nscr].px*mapTileWH
  game.py=(-game.yScroll)+curLvl[nscr].py*mapTileWH
  
  game.numLvl=num
  game.pauseTimer=200
  game.hearts=0
--  game.z=gz
  game.nScr=nscr
  game.maxScroll=0
  game.pinhib=0
  game.dzoom=6
  gameLoopState='WELCOME'
--  gameLoopState='GAME'
end

