int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetItemPossessedBy(oPC, "set_dex_cape") != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
