int StartingConditional()
{
object oPC = GetPCSpeaker();
if(GetItemPossessedBy(oPC, "set_str_helm001") != OBJECT_INVALID)
    {
    return TRUE;
    }
return FALSE;
}
