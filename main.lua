--param ennemies via blue or alpha?

--BUG viewport is square on web


--2 speeds : button kept pressed or not pressed

--ennemies drop pickups
--pickups charge special gauge

--mid boss :
-- if go.blocks victory in current screen, scroll cannot continue (no num screen change)

--WIP fly over with bullet spread ennemy?

--three modules firing in battery
-- doctor doom

--boss language:
-- fire not tgt player
-- print debug inst for patterns

--TODO
-- generic boss.lua with chained patterns ?
--destructible landscape ?
--BUGS

--lvl complete display and lvl status

--shot spd multiplicator

--2nd boss bhv
-- star pattern for central fire

--'corridor' fire (one bullet stray each side of ply)

-- scrolling tank that fires salvo
-- pass shot pattern config as data

-- breakable that stops bullets

-- boss gfx copy cut
-- scrolling tank gfx copy cut
--gfx and non gfx mode

--init level 
--  create ennemies instructions in separate file to allow patching

-- bad cloud with string of bullets that target player
-- (parameterize tx,ty, speed, number , frequency)
-- entering fixed position with vx vy dt, firing or only firing in position

--port vector explosions and square bullets from vxr

-- breakable

-- dbg key

--import maps of gameplay
--import interleaved assets
--destructible map cell flag
-- implement with entity? invisible entity?
-- entity that changes map?

-- hard bg coll flag

--display map suing colored blocks (walls in particular)
--bit rotating shots
--go and have a look at vxf

--let's do fullhd width 1080
--map is 16 tiles x 64 pix width

dbgmsg=true
autoScroll=true
bgColl=true
dbgScroll=5
scrollSpd=1
startLvl=1
startScreen=3
dbgAlpha=0.2

--startLvl=3
--startScreen=2
--pullphonegfx=true
--mapScan=true
--cut=true
--pulltabletgfx=true


love.graphics.setLineWidth(6)

require('copyfile')
if pullphonegfx==true then
    require('pullphone')
--    love.event.quit()
end
if pulltabletgfx==true then
    require('pulltablet')
    love.event.quit()
end

if mapScan==true then
  require('computemaps')
--    love.event.quit()
end
if cut==true then
  require('copycut')
    love.event.quit()
end

require('rdrutil')
require('sprites')
require('animcounter')
require('shapes')
require('explosion')
require('shmuptouch')
require('screencvsinit')
require('ttp')
require('tblutil')
require('lvlutil')
require('screens')
require('lvls')
require('gos')
require('badbullet')
require('bullet')
require('breakable')
require('badcloud')
require('crabboss')
require('ordery')
require('genboss')
require('maingameloop')
require('msg')
require('map')
require('radcoll')
require('sfx')
require('initlevel')
require('traj')


--print(curLvl[2])
--love.event.quit()

initLvl(
--  1,1
  startLvl,startScreen
  )
--curLvl=lvls[1]
--game={
--    px= 512,
--    yScroll=-(#curLvl-1)*16*mapTileWH,
--    maxScroll=0,
--    py= 1300,
--    pinhib=0,
--    nscr=-1
--  }
--game.gos={}
--table.insert(  game.gos,  createTTPGOWrap()  )
--table.insert(
--  game.gos,
--  createBC(
--    200,
--    1300  
--    )
--)

function love.draw()
  gameRender()
  --to be replaced with maingame loop
--  love.graphics.clear()
--  love.graphics.print('beautypattern',300,0)
--  rdrMap()
--  renderBGos()
--  msgToCvs()
end


function love.update()
  gameLoopUpd()
--  updateGos()
--  updTTP()
  
  --dbg 
  if love.keyboard.isDown('j') then
    game.yScroll=game.yScroll+dbgScroll
    addMsg('y scroll '..game.yScroll)
  end
  if love.keyboard.isDown('k') then
    game.yScroll=game.yScroll-dbgScroll
    addMsg('y scroll '..game.yScroll)
  end
end