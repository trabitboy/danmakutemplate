--extract map from grid in png /zzn
--looks for highest number of pixels of a single color in 64x64 square


tank={
    r=243,
    g=0,
    b=0
  }


destructible={
    r=243,
    g=162,
    b=81
  }

wall={
    r=0,
    g=0,
    b=243
}
  
steady={
    r=243,
    g=243,
    b=0
}
  
spike={-- flying from left, dropping volley of bullets, going
    r=0,
    g=243,
    b=0
}

--0,211,0
rightBomber={-- flying from right, dropping volley of bullets, going
    r=0,
    g=211,
    b=0
}


crab={
    r=0,
    g=243,
    b=243
  }

nTank={
    r=tank.r/255,
    g=tank.g/255,
    b=tank.b/255,
  }
  
nDest={
    r=destructible.r/255,
    g=destructible.g/255,
    b=destructible.b/255,
  }

nWall={
    r=wall.r/255,
    g=wall.g/255,
    b=wall.b/255,
  }

nSteady={
    r=steady.r/255,
    g=steady.g/255,
    b=steady.b/255,
  }

nSpike={
    r=spike.r/255,
    g=spike.g/255,
    b=spike.b/255,
  }

nCrab={
    r=crab.r/255,
    g=crab.g/255,
    b=crab.b/255,
  }

nRightBomber={-- flying from right, dropping volley of bullets, going
    r=rightBomber.r/255,
    g=rightBomber.g/255,
    b=rightBomber.b/255,
}


--TODO does not work for some reason
function scale255To1Col(col)
  return {r=col.r/255,g=col.g/255,b=col.b/255}
end
--compares col to r g b
function sameCol(col,r,g,b)
--  print('col '..col.r..' '..col.g..' '..col.b..' r '..r..' g '..g..' b '..b)
  if col.r==r and col.g==g and col.b==b then
    return true
  end
  return false
end
--END OF TODO

cutw=64
fw=1080
fh=1080
tw=math.floor(fw/cutw)
th=math.floor(fh/cutw)


--zznprj="framestocut/"
--WIP trying to target real project folder
--zznprj="/home/trabitboy/Dropbox/jams/23win32j/zazproject/"
zznprj="/home/trabitboy/Dropbox/jams/bhj24/sourcepics/"
tmpcut='framestocut/'

--process conf > generates this format
--legConf={
--    {
      
--      { 
--        id='l1_1',
--        pic='024.png'
--      },
--    }
--  }

newConf={
        {
          s=4,
          e=9
          },
        {
          s=11,
          e=16
          },
        {
          s=17,
          e=20
          },
--        {
--          s=76,
--          e=78
--          },
--        {
--          s=55,
--          e=59
--          },
--        {
--          s=24,
--          e=29
--          },

  }

--wrapper to convert simplified range conf
--to old format 
--tgt;      { 
--        id='l2_6',
--        pic='058.png'
--      },

processConf=function(newConf)
  legConf={}
  
  local nLvl=1
  for i,l in ipairs(newConf)
  do
    --lvl
    local lvl={}
    local nscr=1
    
    --one frame out of two is panel,
    --one frame out of two is data
    descriptor=false
    screenDescriptor={}
    
    for i=l.s,l.e 
    do
      if descriptor==false then
        --first pic is real gfx
        screenDescriptor.dispGfx=string.format("%03d",i)..".png"
        descriptor =not descriptor
      else
        --compute file name with format
        screenDescriptor.pic = string.format("%03d",i)..".png"
        --compute id
        screenDescriptor.id='l'..nLvl..'_'..nscr
      
        table.insert(lvl,screenDescriptor)
        nscr=nscr+1
        screenDescriptor={}
        descriptor =not descriptor
      end
    end
    
    table.insert(legConf,lvl)
    nLvl=nLvl+1 --used to compute screen name 
  end
  return legConf
end


function computeTileNum(id,xt,yt)
  local ret=0
  
--  print('xt '..xt..' yt '..yt)
  local j=0
  for j=0,cutw-1
  do
--    lineDbg=''
    local i=0
    for i=0,cutw-1
    do
      r,g,b,a=id:getPixel(xt*64+i,yt*64+j)
      
--      lineDbg=lineDbg..'d '..r..' '..g..' '..b..' '..a..' ;'
      if r==nDest.r and g==nDest.g and b==nDest.b then
        ret=2--brkable
        break
      elseif r==nWall.r and g==nWall.g and b==nWall.b  then
        ret=3
        break
      elseif r==nSpike.r and g==nSpike.g and b==nSpike.b  then
        ret=9 --spike
        break
      elseif r==nSteady.r and g==nSteady.g and b==nSteady.b  then
        ret=10 --bc
        break
      elseif r==nCrab.r and g==nCrab.g and b==nCrab.b  then
        ret=11 --crb
        break
      elseif r==nTank.r and g==nTank.g and b==nTank.b  then
        ret=12 --crb
        break
--      elseif sameCol(scale255To1Col(rightBomber,r,g,b))==true then
      elseif r==nRightBomber.r and g==nRightBomber.g and b==nRightBomber.b  then
        ret=13 --right bomber
        break
      end
    end
--    print(lineDbg)
  end
  
--  print(ret)
  return ret
end


function analyzePic(c)
  
  local sRet=c.id.."={ px=3, py=8, mw="..tw..",mh="..th..",map={"
  local ret={} --collected map data in there
  
  srcfile=zznprj..c.pic
--  print(srcfile)
  
   CopyFile(srcfile,tmpcut..c.pic)

  ld=love.image.newImageData(
--    zznprj..c.pic
    tmpcut..c.pic
  )
  
  --TODO flip image data using render to tex
  
  --ld is 1080x1080
  local j=0
  --WIP trying to invert y lookup to flip map vertically
  --(to match game display with analyzed bitmap)
  
--  for j=th-1,0,-1 
  for j=0,th-1 
  do
    local i=0
    for i=0,tw-1
    do
      --we analyse a 64x64 square and return a tilenum
      local tnum=computeTileNum(ld,i,j)
      
      table.insert(ret,tnum)
      sRet=sRet..tnum..','
    end
    sRet=sRet.."\n"
  end
  
  sRet=sRet.."}\n"

  sRet=sRet..",gfx=love.graphics.newImage('sourcepics/"..c.dispGfx.."')"
  
  sRet=sRet.."}"
  print(sRet)
  
  io.output('screens/'..c.id..'.lua')
  io.write(sRet)
  io.close()

  return ret
  
end

function computeMaps()
  
  fscreens=""
  flvls="lvls={\n"
  
  local tmpconf=processConf(newConf)
  
  for k,lvl in ipairs(tmpconf)
  do
    flvls=flvls.."{"
--    for j,c in ipairs(lvl)
    for j=#lvl,1,-1
    do
      c=lvl[j]
      --TODO reverse order
      analyzePic(c)
      fscreens=fscreens.."require('screens/"..c.id.."')\n"
      flvls=flvls..c.id..",\n"
    end
    flvls=flvls.."},\n"
    
  end
  
  flvls=flvls.."}"
  
  io.output('screens.lua')
  io.write(fscreens)
  io.close()
  
  
  io.output('lvls.lua')
  io.write(flvls)
  io.close()
  
  
end

computeMaps()

--love.event.quit()

