int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetItemPossessedBy(oPC, "set_con_boots") != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
