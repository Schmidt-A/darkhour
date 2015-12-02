int StartingConditional()
{   object oPC = GetPCSpeaker();

    if(GetRacialType(oPC)== RACIAL_TYPE_ELF && GetItemPossessedBy(oPC, "wellwisher") == OBJECT_INVALID)
    return TRUE;

    else return FALSE;

}
