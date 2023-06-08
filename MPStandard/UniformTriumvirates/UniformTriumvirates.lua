ModUtil.RegisterMod( "UniformTriumvirates" )

-- Mod to change the robe color of exiles to match the triumvirate colors.


-- Table for saturation and value adjustments for duplicates for each triumvirate. Refer to the PlayerData.Teams table in LeagueGenerationScripts.lua (in the Scripts folder) for the base values.
UniformTriumvirates.adjustmentsTable = {
	-- Nightwings
	{
		HueChange = 210,
		HueChange2 = 10,
		SecondHueChange = 210,
		SecondHueChange2 = 10,
		SaturationAdjustment = 30,
		SaturationAdjustment2 = 30,
		SecondSaturationAdjustment = -25,
		SecondSaturationAdjustment2 = -35,
		ValueAdjustment = -25,
		ValueAdjustment2 = -35,
		SecondValueAdjustment = 35,
		SecondValueAdjustment2 = 35,
	},	
	-- Accusers
	{
		HueChange = 45,
		HueChange2 = 50,
		SecondHueChange = 45,
		SecondHueChange2 = 50,
		SaturationAdjustment = -10,
		SaturationAdjustment2 = -35,
		SecondSaturationAdjustment = 60,
		SecondSaturationAdjustment2 = 30,
		ValueAdjustment =  50,
		ValueAdjustment2 = 40,
		SecondValueAdjustment = -15,
		SecondValueAdjustment2 = -60,
	},
	-- Fate
	{
		HueChange = 40,
		HueChange2 = 290,
		SecondHueChange = 290,
		SecondHueChange2 = 40,
		SaturationAdjustment = 0,
		SaturationAdjustment2 = 10,
		SecondSaturationAdjustment = 50,
		SecondSaturationAdjustment2 = 60,
		ValueAdjustment = 65,
		ValueAdjustment2 = -35,
		SecondValueAdjustment = -25,
		SecondValueAdjustment2 = -45,
	},
	-- Dissidents
	{
		HueChange = 25,
		HueChange2 = 50,
		SecondHueChange = 50,
		SecondHueChange2 = 25,
		SaturationAdjustment = 20,
		SaturationAdjustment2 = 20,
		SecondSaturationAdjustment = 0,
		SecondSaturationAdjustment2 = 20,
		ValueAdjustment = -30,
		ValueAdjustment2 = 40,
		SecondValueAdjustment = 20,
		SecondValueAdjustment2 = 40,
	},	
	-- Withdrawn
	{
		HueChange = 80,
		HueChange2 = 125,
		SecondHueChange = 125,
		SecondHueChange2 = 80,
		SaturationAdjustment = 80,
		SaturationAdjustment2 = 80,
		SecondSaturationAdjustment = 40,
		SecondSaturationAdjustment2 = 40,
		ValueAdjustment = -20,
		ValueAdjustment2 = -50,
		SecondValueAdjustment = 70,
		SecondValueAdjustment2 = 40,
	},	
	-- Pyrehearts
	{
		HueChange = 355,
		HueChange2 = 180,
		SecondHueChange = 180,
		SecondHueChange2 = 355,
		SaturationAdjustment = 20,
		SaturationAdjustment2 = 0,
		SecondSaturationAdjustment = -35,
		SecondSaturationAdjustment2 = -30,
		ValueAdjustment = 20,
		ValueAdjustment2 = 0,
		SecondValueAdjustment = 20,
		SecondValueAdjustment2 = 40,
	},	
	-- Essence
	{
		HueChange = 270,
		HueChange2 = 140,
		SecondHueChange = 140,
		SecondHueChange2 = 270,
		SaturationAdjustment = 20,
		SaturationAdjustment2 = 10,
		SecondSaturationAdjustment = -25,
		SecondSaturationAdjustment2 = 0,
		ValueAdjustment = 0,
		ValueAdjustment2 = -10,
		SecondValueAdjustment = 40,
		SecondValueAdjustment2 = -45,
	},	
	-- Chastity
	{
		HueChange = 40,
		HueChange2 = 340,
		SecondHueChange = 340,
		SecondHueChange2 = 40,
		SaturationAdjustment = 0,
		SaturationAdjustment2 = 0,
		SecondSaturationAdjustment = 30,
		SecondSaturationAdjustment2 = 30,
		ValueAdjustment = 20,
		ValueAdjustment2 = -20,
		SecondValueAdjustment = -35,
		SecondValueAdjustment2 = -35,
	},	
	-- Tempers
	{
		HueChange = 190,
		HueChange2 = 110,
		SecondHueChange = 110,
		SecondHueChange2 = 190,
		SaturationAdjustment = 25,
		SaturationAdjustment2 = 25,
		SecondSaturationAdjustment = 0,
		SecondSaturationAdjustment2 = 0,
		ValueAdjustment = 25,
		ValueAdjustment2 = 25,
		SecondValueAdjustment = 50,
		SecondValueAdjustment2 = 50,
	},
	-- Beyonders
	{
		HueChange = 60,
		HueChange2 = 100,
		SecondHueChange = 350,
		SecondHueChange2 = 350,
		SaturationAdjustment = 40,
		SaturationAdjustment2 = 40,
		SecondSaturationAdjustment = 120,
		SecondSaturationAdjustment2 = 120,
		ValueAdjustment = -190,
		ValueAdjustment2 = -190,
		SecondValueAdjustment = -60,
		SecondValueAdjustment2 = -60,
	},	
	-- True Nightwings
	{
		HueChange = 10,
		HueChange2 = 210,
		SecondHueChange = 10,
		SecondHueChange2 = 210,
		SaturationAdjustment = 50,
		SaturationAdjustment2 = 80,
		SecondSaturationAdjustment = -30,
		SecondSaturationAdjustment2 = -10,
		ValueAdjustment = -30,
		ValueAdjustment2 = 20,
		SecondValueAdjustment = 30,
		SecondValueAdjustment2 = 30,
	},	
	-- Some values as a default for modded triumvirates
	{
		HueChange = 100,
		HueChange2 = 50,
		SecondHueChange = 200,
		SecondHueChange2 = 100,
		SaturationAdjustment = 0,
		SaturationAdjustment2 = 0,
		SecondSaturationAdjustment = 0,
		SecondSaturationAdjustment2 = 0,
		ValueAdjustment = 0,
		ValueAdjustment2 = 0,
		SecondValueAdjustment = 0,
		SecondValueAdjustment2 = 0,
	},	
}

