int StartingConditional()
{   object oPC = GetPCSpeaker();


    if(GetItemPossessedBy(oPC, "PlatinumAngel")== OBJECT_INVALID)
    return TRUE;

    else return FALSE;

}
