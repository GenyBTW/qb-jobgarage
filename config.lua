Config = {}

Config.Job = 'change me'-- Job name
Config.car = 'change me' -- Car spawn code
Config.carmenu = 'change me' -- Car spawn code
Config.Pedlocation = { -- Where the ped will spawn
	{
	 	model = 'csb_talcc', -- Ped Model
	 	coords = vector4(-1095.5, -259.57, 37.69, 38.13), -- Currently next to the garage at the life invader building
	 	gender = 'male', -- Change to if they female or male
	 	scenario = 'amb@world_human_cop_idles@male@idle_b', -- The scenario they will play
	},
}

Config.carspawn = { -- Where the car will spawn when you take it out
	["newsvan"] = { -- Put car spawn code
		coords = vector4(-1098.21, -256.4, 37.68, 139.8)
	}
}

Config.Fuel = 'cdn-fuel' -- Your Fuel Script
Config.DistanceSpawn = 20.0 -- Distance to which you can see the npc before it dissapears
Config.Invincible = true -- Will depict if NPC is killable (wont recommend changing)
Config.Frozen = true -- Will Freeze the NPC (wont recommend changing)
Config.Stoic = true -- Dont touch
Config.FadeIn = true -- Makes npc fade in and out when crossing the DistanceSpawn 
Config.MinusOne = true -- DONT TOUCH
Config.GenderNumbers = { -- DONT TOUCH
	['male'] = 4,
	['female'] = 5
}


Config.cartospawn = 'change me' -- Make this the spawn code for the car
Config.cartospawnmenu = 'change me' -- Make this the spawn code for the car


Config.FuelDecor = "_FUEL_LEVEL" -- DONT TOUCH LMFAO
