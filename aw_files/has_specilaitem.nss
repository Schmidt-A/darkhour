int StartingConditional()
{   object oPC = GetPCSpeaker();


    if(GetItemPossessedBy(oPC, "specialitem")== OBJECT_INVALID && GetItemPossessedBy(oPC, "specialitemf")== OBJECT_INVALID) return FALSE;
    return TRUE;

}
