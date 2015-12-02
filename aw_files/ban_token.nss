int StartingConditional()
{
    object oGM = GetPCSpeaker();
    object oTarget =  GetLocalObject(oGM,"MyTarget");

    SetCustomToken(92500, GetName(oTarget) + "["+GetPCPlayerName(oTarget)+"]");
    return TRUE;

}
