ping=love.sound.newSoundData("sounds/ping.wav")
yes=love.sound.newSoundData("sounds/yes.wav")
shappy=love.sound.newSoundData("sounds/happy.wav")
smarche=love.sound.newSoundData("sounds/marche.wav")
sperdu=love.sound.newSoundData("sounds/perdu.wav")
sheart=love.sound.newSoundData("sounds/heart.wav")

spew=love.sound.newSoundData(
--  "sounds/lowpew.wav"
  "sounds/pwww.wav"  
  )

hoq1=love.sound.newSoundData(
--  "sounds/lowpew.wav"
  "sounds/hoq1.wav"  
  )
hoq2=love.sound.newSoundData(
--  "sounds/lowpew.wav"
  "sounds/hoq2.wav"  
  )

--floutch=love.sound.newSoundData("floutch.wav")
--rouleau=love.sound.newSoundData("rouleau.wav")
--ouverture=love.sound.newSoundData("ouverture.wav")
--peindre=love.sound.newSoundData("peindre.wav")


function playSD(sd)
  love.audio.play(love.audio.newSource(sd))
end

