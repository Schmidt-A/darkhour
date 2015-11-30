//::///////////////////////////////////////////////
//:: Tailoring - If RightHand Item is Valid
//:: tlr_ifrightvalid.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Checks to make sure there is a valid item
    equipped in the PC's right hand slot
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: January 29, 2006
//:://////////////////////////////////////////////
int StartingConditional()
{
    if(GetLocalInt(OBJECT_SELF, "Weapon_Buy") == 0
       && GetLocalInt(OBJECT_SELF, "Weapon_Copy") == 0)
       return FALSE;

    if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, GetPCSpeaker())))
        return TRUE;
    else
        return FALSE;
}
