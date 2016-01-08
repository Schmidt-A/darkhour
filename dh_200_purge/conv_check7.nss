int StartingConditional()
{   object oPC = GetPCSpeaker();
    int iPageLen = 10;
    int iPage = GetLocalInt(oPC, "iConvPage");
    int iTotalItems = GetLocalInt(oPC, "iConvTotal");

    int iPageTotal = iTotalItems - (iPage * iPageLen);

    return (iPageTotal >= 7);
}
