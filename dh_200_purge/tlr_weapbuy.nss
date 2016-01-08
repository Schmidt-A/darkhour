//::///////////////////////////////////////////////
//:: Tailoring - Check for Valid Weapon on NPC
//:: Also check to see if weapon buying is allowed
//:: tlr_weapbuy.nss
//:://////////////////////////////////////////////
/*
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: from Mandragon's mil_tailor
//:://////////////////////////////////////////////
*/
int StartingConditional()
{
    object oModel = OBJECT_SELF;

    if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oModel))
    && GetLocalInt(OBJECT_SELF, "Weapon_Buy") == 1)
    return TRUE;

 return FALSE;
}
