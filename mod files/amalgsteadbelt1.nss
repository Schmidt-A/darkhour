int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetItemPossessedBy(oPC, "set_con_belt") != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
