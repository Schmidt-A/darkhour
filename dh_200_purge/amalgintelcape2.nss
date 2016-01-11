int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetItemPossessedBy(oPC, "set_int_cape001") != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
