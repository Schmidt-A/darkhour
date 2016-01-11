int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetItemPossessedBy(oPC, "set_int_belt") != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
