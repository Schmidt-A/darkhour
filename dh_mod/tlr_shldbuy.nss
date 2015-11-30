//::///////////////////////////////////////////////
//:: Tailoring - Check for Valid Shield on NPC
//:: Also check to see if shield buying is allowed
//:: tlr_shldbuy.nss
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

    if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oModel))
    && GetLocalInt(OBJECT_SELF, "Shield_Buy") == 1)
    return TRUE;

 return FALSE;
}