UniformTriumvirates.adjustmentsTableCurs = {
	-- Nightwings
	{
		HueChange = 210,
		HueChange2 = 10,
		SecondHueChange = 210,
		SecondHueChange2 = 10,
		SaturationAdjustment = -20,
		SaturationAdjustment2 = -30,
		SecondSaturationAdjustment = 75,
		SecondSaturationAdjustment2 = 75,
		ValueAdjustment = 50,
		ValueAdjustment2 = 50,
		SecondValueAdjustment = -10,
		SecondValueAdjustment2 = -30,
	},	
	-- Accusers
	{
		HueChange = 45,
		HueChange2 = 60,
		SecondHueChange = 45,
		SecondHueChange2 = 50,
		SaturationAdjustment = 40,
		SaturationAdjustment2 = -20,
		SecondSaturationAdjustment = -10,
		SecondSaturationAdjustment2 = -10,
		ValueAdjustment = 50,
		ValueAdjustment2 = 20,
		SecondValueAdjustment = 40,
		SecondValueAdjustment2 = 40,
	},
	-- Fate
	{
		HueChange = 40,
		HueChange2 = 290,
		SecondHueChange = 290,
		SecondHueChange2 = 40,
		SaturationAdjustment = -10,
		SaturationAdjustment2 = 10,
		SecondSaturationAdjustment = 20,
		SecondSaturationAdjustment2 = 20,
		ValueAdjustment = 65,
		ValueAdjustment2 = -35,
		SecondValueAdjustment = 45,
		SecondValueAdjustment2 = -30,
	},
	-- Dissidents
	{
		HueChange = 25,
		HueChange2 = 50,
		SecondHueChange = 50,
		SecondHueChange2 = 25,
		SaturationAdjustment = 20,
		SaturationAdjustment2 = 20,
		SecondSaturationAdjustment = -20,
		SecondSaturationAdjustment2 = 20,
		ValueAdjustment = 50,
		ValueAdjustment2 = 50,
		SecondValueAdjustment = 40,
		SecondValueAdjustment2 = 50,
	},	
	-- Withdrawn
	{
		HueChange = 125,
		HueChange2 = 80,
		SecondHueChange = 100,
		SecondHueChange2 = 110,
		SaturationAdjustment = 50,
		SaturationAdjustment2 = 50,
		SecondSaturationAdjustment = -10,
		SecondSaturationAdjustment2 = 10,
		ValueAdjustment = 20,
		ValueAdjustment2 = -20,
		SecondValueAdjustment = 80,
		SecondValueAdjustment2 = -40,
	},	
	-- Pyrehearts
	{
		HueChange = 355,
		HueChange2 = 180,
		SecondHueChange = 180,
		SecondHueChange2 = 355,
		SaturationAdjustment = 20,
		SaturationAdjustment2 = 0,
		SecondSaturationAdjustment = -30,
		SecondSaturationAdjustment2 = -30,
		ValueAdjustment = 20,
		ValueAdjustment2 = 0,
		SecondValueAdjustment = 40,
		SecondValueAdjustment2 = 20,
	},	
	-- Essence
	{
		HueChange = 270,
		HueChange2 = 140,
		SecondHueChange = 140,
		SecondHueChange2 = 270,
		SaturationAdjustment = 30,
		SaturationAdjustment2 = 0,
		SecondSaturationAdjustment = -10,
		SecondSaturationAdjustment2 = -10,
		ValueAdjustment = 40,
		ValueAdjustment2 = 0,
		SecondValueAdjustment = 40,
		SecondValueAdjustment2 = -25,
	},	
	-- Chastity
	{
		HueChange = 40,
		HueChange2 = 340,
		SecondHueChange = 340,
		SecondHueChange2 = 40,
		SaturationAdjustment = 10,
		SaturationAdjustment2 = -20,
		SecondSaturationAdjustment = 30,
		SecondSaturationAdjustment2 = 30,
		ValueAdjustment = 0,
		ValueAdjustment2 = 0,
		SecondValueAdjustment = -25,
		SecondValueAdjustment2 = -25,
	},	
	-- Tempers
	{
		HueChange = 110,
		HueChange2 = 190,
		SecondHueChange = 190,
		SecondHueChange2 = 110,
		SaturationAdjustment = 0,
		SaturationAdjustment2 = 0,
		SecondSaturationAdjustment = 20,
		SecondSaturationAdjustment2 = 20,
		ValueAdjustment = 35,
		ValueAdjustment2 = 35,
		SecondValueAdjustment = 35,
		SecondValueAdjustment2 = 35,
	},
	-- Beyonders
	{
		HueChange = 60,
		HueChange2 = 100,
		SecondHueChange = 350,
		SecondHueChange2 = 350,
		SaturationAdjustment = 40,
		SaturationAdjustment2 = 40,
		SecondSaturationAdjustment = 120,
		SecondSaturationAdjustment2 = 120,
		ValueAdjustment = -190,
		ValueAdjustment2 = -190,
		SecondValueAdjustment = -60,
		SecondValueAdjustment2 = -60,
	},	
	-- True Nightwings
	{
		HueChange = 10,
		HueChange2 = 210,
		SecondHueChange = 10,
		SecondHueChange2 = 210,
		SaturationAdjustment = 25,
		SaturationAdjustment2 = 25,
		SecondSaturationAdjustment = -30,
		SecondSaturationAdjustment2 = -30,
		ValueAdjustment = 45,
		ValueAdjustment2 = 45,
		SecondValueAdjustment = 35,
		SecondValueAdjustment2 = 35,
	},	
	-- Some values as a default for modded triumvirates
	{
		HueChange = 100,
		HueChange2 = 50,
		SecondHueChange = 200,
		SecondHueChange2 = 100,
		SaturationAdjustment = 0,
		SaturationAdjustment2 = 0,
		SecondSaturationAdjustment = 0,
		SecondSaturationAdjustment2 = 0,
		ValueAdjustment = 0,
		ValueAdjustment2 = 0,
		SecondValueAdjustment = 0,
		SecondValueAdjustment2 = 0,
	},	
}

