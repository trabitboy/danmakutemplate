
animclk=0
a2step=1
animstep=1
a4step=1
a5step=1
a7step=1
animchge=10

function tickanimstep()
 animclk=animclk+1

 if animclk>animchge then 
	animclk=0
  
	a2step=a2step+1
	if a2step>2 then
	 a2step=1
	end
  
  
	animstep=animstep+1
	if animstep>3 then
	 animstep=1
	end
	a4step=a4step+1
	if a4step>4 then
	 a4step=1
	end
	a5step=a5step+1
	if a5step>5 then
	 a5step=1
	end
	a7step=a7step+1
	if a7step>7 then
	 a7step=1
	end

 end 
end
