// This script will apply safety effects to players when they enter the area.
// Also, the area will be explored for the player if they have an item tagged
// "moa1".

// Description by Zunath on July 22, 2007
// coolty3001@yahoo.com
// Edited by ChronusH on 08/27/08 for lumberjack profession flags
void main()
{
    object oPC = GetEnteringObject();
    effect eSafe = EffectSanctuary(99);
    effect eProtect = EffectDamageResistance(DAMAGE_TYPE_SLASHING,10);
    if (GetIsDM(oPC) == FALSE && GetIsPC(oPC))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSafe,oPC,5.5);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eProtect,oPC,5.5);
        ExploreAreaForPlayer(OBJECT_SELF, oPC, TRUE);
        if(GetLocalInt(OBJECT_SELF, "choppable") == 1)
            {
            if(GetItemPossessedBy(oPC, "ljtool") != OBJECT_INVALID)
                {
                SendMessageToPC(oPC, "This area has trees suitable for chopping.");
                }
            }
    }
    if (GetItemPossessedBy(oPC, "moa1")!= OBJECT_INVALID)
    {
        ExploreAreaForPlayer(GetArea(oPC), oPC);
    }

    if (GetLocalInt(oPC,"finishcreate") == 1)
    {
        SetDroppableFlag(GetFirstItemInInventory(oPC),FALSE);
        DestroyObject(oPC);
    }

    if (GetTag(OBJECT_SELF) == "carnival")
    {ExecuteScript("window_areaenter", OBJECT_SELF);}
}
