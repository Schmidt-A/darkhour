void Grow()
{
location lLoc = GetLocation(OBJECT_SELF);
int iChance = d4();
DestroyObject(OBJECT_SELF);
object oPlant = CreateObject(OBJECT_TYPE_PLACEABLE, "dhberrybush", lLoc);
if(iChance < 4)
    {
    CreateItemOnObject("seeds", oPlant);
    }
}
void main()
{
object oPC = GetLastUsedBy();
object oSeeds = GetItemPossessedBy(oPC, "Seeds");
int iUsed = GetLocalInt(OBJECT_SELF, "ready");
if(iUsed == 1)
    {
    SendMessageToPC(oPC, "This soil already has seeds growing within it.");
    return;
    }
if(oSeeds == OBJECT_INVALID)
    {
    SendMessageToPC(oPC, "This soil looks perfect for planting seeds, if only you had some.");
    return;
    }
else
    {
    SetLocalInt(OBJECT_SELF, "ready", 1);
    DestroyObject(oSeeds);
    SendMessageToPC(oPC, "You have planted the seeds in the soft fertile soil.");
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 5.0));
    DelayCommand(1200.0, Grow());
    }
}
