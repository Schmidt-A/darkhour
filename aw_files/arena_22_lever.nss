void main()
{

  object oStoneDoor;
  if (GetTag(OBJECT_SELF) == "arena_22_1_lever")
      {
          oStoneDoor = GetObjectByTag("1_stone_door");
      }
      else if (GetTag(OBJECT_SELF) == "arena_22_2_lever")
      {
         oStoneDoor = GetObjectByTag("2_stone_door");
      }


    if (GetLocalInt(oStoneDoor,"InUse") == 1)
    {
        return;
    }
  else
    {
    ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    SetLocalInt(oStoneDoor,"InUse",1);
      ActionOpenDoor(oStoneDoor);
      DelayCommand(10.0, ActionCloseDoor(oStoneDoor));
      SetLocked(oStoneDoor,1);

      DelayCommand(6.0,ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
   }
}
