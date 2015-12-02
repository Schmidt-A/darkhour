int StartingConditional()
{   object oDM = GetPCSpeaker();
string sName = GetPCPlayerName(oDM);
    int iResult;

    iResult = sName == "ENIRO" || sName == "Jantima" || sName == "Nilas_87" || sName == "Betle" || sName == "UnrealFenix";
    return iResult;
}
