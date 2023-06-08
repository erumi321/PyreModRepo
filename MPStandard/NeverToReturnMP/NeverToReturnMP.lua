ModUtil.RegisterMod( "NeverToReturnMP" )

-- Mod to make the character soundtracks and all Never to Return versions available for Multiplayer.
-- Also includes a Liberation Rite mode which is enabled by selecting one of the Never To Return versions, toggling the sermon intro on and choosing Fall of Soliam.
-- Random Track still only chooses between the standard soundtrack. Character soundtracks are not dynamic!


-- Variable to choose between alternating vocal and acoustic versions in Liberation Rite ('true' means alternating, 'false' keeps the vocal version throughout the rite).
NeverToReturnMP.alternating = true

-- For the loading screen and the intro we want different soundtracks than the standard in Liberation Rites. So we execute this code when pressing the 'Commence' button in the Local MP screen.
-- For 'standard' Liberation Rites we select 'The Old Ways'. 
-- If it is a Liberation Rite and the Nightwing version of Never to Return is selected, we play the acoustic version of 'Will of the Scribes'.
ModUtil.WrapBaseFunction("LocalMPConfirmPressed", function(baseFunc)
	PersistVariable({ Name = "LocalMPTrackName" })
	PersistVariable({ Name = "LocalMPMusicId" })
	mId = MusicId
	StopSound({ Id = MusicId, Value = 1.0 })
	musicTrack = GetConfigOptionValue({ Name = "LocalMPMusicTrack" })
	ResetMusicState()
	-- Nightwings Liberation Rite (determined by the song, the actual teams do not matter)
	if NeverToReturnMP.IsMPLiberationRite("prematch") and (LocalMPTrackName ~= "/Music/MatchMusic5_MC" or mId ~= nil) and musicTrack == "/Music/AscensionMatchMusicNightwings_MC" then
		StopSound({ Id = LocalMPMusicId, Value = 1.0 })
		LocalMPMusicId = nil
		LocalMPTrackName = "/Music/MatchMusic5_MC"
		LocalMPMusicId = PlaySound({ Name = LocalMPTrackName })
		PersistVariable({ Name = "LocalMPTrackName" })
		PersistVariable({ Name = "LocalMPMusicId" })
		SetSoundCueValue({ Names = { "Mandolins", "Guitars", "Bass", "Drums", "Vocals", "Flutes", "Keys2", "Toms", "Misc"}, Id = GetMixingId({ }), Value = 0 })
		SetSoundCueValue({ Names = { "Keys" }, Id = GetMixingId({ }), Value = 1 })
	-- 'Normal' Liberation Rite (determined by the song, the actual teams do not matter)
	elseif NeverToReturnMP.IsMPLiberationRite("prematch") and (LocalMPTrackName ~= "/Music/UrsaIdea4_MC"  or mId ~= nil) and musicTrack ~= "/Music/AscensionMatchMusicNightwings_MC" then
		StopSound({ Id = LocalMPMusicId, Value = 1.0 })
		LocalMPMusicId = nil
		LocalMPTrackName = "/Music/UrsaIdea4_MC"
		LocalMPMusicId = PlaySound({ Name = LocalMPTrackName })
		PersistVariable({ Name = "LocalMPTrackName" })
		PersistVariable({ Name = "LocalMPMusicId" })
		SetSoundCueValue({ Names = { "Guitars", "Bass", "Drums"}, Id = LocalMPMusicId, Value = 1})
	-- Standard rite, use standard menu soundtrack.
	elseif not NeverToReturnMP.IsMPLiberationRite("prematch") and (LocalMPTrackName ~= "/Music/OvermapMusic3_MC" or mId ~= nil) then
		-- Since this is the default soundtrack the game reverts to when opening the menu, we only change the soundtrack if necessary, otherwise we just turn the volume up.
		if LocalMPTrackName ~= "/Music/OvermapMusic3_MC" then
			StopSound({ Id = LocalMPMusicId, Value = 1.0 })
			LocalMPMusicId = nil
			LocalMPTrackName = "/Music/OvermapMusic3_MC"
			LocalMPMusicId = PlaySound({ Name = LocalMPTrackName })
			PersistVariable({ Name = "LocalMPTrackName" })
			PersistVariable({ Name = "LocalMPMusicId" })
		else
			SetVolume({ Id = LocalMPMusicId, Value = 1.0, Duration = 0.5 })
		end
		SetDefaultMusicParams( LocalMPTrackName, LocalMPMusicId )
	end	
	baseFunc()
end, NeverToReturnMP)

