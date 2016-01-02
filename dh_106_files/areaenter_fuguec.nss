// This script will apply safety effects to players when they enter the area.
// Also, the area will be explored for the player if they have an item tagged
// "moa1".

// Description by Zunath on July 22, 2007
// coolty3001@yahoo.com

void main()
{    {

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
    effect eDeath = EffectDarkness();
    effect eSafe = EffectVisualEffect(VFX_DUR_ETHEREAL_VISAGE);
    effect eProtect = EffectDamageResistance(DAMAGE_TYPE_SLASHING,10);
    if (GetIsDM(oPC) == FALSE && GetIsPC(oPC))
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDeath,oPC, 5.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSafe,oPC,5000000.5);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eProtect,oPC,5.5);
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
    {ExecuteScript("window_areaenter", OBJECT_SELF);}}
}

