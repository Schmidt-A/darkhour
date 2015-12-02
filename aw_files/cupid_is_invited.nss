int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iResult;

    iResult = (GetLocalInt(oPC,"invitations")!= 0 && (GetLocalObject(oPC,"MyValentine") == OBJECT_INVALID));

    return iResult;
}


