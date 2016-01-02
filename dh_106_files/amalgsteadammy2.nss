int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetItemPossessedBy(oPC, "set_con_ammy001") != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
