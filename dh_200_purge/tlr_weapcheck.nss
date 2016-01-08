//::///////////////////////////////////////////////
//:: Tailoring - If RightHand Item is Valid
//:: Also check to see if weapon copying is allowed
//:: tlr_weapcheck.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Checks to make sure there is a valid item
    equipped in the PC's right hand slot & in the
    model's right hand slot
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: January 29, 2006
//:://////////////////////////////////////////////
int StartingConditional()
{
    if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, GetPCSpeaker()))
        && GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF))
        && GetLocalInt(OBJECT_SELF, "Weapon_Copy") == 1)
        return TRUE;
    else
        return FALSE;
}