-- Same as above but in case we use the 'Restart' button.
ModUtil.WrapBaseFunction("RestartMatch", function(baseFunc)
	mId = MusicId
	StopSound({ Id = MusicId, Value = 1.0 })
	musicTrack = GetConfigOptionValue({ Name = "LocalMPMusicTrack" })
	ResetMusicState()
	if NeverToReturnMP.IsMPLiberationRite("prematch") and (LocalMPTrackName ~= "/Music/MatchMusic5_MC" or mId ~= nil) and musicTrack == "/Music/AscensionMatchMusicNightwings_MC" then
		StopSound({ Id = LocalMPMusicId, Value = 1.0 })
		LocalMPMusicId = nil
		LocalMPTrackName = "/Music/MatchMusic5_MC"
		LocalMPMusicId = PlaySound({ Name = LocalMPTrackName })
		PersistVariable({ Name = "LocalMPTrackName" })
		PersistVariable({ Name = "LocalMPMusicId" })
		SetSoundCueValue({ Names = { "Mandolins", "Guitars", "Bass", "Drums", "Vocals", "Flutes", "Keys2", "Toms", "Misc"}, Id = GetMixingId({ }), Value = 0 })
		SetSoundCueValue({ Names = { "Keys" }, Id = GetMixingId({ }), Value = 1 })
	elseif NeverToReturnMP.IsMPLiberationRite("prematch") and (LocalMPTrackName ~= "/Music/UrsaIdea4_MC"  or mId ~= nil) and musicTrack ~= "/Music/AscensionMatchMusicNightwings_MC" then
		StopSound({ Id = LocalMPMusicId, Value = 1.0 })
		LocalMPMusicId = nil
		LocalMPTrackName = "/Music/UrsaIdea4_MC"
		LocalMPMusicId = PlaySound({ Name = LocalMPTrackName })
		PersistVariable({ Name = "LocalMPTrackName" })
		PersistVariable({ Name = "LocalMPMusicId" })
		SetSoundCueValue({ Names = { "Guitars", "Bass", "Drums"}, Id = LocalMPMusicId, Value = 1})
	elseif not NeverToReturnMP.IsMPLiberationRite("prematch") and (LocalMPTrackName ~= "/Music/OvermapMusic3_MC") then
		if LocalMPTrackName ~= "/Music/OvermapMusic3_MC" then
			StopSound({ Id = LocalMPMusicId, Value = 1.0 })
			LocalMPMusicId = nil
			LocalMPTrackName = "/Music/OvermapMusic3_MC"
			LocalMPMusicId = PlaySound({ Name = LocalMPTrackName })
			PersistVariable({ Name = "LocalMPTrackName" })
			PersistVariable({ Name = "LocalMPMusicId" })
		else
			SetVolume({ Id = LocalMPMusicId, Value = 1.0, Duration = 0.5 })
		end
	end
	baseFunc()
end, NeverToReturnMP)

-- In Liberation Rite the draft music is actually the intro of Never to Return, so we start the song here.
ModUtil.WrapBaseFunction("DraftMusic", function(baseFunc, args, musicId)
	baseFunc(args, musicId)
	musicTrack = GetConfigOptionValue({ Name = "LocalMPMusicTrack" })
	ascensionTrack = NeverToReturnMP.IsAscensionMusicTrack(musicTrack)
	if NeverToReturnMP.IsMPLiberationRite("match") and args == "start" then
		StopSound({ Id = LocalMPMusicId, Value = 1.0})
		MusicPlayer( musicTrack )
		SetSoundCueValue({ Names = { "Bass", "Drums" }, Id = GetMixingId({ }), Value = 1, Duration = 0.15 })
		SetSoundCueValue({ Names = { "Misc", "Guitars", "Flutes", "Mandolins" }, Id = GetMixingId({ }), Value = 1 })
	end
end, NeverToReturnMP)

