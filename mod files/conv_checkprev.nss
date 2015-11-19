int StartingConditional()
{   object oPC = GetPCSpeaker();
    int iPage = GetLocalInt(oPC, "iConvPage");

    return (iPage != 0);
}
