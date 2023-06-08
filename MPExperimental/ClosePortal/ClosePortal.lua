ModUtil.RegisterMod("ClosePortals")
ModUtil.WrapBaseFunction("SpawnObstacle", function(baseFunc, args)
  local newArgs = DeepCopyTable(args)
  if args.Name == "MoonSigilEntrance" then
    newArgs.OffsetX = 0
  end
  return baseFunc(newArgs)
end, ClosePortals)