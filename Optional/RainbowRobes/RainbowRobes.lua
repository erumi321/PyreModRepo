ModUtil.RegisterMod("RainbowRobes")

local loopTime = 7 --number of seconds to go between the full rainbow 
local frameTime = 0.15
local stepNum = loopTime / frameTime

ModUtil.WrapBaseFunction("SetupUnitHouseColors", function(baseFunc, ...)
    if TeamA.Name == "TeamName10" or TeamA.Name == "TeamName11" or TeamB.Name == "TeamName10" or TeamB.Name == "TeamName11" then

        thread(function()
            print(TeamA.MaskHueRGB[1])
            local currentHue = 0
            while finalScore ~= false do
                --Beyonders
                if TeamA.Name == "TeamName10" then
                    SetPlayerUnitProperty({ DestinationIds = TeamAObjectIds, Name = "MaskHue", Value = currentHue })
                    SetPlayerUnitProperty({ DestinationIds = TeamAObjectIds, Name = "MaskHue2", Value = currentHue })
                    
                    TeamA.MaskHueRGB = RainbowRobes.HSVtoRGB( currentHue, 1.0 , 1.0 )
                    TeamA.MaskHueRGB2 = RainbowRobes.HSVtoRGB( currentHue, 1.0, 1.0)
                    ColorTeamBonfire(TeamA)
                end
                --True Nightwings
                if TeamA.Name == "TeamName11" then
                    SetPlayerUnitProperty({ DestinationIds = TeamAObjectIds, Name = "MaskHue", Value = math.abs(180 - currentHue) })
                    SetPlayerUnitProperty({ DestinationIds = TeamAObjectIds, Name = "MaskHue2", Value = math.abs(180 - currentHue) })

                    TeamA.MaskHueRGB = RainbowRobes.HSVtoRGB(math.abs(180 - currentHue), 1.0, 1.0 )
                    TeamA.MaskHueRGB2 = RainbowRobes.HSVtoRGB(math.abs(180 - currentHue), 1.0, 1.0 )
                    ColorTeamBonfire(TeamA)
                end

                --Beyonders
                if TeamB.Name == "TeamName10" then
                    SetPlayerUnitProperty({ DestinationIds = TeamBObjectIds, Name = "MaskHue", Value = currentHue })
                    SetPlayerUnitProperty({ DestinationIds = TeamBObjectIds, Name = "MaskHue2", Value = currentHue })
                    
                    TeamB.MaskHueRGB = RainbowRobes.HSVtoRGB( currentHue, 1.0, 1.0)
                    TeamB.MaskHueRGB2 = RainbowRobes.HSVtoRGB( currentHue, 1.0, 1.0 )
                    ColorTeamBonfire(TeamB)
                end
                --True Nightwings
                if TeamB.Name == "TeamName11" then
                    SetPlayerUnitProperty({ DestinationIds = TeamBObjectIds, Name = "MaskHue", Value = math.abs(180 - currentHue) })
                    SetPlayerUnitProperty({ DestinationIds = TeamBObjectIds, Name = "MaskHue2", Value = math.abs(180 - currentHue) })
                    
                    TeamB.MaskHueRGB = RainbowRobes.HSVtoRGB(math.abs(180 - currentHue), 1.0, 1.0 )
                    TeamB.MaskHueRGB2 = RainbowRobes.HSVtoRGB(math.abs(180 - currentHue), 1.0, 1.0)
                    ColorTeamBonfire(TeamB)
                end

                currentHue = currentHue + (360 / stepNum)

                wait(frameTime)
            end
        end)
    end
    return baseFunc(...)
end, RainbowRobes)

function RainbowRobes.HSVtoRGB( h, S, V )

	local H = h
	while( H < 0 ) do
		H = H + 360
	end
	while( H >= 360 ) do
		H = H - 360
	end
	local R, G, B = 0
	if( V <= 0 ) then
		R = 0
		G = 0
		B = 0
	elseif( S <= 0 ) then
		R = V
		G = V
		B = V
	else
		local hf = H / 60.0
		local i = math.floor( hf )
		local f = hf - i;
		local pv = V * (1 - S)
		local qv = V * (1 - S * f);
		local tv = V * (1 - S * (1 - f))

		-- Red is the dominant color
		if i == 0 then
			R = V;
			G = tv;
			B = pv;
		-- Green is the dominant color
		elseif i == 1 then
			R = qv;
			G = V;
			B = pv;
		elseif i == 2 then
			R = pv;
			G = V;
			B = tv;
		-- Blue is the dominant color
		elseif i == 3 then
			R = pv;
			G = qv;
			B = V;
		elseif i == 4 then
			R = tv;
			G = pv;
			B = V;
		-- Red is the dominant color
		elseif i == 5 then
			R = V;
			G = pv;
			B = qv;
		-- Just in case we overshoot on our math by a little, we put these here. Since its a switch it won't slow us down at all to put these here.
		elseif i == 6 then
			R = V;
			G = tv;
			B = pv;
		elseif i == -1 then
			R = V;
			G = pv;
			B = qv;
		-- The color is not defined, we should throw an error.
		end
	end
	local r = ColorClamp( R * 255.0 )
	local g = ColorClamp( G * 255.0 )
	local b = ColorClamp( B * 255.0 )
	return { r, g, b, 255 }

end