UniformTriumvirates.adjustmentsTableWyrms = {
	-- Nightwings
	{
		HueChange = 210,
		HueChange2 = 10,
		SecondHueChange = 210,
		SecondHueChange2 = 10,
		SaturationAdjustment = -30,
		SaturationAdjustment2 = -40,
		SecondSaturationAdjustment = 50,
		SecondSaturationAdjustment2 = 50,
		ValueAdjustment = 50,
		ValueAdjustment2 = 50,
		SecondValueAdjustment = -30,
		SecondValueAdjustment2 = -40,
	},	
	-- Accusers
	{
		HueChange = 45,
		HueChange2 = 50,
		SecondHueChange = 45,
		SecondHueChange2 = 50,
		SaturationAdjustment = -30,
		SaturationAdjustment2 = -30,
		SecondSaturationAdjustment = -20,
		SecondSaturationAdjustment2 = -20,
		ValueAdjustment = 60,
		ValueAdjustment2 = 60,
		SecondValueAdjustment = -30,
		SecondValueAdjustment2 = -45,
	},
	-- Fate
	{
		HueChange = 40,
		HueChange2 = 290,
		SecondHueChange = 40,
		SecondHueChange2 = 290,
		SaturationAdjustment = -20,
		SaturationAdjustment2 = -20,
		SecondSaturationAdjustment = 60,
		SecondSaturationAdjustment2 = 60,
		ValueAdjustment = 50,
		ValueAdjustment2 = 50,
		SecondValueAdjustment = -10,
		SecondValueAdjustment2 = 25,
	},
	-- Dissidents
	{
		HueChange = 25,
		HueChange2 = 50,
		SecondHueChange = 50,
		SecondHueChange2 = 25,
		SaturationAdjustment = 20,
		SaturationAdjustment2 = -20,
		SecondSaturationAdjustment = 0,
		SecondSaturationAdjustment2 = 20,
		ValueAdjustment = -30,
		ValueAdjustment2 = 20,
		SecondValueAdjustment = 20,
		SecondValueAdjustment2 = 50,
	},	
	-- Withdrawn
	{
		HueChange = 80,
		HueChange2 = 125,
		SecondHueChange = 125,
		SecondHueChange2 = 80,
		SaturationAdjustment = 50,
		SaturationAdjustment2 = 50,
		SecondSaturationAdjustment = -25,
		SecondSaturationAdjustment2 = -25,
		ValueAdjustment = -50,
		ValueAdjustment2 = -60,
		SecondValueAdjustment = 0,
		SecondValueAdjustment2 = -60,
	},	
	-- Pyrehearts
	{
		HueChange = 355,
		HueChange2 = 180,
		SecondHueChange = 180,
		SecondHueChange2 = 355,
		SaturationAdjustment = 30,
		SaturationAdjustment2 = -30,
		SecondSaturationAdjustment = -30,
		SecondSaturationAdjustment2 = -30,
		ValueAdjustment = 20,
		ValueAdjustment2 = -45,
		SecondValueAdjustment = 40,
		SecondValueAdjustment2 = 20,
	},	
	-- Essence
	{
		HueChange = 270,
		HueChange2 = 140,
		SecondHueChange = 140,
		SecondHueChange2 = 270,
		SaturationAdjustment = 0,
		SaturationAdjustment2 = 0,
		SecondSaturationAdjustment = -30,
		SecondSaturationAdjustment2 = -30,
		ValueAdjustment = 0,
		ValueAdjustment2 = 0,
		SecondValueAdjustment = 40,
		SecondValueAdjustment2 = 20,
	},	
	-- Chastity
	{
		HueChange = 40,
		HueChange2 = 340,
		SecondHueChange = 340,
		SecondHueChange2 = 40,
		SaturationAdjustment = 20,
		SaturationAdjustment2 = 0,
		SecondSaturationAdjustment = 30,
		SecondSaturationAdjustment2 = 30,
		ValueAdjustment = 40,
		ValueAdjustment2 = -30,
		SecondValueAdjustment = -50,
		SecondValueAdjustment2 = -50,
	},	
	-- Tempers
	{
		HueChange = 110,
		HueChange2 = 190,
		SecondHueChange = 190,
		SecondHueChange2 = 110,
		SaturationAdjustment = -35,
		SaturationAdjustment2 = -35,
		SecondSaturationAdjustment = 20,
		SecondSaturationAdjustment2 = 20,
		ValueAdjustment = 80,
		ValueAdjustment2 = 80,
		SecondValueAdjustment = 80,
		SecondValueAdjustment2 = 80,
	},
	-- Beyonders
	{
		HueChange = 60,
		HueChange2 = 100,
		SecondHueChange = 350,
		SecondHueChange2 = 350,
		SaturationAdjustment = 40,
		SaturationAdjustment2 = 40,
		SecondSaturationAdjustment = 120,
		SecondSaturationAdjustment2 = 120,
		ValueAdjustment = -190,
		ValueAdjustment2 = -190,
		SecondValueAdjustment = -60,
		SecondValueAdjustment2 = -60,
	},	
	-- True Nightwings
	{
		HueChange = 10,
		HueChange2 = 210,
		SecondHueChange = 10,
		SecondHueChange2 = 210,
		SaturationAdjustment = 40,
		SaturationAdjustment2 = 40,
		SecondSaturationAdjustment = -40,
		SecondSaturationAdjustment2 = -40,
		ValueAdjustment = -30,
		ValueAdjustment2 = -30,
		SecondValueAdjustment = 60,
		SecondValueAdjustment2 = 60,
	},	
	-- Some values as a default for modded triumvirates
	{
		HueChange = 100,
		HueChange2 = 50,
		SecondHueChange = 200,
		SecondHueChange2 = 100,
		SaturationAdjustment = 0,
		SaturationAdjustment2 = 0,
		SecondSaturationAdjustment = 0,
		SecondSaturationAdjustment2 = 0,
		ValueAdjustment = 0,
		ValueAdjustment2 = 0,
		SecondValueAdjustment = 0,
		SecondValueAdjustment2 = 0,
	},	
}

