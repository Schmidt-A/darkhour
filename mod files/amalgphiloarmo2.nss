int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetItemPossessedBy(oPC, "set_wis_armor001") != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
