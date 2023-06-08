ModUtil.RegisterMod( "CleanGlade" )

ModUtil.WrapBaseFunction("EncroachCover", function(baseFunc, args)
    return
end, CleanGlade)

ModUtil.WrapBaseFunction("ToggleCover", function(baseFunc)
    return
end, CleanGlade)
