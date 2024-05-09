--generate picture load lua files from batch cut
--WIP path of saved files of :encode unknown while executing in zerobrane, but os execute mkdir works
--WIP when executing outside, os . execute doesn't work
-- workaround >> copy file manualy ? (copy content)

--TODO automatically generate lua 'load animation' files
--like this
--doorpics['red']={
--		love.graphics.newImage("doorpics/red/1.png"),
--		love.graphics.newImage("doorpics/red/2.png"),
--		love.graphics.newImage("doorpics/red/3.png"),
--		love.graphics.newImage("doorpics/red/4.png"),
--  }


require 'os'


cutw=64

--zznprj="framestocut/"
--WIP trying to target real project folder
--zznprj="/home/trabitboy/Dropbox/jams/23win32j/zazproject/"
zznprj="/home/trabitboy/Dropbox/jams/bhj24/sourcepics/"

--bhjtmp="/home/trabitboy/love/love/bhj23/"
tmpcut='framestocut/'


batchCut={
  {
    tgtFolder='pinkshot/',
    variable='pinkshot',
    frames={
    '043',
    '044',
    '045',
    },
    coords={
      x=6,
      y=4,
      w=4,
      h=4
    },
    twod=true,
    scale=0.16
  },
  {
    tgtFolder='tank/',
    variable='tank',
    frames={
    '062',
    '063',
    '064',
    },
    coords={
      x=4,
      y=4,
      w=6,
      h=6
    },
    twod=true,
    scale=0.16
  },
  {
    tgtFolder='ply/',
    variable='ply',
    frames={
    '066',
    '067',
    '068',
    },
    coords={
      x=4,
      y=4,
      w=6,
      h=6
    },
    twod=true,
    scale=0.16
  },
}



loadModel="%s[%d]=g3d.newModel('assets/herotest.obj','pics/%s/%s.png', {5,5,0}, {math.pi/2,math.pi,0}, {4,4,4})\n"

loadImage="%s[%d]=love.graphics.newImage('pics/%s/%s.png')\n"


cutPackage=function(frames,coords,tgtfld,variable,
--    tgtw,tgth,
    scale,
    twod,
    box)
  print(variable)
  love.filesystem.createDirectory(tgtfld)
  os.execute('mkdir '
      ..'pics/'
    ..tgtfld
  )
  
  lualoader=string.format('%s={}\n',variable)
  
  for i,f in ipairs(frames)
  do
    srcfile=zznprj..f..".png"
    print(srcfile)
    --for some reason, does not work without doing that
    CopyFile(srcfile,tmpcut..f..".png")
    
    ld=love.image.newImageData(
--      zznprj..
      tmpcut..f..".png")
    
    --we need to go gpu side to scale
    --source tex
    local st=love.graphics.newImage(ld)
    st:setFilter('nearest','nearest')
    
    if scale==nil then
      scale=1
    end
    
    print(' scale '..scale)
    
    if box==true then
      --we calculate scale so that result is 32x32
      scale=32/(cutw*coords.w)
    end
    --target cvs
    
    if box==true then
      tgtcvs=love.graphics.newCanvas(
--      math.floor(cutw*coords.w*scale),
--      math.floor(cutw*coords.h*scale)
      128,128)
    else
     tgtcvs=love.graphics.newCanvas(
      math.floor(cutw*coords.w*scale),
      math.floor(cutw*coords.h*scale)
    )
    end
    --paste scaled st to scaled tgt cvs
    love.graphics.setCanvas(tgtcvs)
    
    if box==true then
      love.graphics.draw(
        st,
        40-cutw*coords.x*scale,
        -cutw*coords.y*scale,
        0,
        scale,
        scale
        )
    else
      love.graphics.draw(
        st,
  --      0,
        -cutw*coords.x*scale,
  --      0,
        -cutw*coords.y*scale,
        0,
        scale,
        scale
        )
    end
    
    love.graphics.setCanvas()
    tosave=tgtcvs:newImageData()
    tgtcvs:release()

    tgtfile=tgtfld..i..".png"
    print("target file for encode "..tgtfile)
    fd=tosave:encode("png",tgtfile)

--    tosave=love.image.newImageData(cutw*coords.w,cutw*coords.h)
    
--    tosave:paste(ld,0,0,coords.x*cutw,coords.y*cutw,cutw*coords.w,cutw*coords.h)
--    tgtfile=tgtfld..i..".png"
--    print("target file for encode "..tgtfile)
--    fd=tosave:encode("png",tgtfile)
    
    if twod==true then
      lualoader=lualoader..string.format(loadImage,variable,tostring(i),variable,tostring(i))
    elseif box==true then
        --nothing for now(modif of asset load)
    else
      lualoader=lualoader..string.format(loadModel,variable,tostring(i),variable,tostring(i))      
    end
--    tmpsrc=bhjtmp..tgtfile
--    print('lua io read '..tmpsrc)
    --TODO we don't use lua io as we are not sure of where tmp folder is when running from zerobrane
    --TODO copy saved file to project folder using lua io
--    CopyFile(tmpsrc,'pics/'..tgtfile)
    
    io.output('pics/'..tgtfile)
    io.write(fd:getString())
    io.close()
  end
  
  io.output(variable..'.lua')
  io.write(lualoader)
  io.close()
  
end





function processBatchCut()
  os.execute('mkdir pics') 
  fsprites=""

 
  for i,p in ipairs(batchCut)
  do
    cutPackage(p.frames,p.coords,p.tgtFolder,p.variable,p.scale,p.twod,p.box)
    fsprites=fsprites.."require('"..p.variable.."')\n"

  end
  
  io.output('sprites.lua')
  io.write(fsprites)
  io.close()

  
  
end


processBatchCut()
love.event.quit()