-- When the match starts we fire the trigger that enables the vocals and start the song in case a Never to Return version is chosen without it being a Liberation Rite.
ModUtil.WrapBaseFunction("StartMatchMusic", function(baseFunc, crossfade)
	musicTrack = GetConfigOptionValue({ Name = "LocalMPMusicTrack" })
	ascensionTrack = NeverToReturnMP.IsAscensionMusicTrack(musicTrack)
	siteSermon = NeverToReturnMP.IsMPLiberationSiteSermon()
	if IsMultiplayerMatch() and ascensionTrack then
		-- While the vocals are enabled in a Liberation Rite the Voice is silent.
		if siteSermon then
			blockMatchVO = true
		end
		StopSound({ Id = LocalMPMusicId, Value = 1.0 })
		MusicPlayer( musicTrack )
		SetDefaultMusicParams( MusicName, MusicId )
		FireTrigger({ Name = "PlayAscensionMatchMusic" })
		-- On most maps this line is required to enable the vocals. Even with that it does not work on the Hulk of Ores (it stays acoustic). 
		-- On the Glade of Lu Tariq gives a solo, on the Isle of Khaylmer Celeste does. Maybe I will revisit this later, though having the option for acoustic/solo versions is nice.
		SetSoundCueValue({ Names = { "BardVocals", "RivalBardVocals" }, Id = GetMixingId({ }), Value = 1, Delay = 0.1})
		matchMusic = true
		-- In liberation Rites the starting line is 'Commence!'.
		if siteSermon then
			waitScreenTime(4)
			PlaySpeech({ Name = "/VO/Match_142", Queue = "Always" })
		end
		return
	end
	baseFunc(crossfade)
end, NeverToReturnMP)

-- In a Liberation Rite we want a custom ending speech. It always starts with the line 'And, there it is, at last."
ModUtil.WrapBaseFunction("BallScorePresentation", function(baseFunc, scorer, scoredOnTeam)
	if NeverToReturnMP.IsMPLiberationRite("postmatch") then
		StopAscensionMatchMusicVocals()
		-- Need to block triggered voice lines again in Liberation Rites so the standard lines do not play.
		blockMatchVO = true
		PlaySpeech({ Name = "/VO/Match_555", Queue = "Always" })
	end
	baseFunc(scorer, scoredOnTeam)
	
end, NeverToReturnMP)

-- We want the next lines a bit after the first, so we put it at the beginning of this function, which executes a bit later. Different lines play depending on the triumvirate and the winning score.
ModUtil.WrapBaseFunction("WinningScore", function(baseFunc)
	if NeverToReturnMP.IsMPLiberationRite("postmatch") then
		if TeamA.PyreHealth > TeamB.PyreHealth then
			winningTeamIndex = GetConfigOptionValue({ Name = "LocalMPTeamAIndex" })
			winningTeamScore = TeamA.PyreHealth
		else
			winningTeamIndex = GetConfigOptionValue({ Name = "LocalMPTeamBIndex" })
			winningTeamScore = TeamB.PyreHealth
		end
		thread(NeverToReturnMP.MPLiberationVO, winningTeamIndex, winningTeamScore)
	end
	baseFunc()
	
end, NeverToReturnMP)

-- We disable the character music at the end of Liberation Rites to let Never to Return continue.
ModUtil.WrapBaseFunction("CharacterMusic", function(baseFunc,args,character)
	if NeverToReturnMP.IsMPLiberationRite("postmatch") then
		return
	end
	baseFunc(args,character)
end, NeverToReturnMP)


-- We let IsAscensionWeekMP() return the variable 'alternating' in Liberation Rites since it determines if the vocal and acoustic version alternate.
function NeverToReturnMP.IsAscensionWeekMP()
	if NeverToReturnMP.IsMPLiberationRite("match") then
		return NeverToReturnMP.alternating
	end
end
	
