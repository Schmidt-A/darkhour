int StartingConditional()
{
    string sPCName = GetName(GetLocalObject(GetPCSpeaker(),"BanWandTarget"));
    SetCustomToken(666,sPCName);
    return TRUE;
}