UniformTriumvirates.adjustmentsTableImps = {
	-- Nightwings
	{
		HueChange = 210,
		HueChange2 = 10,
		SecondHueChange = 210,
		SecondHueChange2 = 10,
		SaturationAdjustment = 30,
		SaturationAdjustment2 = 30,
		SecondSaturationAdjustment = -20,
		SecondSaturationAdjustment2 = -25,
		ValueAdjustment = 50,
		ValueAdjustment2 = 30,
		SecondValueAdjustment = 50,
		SecondValueAdjustment2 = 50,
	},	
	-- Accusers
	{
		HueChange = 45,
		HueChange2 = 50,
		SecondHueChange = 45,
		SecondHueChange2 = 50,
		SaturationAdjustment = 60,
		SaturationAdjustment2 = 60,
		SecondSaturationAdjustment = -20,
		SecondSaturationAdjustment2 = -30,
		ValueAdjustment = -20,
		ValueAdjustment2 = -20,
		SecondValueAdjustment = 50,
		SecondValueAdjustment2 = 30,
	},
	-- Fate
	{
		HueChange = 40,
		HueChange2 = 290,
		SecondHueChange = 40,
		SecondHueChange2 = 290,
		SaturationAdjustment = 0,
		SaturationAdjustment2 = 0,
		SecondSaturationAdjustment = -10,
		SecondSaturationAdjustment2 = 10,
		ValueAdjustment = 0,
		ValueAdjustment2 = 0,
		SecondValueAdjustment = 65,
		SecondValueAdjustment2 = -25,
	},
	-- Dissidents
	{
		HueChange = 25,
		HueChange2 = 50,
		SecondHueChange = 50,
		SecondHueChange2 = 25,
		SaturationAdjustment = 0,
		SaturationAdjustment2 = 20,
		SecondSaturationAdjustment = 0,
		SecondSaturationAdjustment2 = 20,
		ValueAdjustment = 40,
		ValueAdjustment2 = 50,
		SecondValueAdjustment = 20,
		SecondValueAdjustment2 = 50,
	},	
	-- Withdrawn
	{
		HueChange = 80,
		HueChange2 = 125,
		SecondHueChange = 125,
		SecondHueChange2 = 80,
		SaturationAdjustment = 80,
		SaturationAdjustment2 = 80,
		SecondSaturationAdjustment = 50,
		SecondSaturationAdjustment2 = 50,
		ValueAdjustment = -20,
		ValueAdjustment2 = -40,
		SecondValueAdjustment = 45,
		SecondValueAdjustment2 = -20,
	},	
	-- Pyrehearts
	{
		HueChange = 355,
		HueChange2 = 180,
		SecondHueChange = 180,
		SecondHueChange2 = 355,
		SaturationAdjustment = 0,
		SaturationAdjustment2 = 0,
		SecondSaturationAdjustment = 30,
		SecondSaturationAdjustment2 = 30,
		ValueAdjustment = 0,
		ValueAdjustment2 = 0,
		SecondValueAdjustment = 40,
		SecondValueAdjustment2 = -20,
	},	
	-- Essence
	{
		HueChange = 270,
		HueChange2 = 140,
		SecondHueChange = 140,
		SecondHueChange2 = 270,
		SaturationAdjustment = 0,
		SaturationAdjustment2 = 0,
		SecondSaturationAdjustment = -10,
		SecondSaturationAdjustment2 = -10,
		ValueAdjustment = 0,
		ValueAdjustment2 = 0,
		SecondValueAdjustment = 40,
		SecondValueAdjustment2 = -25,
	},	
	-- Chastity
	{
		HueChange = 40,
		HueChange2 = 340,
		SecondHueChange = 340,
		SecondHueChange2 = 40,
		SaturationAdjustment = 0,
		SaturationAdjustment2 = -20,
		SecondSaturationAdjustment = 20,
		SecondSaturationAdjustment2 = 20,
		ValueAdjustment = 0,
		ValueAdjustment2 = 0,
		SecondValueAdjustment = -20,
		SecondValueAdjustment2 = -20,
	},	
	-- Tempers
	{
		HueChange = 110,
		HueChange2 = 190,
		SecondHueChange = 190,
		SecondHueChange2 = 110,
		SaturationAdjustment = 0,
		SaturationAdjustment2 = 0,
		SecondSaturationAdjustment = 0,
		SecondSaturationAdjustment2 = 0,
		ValueAdjustment = 40,
		ValueAdjustment2 = 40,
		SecondValueAdjustment = 40,
		SecondValueAdjustment2 = 40,
	},
	-- Beyonders
	{
		HueChange = 60,
		HueChange2 = 100,
		SecondHueChange = 350,
		SecondHueChange2 = 350,
		SaturationAdjustment = 40,
		SaturationAdjustment2 = 40,
		SecondSaturationAdjustment = 120,
		SecondSaturationAdjustment2 = 120,
		ValueAdjustment = -190,
		ValueAdjustment2 = -190,
		SecondValueAdjustment = -60,
		SecondValueAdjustment2 = -60,
	},	
	-- True Nightwings
	{
		HueChange = 10,
		HueChange2 = 210,
		SecondHueChange = 10,
		SecondHueChange2 = 210,
		SaturationAdjustment = 20,
		SaturationAdjustment2 = 40,
		SecondSaturationAdjustment = -20,
		SecondSaturationAdjustment2 = -10,
		ValueAdjustment = 30,
		ValueAdjustment2 = 30,
		SecondValueAdjustment = 30,
		SecondValueAdjustment2 = 50,
	},	
	-- Some values as a default for modded triumvirates
	{
		HueChange = 100,
		HueChange2 = 50,
		SecondHueChange = 200,
		SecondHueChange2 = 100,
		SaturationAdjustment = 0,
		SaturationAdjustment2 = 0,
		SecondSaturationAdjustment = 0,
		SecondSaturationAdjustment2 = 0,
		ValueAdjustment = 0,
		ValueAdjustment2 = 0,
		SecondValueAdjustment = 0,
		SecondValueAdjustment2 = 0,
	},	
}

