int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetItemPossessedBy(oPC, "set_con_ring001") != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
