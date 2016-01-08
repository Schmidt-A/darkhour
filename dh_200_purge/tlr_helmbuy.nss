//::///////////////////////////////////////////////
//:: Tailoring - Check for Valid Helmet on NPC
//:: Also check to see if helm buying is allowed
//:: tlr_helmbuy.nss
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

    if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_HEAD, oModel))
    && GetLocalInt(OBJECT_SELF, "Helm_Buy") == 1)
    return TRUE;

 return FALSE;
}
