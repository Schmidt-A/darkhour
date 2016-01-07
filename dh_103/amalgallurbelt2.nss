int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetItemPossessedBy(oPC, "set_cha_belt001") != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
