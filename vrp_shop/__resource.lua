--[[
    Official DevByteRo Script 
  Forum FiveM: https://forum.fivem.net/u/Enis-Paradoxul/summary
  GITHUB: https: //github.com/devbytero
  DISCORD: https: //discord.gg/eKkUMWb
  GTA5 MODS: https://ro.gta5-mods.com/users/Enis%2DParadoxul  
]]

--------------------------------------------------------------------------------------------------------------------
------------------------------------------- Script made by Enis-Paradoxul  ------------------------------------------
--------------------------------------------------------------------------------------------------------------------
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_script 'lib/Proxy.lua'
server_scripts {
	'@vrp/lib/utils.lua',
	'server.lua'
}

dependencies {
	'vrp',
	'pNotify'
}