-- Change saturation and value for the second or third pick of the same archetype to make them visually distinct.
function UniformTriumvirates.AdjustDuplicateColors(character,duplicateCount)
	local index = character.TeamIndex
	local teamIndex = 0
	if index == 12 then
		teamIndex = GetConfigOptionValue({ Name = "LocalMPTeamAIndex" })
	else
		teamIndex = GetConfigOptionValue({ Name = "LocalMPTeamBIndex" })
	end
	if teamIndex > 11 then
		teamIndex = 12
	end
	local adj = nil
	if character.Archetype == "PlayerSmall" then
		adj = UniformTriumvirates.adjustmentsTableCurs[teamIndex]
	elseif character.Archetype == "PlayerTrail" then
		adj = UniformTriumvirates.adjustmentsTableWyrms[teamIndex]
	elseif character.Archetype == "PlayerImp" then
		adj = UniformTriumvirates.adjustmentsTableImps[teamIndex]
	else 
		adj = UniformTriumvirates.adjustmentsTable[teamIndex]
	end
	
	-- Adjust saturation and value for duplicates, using values of the above table.
	if duplicateCount == 0 then
		character.MaskHue = League[index].MaskHue
		character.MaskHue2 = League[index].MaskHue2
		character.MaskSaturationAddition = League[index].MaskSaturationAddition
		character.MaskSaturationAddition2 = League[index].MaskSaturationAddition2
		character.MaskValueAddition = League[index].MaskValueAddition
		character.MaskValueAddition2 = League[index].MaskValueAddition2
		-- Take some saturation out for all the Beyonders to match their colorless theme.
		if League[index].UsePhantomShader and teamIndex == 10 then
			character.MaskSaturationAddition = character.MaskSaturationAddition - 40
			character.MaskSaturationAddition2 = character.MaskSaturationAddition2 - 40
		end
	elseif duplicateCount == 1 then
		character.MaskHue = adj.HueChange
		character.MaskHue2 = adj.HueChange2
		character.MaskSaturationAddition = character.MaskSaturationAddition + adj.SaturationAdjustment
		character.MaskSaturationAddition2 = character.MaskSaturationAddition2 + adj.SaturationAdjustment2
		character.MaskValueAddition = character.MaskValueAddition + adj.ValueAdjustment
		character.MaskValueAddition2 = character.MaskValueAddition2 + adj.ValueAdjustment2
	elseif duplicateCount == 2 then
		character.MaskHue = adj.SecondHueChange
		character.MaskHue2 = adj.SecondHueChange2	
		character.MaskSaturationAddition = character.MaskSaturationAddition + adj.SecondSaturationAdjustment
		character.MaskSaturationAddition2 = character.MaskSaturationAddition2 + adj.SecondSaturationAdjustment2
		character.MaskValueAddition = character.MaskValueAddition + adj.SecondValueAdjustment
		character.MaskValueAddition2 = character.MaskValueAddition2 + adj.SecondValueAdjustment2
	end
