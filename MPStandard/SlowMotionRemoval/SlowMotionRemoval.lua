ModUtil.RegisterMod( "SlowMotionRemoval" )

ModUtil.WrapBaseFunction("DoCollideSlowCam", function(baseFunc, attackerId, aerialVictim)
    return
end, SlowMotionRemoval)

ModUtil.WrapBaseFunction("DoCollideNoBallCam", function(baseFunc, attackerId, aerialVictim)
    return
end, SlowMotionRemoval)

ModUtil.WrapBaseFunction("DoThrowSlowCam", function(baseFunc)
    return
end, SlowMotionRemoval)

ModUtil.WrapBaseFunction("CheckForInterceptionDuringSlowCam", function(baseFunc)
    return
end, SlowMotionRemoval)

ModUtil.WrapBaseFunction("DoKillSlowCam", function(baseFunc, deadUnit, killer, playerIndex, weapon, useLastKillCam, perfectKill)
    return
end, SlowMotionRemoval)

ModUtil.WrapBaseFunction("LastUnitKillCam", function(baseFunc, deadUnit, killer, playerIndex, weapon, slowFraction)
    return
end, SlowMotionRemoval)

ModUtil.WrapBaseFunction("SlowCamFrames", function(baseFunc, startPoint, teamColor, slowCamFramesDelay)
    return
end, SlowMotionRemoval)

ModUtil.WrapBaseFunction("DoTeleportSlowCam", function(baseFunc, teleporter1, teleporter2)
    return
end, SlowMotionRemoval)

ModUtil.WrapBaseFunction("DoJumpSlowCam", function(baseFunc)
    return
end, SlowMotionRemoval)

ModUtil.WrapBaseFunction("WalkInGoalSlowCam", function(baseFunc)
    return
end, SlowMotionRemoval)

