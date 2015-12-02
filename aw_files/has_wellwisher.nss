int StartingConditional()
{   object oPC = GetPCSpeaker();


    if(GetItemPossessedBy(oPC, "wellwisher")== OBJECT_INVALID)
    return TRUE;

    else return FALSE;

}
