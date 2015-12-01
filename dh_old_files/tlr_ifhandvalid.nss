//::///////////////////////////////////////////////
//:: Tailoring - If Either Hand Item is Valid
//:: tlr_ifhandvalid.nss
//:: Copyright (c) 2006 Stacy L. Ropella
//:://////////////////////////////////////////////
/*
    Checks to make sure there is a valid item
    equipped in at least one of the PC's hand slots
*/
//:://////////////////////////////////////////////
//:: Created By: Stacy L. Ropella
//:: Created On: January 29, 2006
//:://////////////////////////////////////////////
int StartingConditional()
{
    if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, GetPCSpeaker())))
        return TRUE;
    else if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, GetPCSpeaker())))
        return TRUE;
    else
        return FALSE;
}
