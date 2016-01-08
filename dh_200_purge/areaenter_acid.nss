#include "acidfood"
void main()
{
    object oPC2 = GetEnteringObject();
    effect eSafe = EffectSanctuary(99);
    effect eProtect = EffectDamageResistance(DAMAGE_TYPE_SLASHING,10);
    if (GetIsDM(oPC2) == FALSE)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSafe,oPC2,5.5);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eProtect,oPC2,5.5);
    }

    if (GetLocalInt(oPC2,"finishcreate") == 1)
    {
        SetDroppableFlag(GetFirstItemInInventory(oPC2),FALSE);
        DestroyObject(oPC2);
    }
}
