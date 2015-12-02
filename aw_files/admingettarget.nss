int StartingConditional()
{
    object oPC = GetPCSpeaker();


    SetCustomToken(8450, GetPCPlayerName(GetLocalObject(oPC, "oMyTarget")));
     return TRUE;
}