end

-- We want to determine the duplicate count of archetypes within the same team to change saturation and value for duplicate classes.
function UniformTriumvirates.DetermineDuplicates(character,team,status)
	local duplicateCount = 0
	for i,v in ipairs(team.TeamBench) do
		if v.ActiveStatus == "Assigned" and character.Archetype == v.Archetype then
			duplicateCount = duplicateCount + 1
		end
	end
	return duplicateCount
end

-- When preparing the draft we toggle on the phantom shader for the Beyonders if they are selected.
-- We also change the robe colors of all exiles on the team to the triumvirate colors.
ModUtil.WrapBaseFunction("PrepareLocalMPDraft", function(baseFunc, TeamAid, TeamBid)
	baseFunc(TeamAid,TeamBid)
	local teamlist = {League[TeamAid], League[TeamBid]}
	local benchlist = {League[TeamAid].TeamBench, League[TeamBid].TeamBench}
	local idlist = {TeamAid, TeamBid}
	for i = 1,2,1 do
		if teamlist[i] ~= nil then
			if i == 1 then
				if GetConfigOptionValue({ Name = "LocalMPTeamAIndex" }) == 10 then
					teamlist[i].UsePhantomShader = true
				else
					teamlist[i].UsePhantomShader = false
				end
			else
				if GetConfigOptionValue({ Name = "LocalMPTeamBIndex" }) == 10 then
					teamlist[i].UsePhantomShader = true
				else
					teamlist[i].UsePhantomShader = false
				end
			end
		end
		for k,v in ipairs(benchlist[i]) do
			v.MaskHue = League[idlist[i]].MaskHue
			v.MaskHue2 = League[idlist[i]].MaskHue2
			v.MaskSaturationAddition = League[idlist[i]].MaskSaturationAddition
			v.MaskSaturationAddition2 = League[idlist[i]].MaskSaturationAddition2
			v.MaskValueAddition = League[idlist[i]].MaskValueAddition
			v.MaskValueAddition2 = League[idlist[i]].MaskValueAddition2	
		end
	end
end, UniformTriumvirate)

