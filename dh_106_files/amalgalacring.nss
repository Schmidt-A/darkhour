int StartingConditional()
{
object oPC = GetPCSpeaker();
object oItem = GetFirstItemInInventory(oPC);
while(GetIsObjectValid(oItem))
    {
    if((GetStringLeft(GetTag(oItem), 12) == "set_dex_ring") && GetStringRight(GetTag(oItem), 3) != "002")
        {
        return TRUE;
        }
    oItem = GetNextItemInInventory(oPC);
    }
return FALSE;
}
