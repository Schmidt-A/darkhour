int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    string sName = GetPCPlayerName(oPC);
    iResult = (sName == "Jantima" || sName == "Nilas_87" || sName == "ENIRO");
    return iResult;
}