-- This is the function that plays our custom speech.
function NeverToReturnMP.MPLiberationVO(winningTeamIndex, winningTeamScore)
	-- 'The [triumvirate] proved their worth.'
	line1 = League[winningTeamIndex].AscensionVictoryVO
	-- Line depending on the winning score.
	if winningTeamScore >= 70 then
		if CoinFlip() then
			line2 = "/VO/Match_570"
		else
			line2 = "/VO/Match_571"
		end
	elseif winningTeamScore >= 30 then
		if CoinFlip() then
			line2 = "/VO/Match_572"
		else
			line2 = "/VO/Match_573"
		end
	else
		if CoinFlip() then
			line2 = "/VO/Match_574"
		else
			line2 = "/VO/Match_575"
		end
	end
	waitScreenTime(0.5)
	PlaySpeech({ Name = line1, Queue = "Always" })
	waitScreenTime(5.0)
	PlaySpeech({ Name = line2, Queue = "Always" })
	waitScreenTime(5.5)
	-- 'Thus ends the Liberation Rite.'
	PlaySpeech({ Name = "/VO/Justice_797", Queue = "Always" })
end

-- Look up if the selected soundtrack is a Never to Return version.
function NeverToReturnMP.IsAscensionMusicTrack(musicTrack)
	ascensionTrack = false
	for k,v in ipairs(AscensionMusicTrackList) do
		if musicTrack == v then
			ascensionTrack = true
			break
		end
	end
	return ascensionTrack
end

-- Check if both Fall of Soliam and the sermon intro are selected.
function NeverToReturnMP.IsMPLiberationSiteSermon()
	musicTrack = GetConfigOptionValue({ Name = "LocalMPMusicTrack" })
	ascensionTrack = NeverToReturnMP.IsAscensionMusicTrack(musicTrack)
	return (GetConfigOptionValue({ Name = "LocalMPIntroPresentation" }) == "LocalMP_Intro_Long" and GetConfigOptionValue({ Name = "LocalMPMap" }) == "MatchSiteI")
end

-- Check if the rite is a Liberation Rite. Depending on the specific point in the rite this condition is slightly different.
function NeverToReturnMP.IsMPLiberationRite(matchState)
	musicTrack = GetConfigOptionValue({ Name = "LocalMPMusicTrack" })
	ascensionTrack = NeverToReturnMP.IsAscensionMusicTrack(musicTrack)
	siteSermon = NeverToReturnMP.IsMPLiberationSiteSermon()
	multiplayerMatch = IsMultiplayerMatch()
	
	if matchState == "prematch" then
		return (ascensionTrack and siteSermon)
	elseif matchState == "match" then
		return (multiplayerMatch and ascensionTrack and siteSermon)
	else
		return (multiplayerMatch and ascensionTrack and siteSermon and finalScore)
	end
end

-- Adjustment of the trigger for the Ascension Rite for Multiplayer so we do not need to use the IsAscensionWeek() function which may trigger unwanted things.
OnMusicMarker{ "VoxW",
	function( triggerArgs )
		if not NeverToReturnMP.IsAscensionWeekMP() then
			return
		end
		leftBardId = 10000
		rightBardId = 10002
		local markerName = triggerArgs.name
		if markerName == "VoxW" then
			-- toggle vocals and Archjustice VO when song loops
			if not altAscensionMusic then
				altAscensionMusic = true
				blockMatchVO = false
				SetThingProperty({ DestinationId = leftBardId, Name = "LerpCueParamDistance", Value = 0 })
				SetThingProperty({ DestinationId = leftBardId, Name = "LerpCueParamId", Value = 0 })
				SetThingProperty({ DestinationId = rightBardId, Name = "LerpCueParamDistance", Value = 0 })
				SetThingProperty({ DestinationId = rightBardId, Name = "LerpCueParamId", Value = 0 })
				SetSoundCueValue({ Names = { "BardVocals", "RivalBardVocals" }, Id = GetMixingId({ }), Value = 0, Delay = 0.1 })
			else
				altAscensionMusic = false
				blockMatchVO = true
				SetThingProperty({ DestinationId = leftBardId, Name = "LerpCueParamDistance", Value = 6000 })
				SetThingProperty({ DestinationId = leftBardId, Name = "LerpCueParamId", Value = GetMixingId({ }) })
				SetThingProperty({ DestinationId = rightBardId, Name = "LerpCueParamDistance", Value = 6000 })
				SetThingProperty({ DestinationId = rightBardId, Name = "LerpCueParamId", Value = GetMixingId({ }) })
				SetSoundCueValue({ Names = { "BardVocals", "RivalBardVocals" }, Id = GetMixingId({ }), Value = 1, Delay = 0.1 })
			end
		end
	end
}