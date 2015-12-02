int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    iResult = (GetLocalObject(oPC,"MyValentine") != OBJECT_INVALID);
    SetCustomToken(5050,GetName(GetLocalObject(oPC,"MyValentine")));
    return iResult;
}
