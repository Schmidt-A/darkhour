//Created by 420 for the CEP
//Check for valid cloak and local variable
//Based on script tlr_clothcheck.nss by Stacy L. Ropella
int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC))
    &&GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CLOAK, OBJECT_SELF))
        && GetLocalInt(OBJECT_SELF, "Cloak_Copy") == 1)
    return TRUE;

 return FALSE;
}
