void main()
{
  ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
  object oStoneDoor;
  if (GetTag(OBJECT_SELF) == "arena_22_1_drawbridge_lever")
  {
      oStoneDoor = GetObjectByTag("drawbridge_1");
  }
  else if (GetTag(OBJECT_SELF) == "arena_22_2_drawbridge_lever")
  {
     oStoneDoor = GetObjectByTag("drawbridge_2");
  }

  ActionOpenDoor(oStoneDoor);
  //DelayCommand(16.0, ActionCloseDoor(oStoneDoor));
  //SetLocked(oStoneDoor,1);
  ActionWait(2.0);
  ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
}
