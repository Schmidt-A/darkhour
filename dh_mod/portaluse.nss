void main()
{
    object oPC = GetLastUsedBy();
    object oItem;
oItem = GetItemPossessedBy(oPC, "ReaperToken");

if (GetIsObjectValid(oItem))
{
   DestroyObject(oItem);

oItem = GetItemPossessedBy(oPC, "DeathToken");

if (GetIsObjectValid(oItem))
{
   DestroyObject(oItem);
   }


   }
    location lLoc = GetLocation(GetWaypointByTag("ComingFromFugue"));
    AssignCommand(oPC,JumpToLocation(lLoc));
    object oTarget;
    oTarget = OBJECT_SELF;

    DestroyObject(oTarget, 0.0);
}