--We enable the phantom shaders if the Beyonders are selected.
ModUtil.WrapBaseFunction("SetupUnitHouseColors", function(baseFunc, character, objectId)
	baseFunc(character, objectId)
	if TeamA ~= nil then
		if GetConfigOptionValue({ Name = "LocalMPTeamAIndex" }) == 10 then
			TeamA.UsePhantomShader = true
		else
			TeamA.UsePhantomShader = false
		end
	end
	if TeamB ~= nil then
		if GetConfigOptionValue({ Name = "LocalMPTeamBIndex" }) == 10 then
			TeamB.UsePhantomShader = true
		else
			TeamB.UsePhantomShader = false
		end
	end
end, UniformTriumvirate)


-- If an exile belongs to the Beyonders or is Sandra, we add them to the list of phantom shader characters.
ModUtil.WrapBaseFunction("AssignCharacter", function(baseFunc, character, characterId, fromDraftScreen)	
	local count = UniformTriumvirates.DetermineDuplicates(character,League[character.TeamIndex],character.ActiveStatus)
	UniformTriumvirates.AdjustDuplicateColors(character,count)
	
	baseFunc(character, characterId, fromDraftScreen)
	
	if IsMultiplayerMatch() then
		if League[character.TeamIndex].UsePhantomShader or character.FirstName == "Rivals_Captain17_FirstName" then
			PhantomObjectIds[character.ObjectId] = true
		else
			PhantomObjectIds[character.ObjectId] = false
		end
	end
	

end, UniformTriumvirate)

