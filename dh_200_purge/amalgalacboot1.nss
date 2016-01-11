int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetItemPossessedBy(oPC, "set_dex_boots") != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
