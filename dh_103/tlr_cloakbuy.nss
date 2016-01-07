//Created by 420 for the CEP
//Check for cloak and local int
//Based on script tlr_clothbuy.nss by Stacy L. Ropella
int StartingConditional()
{
    if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CLOAK, OBJECT_SELF))
        && GetLocalInt(OBJECT_SELF, "Cloak_Buy") == 1)
    return TRUE;
 return FALSE;
}
