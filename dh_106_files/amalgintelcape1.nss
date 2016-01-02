int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetItemPossessedBy(oPC, "set_int_cape") != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
