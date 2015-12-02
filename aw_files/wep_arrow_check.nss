int StartingConditional()
{
    if (GetItemPossessedBy(GetPCSpeaker(),"ArrowMaker") != OBJECT_INVALID)
    {
        return TRUE;
        SetLocalInt(GetPCSpeaker(),"nFoundMaker", 1);
    }
    else return FALSE;
}
