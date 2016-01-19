// This script will apply safety effects to players when they enter the area.
// Also, the area will be explored for the player if they have an item tagged
// "moa1".

// Description by Zunath on July 22, 2007
// coolty3001@yahoo.com

void main()
{
    object oPC = GetEnteringObject();
    effect eSafe = EffectSanctuary(99);
    effect eProtect = EffectDamageResistance(DAMAGE_TYPE_SLASHING,10);
    if (GetIsDM(oPC) == FALSE && GetIsPC(oPC))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSafe,oPC,5.5);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eProtect,oPC,5.5);
    }
    if (GetItemPossessedBy(oPC, "moa1")!= OBJECT_INVALID)
    {
        ExploreAreaForPlayer(GetArea(oPC), oPC);
    }

    int iPCCount = GetLocalInt(OBJECT_SELF, "iPCCount");                        
    SetLocalInt(OBJECT_SELF, "iPCCount", iPCCount+1); 

    if (GetLocalInt(oPC,"finishcreate") == 1)
    {
        SetDroppableFlag(GetFirstItemInInventory(oPC),FALSE);
        DestroyObject(oPC);
    }

    if (GetTag(OBJECT_SELF) == "carnival")
    {ExecuteScript("window_areaenter", OBJECT_SELF);}
}
