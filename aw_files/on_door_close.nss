/******************************/
// Door OnClose (if was locked is still locked)
/******************************/
#include "aw_include"
void main()
{
object oClicker = GetClickingObject();

      if (GetLocked(OBJECT_SELF))
      {
          if (GetTag(OBJECT_SELF) != "1_stone_door" && GetTag(OBJECT_SELF) != "2_stone_door")
          {
                FloatingTextStringOnCreature("The Door is still locked, DC is: "+IntToString(GetLockUnlockDC(OBJECT_SELF))+" was set by: "+GetName(GetLastLocked()),oClicker);
          }
      }
      ClearAllActions();
      SetLocalInt(OBJECT_SELF,"InUse",0);

}
