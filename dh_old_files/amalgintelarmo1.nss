int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetItemPossessedBy(oPC, "set_int_armor") != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
