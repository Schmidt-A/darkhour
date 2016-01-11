int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetItemPossessedBy(oPC, "set_dex_ring") != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