ModUtil.WrapBaseFunction("DraftPlayerModelViewer", function(baseFunc, objectId)		
	if PrevSelectedCharacter ~= nil then
		local index = PrevSelectedCharacter.TeamIndex
		PrevSelectedCharacter.MaskHue = League[index].MaskHue
		PrevSelectedCharacter.MaskHue2 = League[index].MaskHue2
		PrevSelectedCharacter.MaskSaturationAddition = League[index].MaskSaturationAddition
		PrevSelectedCharacter.MaskSaturationAddition2 = League[index].MaskSaturationAddition2
		PrevSelectedCharacter.MaskValueAddition = League[index].MaskValueAddition
		PrevSelectedCharacter.MaskValueAddition2 = League[index].MaskValueAddition2	
	end
	
	if SelectedCharacter ~= nil then
		local count = UniformTriumvirates.DetermineDuplicates(SelectedCharacter,League[SelectedCharacter.TeamIndex],SelectedCharacter.ActiveStatus)
		UniformTriumvirates.AdjustDuplicateColors(SelectedCharacter,count)	
	end
	
	baseFunc(objectId)
end, UniformTriumvirate)

ModUtil.WrapBaseFunction("WinningScore", function(baseFunc)
	local idlist = {12, 13}
	local teamlist = {League[12], League[13]}
	local benchlist = {League[12].TeamBench, League[13].TeamBench}
	for i = 1,2,1 do
		for k,v in ipairs(benchlist[i]) do
			v.MaskHue = League[idlist[i]].MaskHue
			v.MaskHue2 = League[idlist[i]].MaskHue2
			v.MaskSaturationAddition = League[idlist[i]].MaskSaturationAddition
			v.MaskSaturationAddition2 = League[idlist[i]].MaskSaturationAddition2
			v.MaskValueAddition = League[idlist[i]].MaskValueAddition
			v.MaskValueAddition2 = League[idlist[i]].MaskValueAddition2	
		end
	end		
	baseFunc()
end, UniformTriumvirate)