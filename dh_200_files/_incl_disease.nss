// Just including this for now because I am not muddying this up with that
// nonsense.
#include "disease_inc"

int GetIsDiseased(object oPC)
{
    return GetItemPossessedBy(oPC, "ZombieDisease");
}

int DiseaseTokenCount(oPC)
{
    if(!GetIsDiseased(oPC))
        return;

    int iCount = 0;
    object oItem = GetFirstItemInInventory(oPC);

    while(oItem != OBJECT_INVALID)
    {
        if(GetTag(oItem) == "ZombieDisease")
            iCount++;
        oItem = GetNextItemInInventory(oPC);
    }

    return iCount;
}

void CureDisease(oPC, int iHowMany=10)
{
    if(!GetIsDiseased(oPC))
    {
        FloatingTextStringOnCreature("There was no disease to cure", oPC, FALSE);
        return;
    }

    int iCount = 0;
    object oItem = GetFirstItemInInventory(oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,
            EffectVisualEffect(VFX_IMP_REMOVE_CONDITION, oPC)); 
    RemoveDiseaseEffects(oPC);

    while(oItem != OBJECT_INVALID && iCount < iHowMany)
    {
        if(GetTag(oItem) == "ZombieDisease")
        {
            iCount++;
            DesstroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oPC);
    }
}
