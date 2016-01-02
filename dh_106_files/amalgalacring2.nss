int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetItemPossessedBy(oPC, "set_dex_ring001") != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
