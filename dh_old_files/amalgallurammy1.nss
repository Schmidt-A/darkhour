int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetItemPossessedBy(oPC, "set_cha_ammy") != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
