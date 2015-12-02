/******************************/
// OnFailToOpen(open for the team)
/******************************/

#include "inc_bs_module"
void main()
{
    object oClicker = GetClickingObject();
    int nTeam = GetPlayerTeam(oClicker);

    if( (nTeam == 1 && GetLockKeyTag(OBJECT_SELF) == "GoodKey") || ( nTeam == 2 && GetLockKeyTag(OBJECT_SELF) == "EvilKey"))
    {
        ClearAllActions();
        SetLocalInt(OBJECT_SELF,"InUse",1);
        ActionOpenDoor(OBJECT_SELF);
        ActionWait(6.0);
        ActionCloseDoor(OBJECT_SELF);
    }
    else if (GetTag(OBJECT_SELF) != "1_stone_door" && GetTag(OBJECT_SELF) != "2_stone_door")
    {
        FloatingTextStringOnCreature("Ha! You can't open this! You have to bash it open or unlock it first!",oClicker,FALSE);
    }
}
