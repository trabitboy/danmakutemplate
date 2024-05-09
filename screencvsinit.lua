 local system=love.system.getOS()
 
if  system=='Android' or system=='Web' then
   dpiScl=love.window.getDPIScale()

   ww,wh=love.window.getMode()
   ww=ww/dpiScl
   wh=wh/dpiScl
 else 
 
   love.window.setMode(
--     1024,
--     600,
     800,
     600
     )
   ww,wh=love.window.getMode()
 end




--ww=800
--wh=600
--love.window.setMode(ww,wh)


cvsw=1080
cvsh=1080
crt =love.graphics.newCanvas(cvsw,cvsh)

--sx=ww/cvsw
sy=wh/cvsh
