int StartingConditional()
{
    if (GetItemPossessedBy(GetPCSpeaker(),"DartMaker") != OBJECT_INVALID)
    {
        return TRUE;
        SetLocalInt(GetPCSpeaker(),"nFoundMaker", 1);
    }
    else return FALSE;
}
