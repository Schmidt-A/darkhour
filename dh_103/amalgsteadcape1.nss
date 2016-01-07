int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetItemPossessedBy(oPC, "set_con_cape") != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
