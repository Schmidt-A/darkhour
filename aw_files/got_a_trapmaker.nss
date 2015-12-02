int StartingConditional()
{
if (GetItemPossessedBy(GetPCSpeaker(),"trapcreator") != OBJECT_INVALID)
    return TRUE;
    else return FALSE;
}
