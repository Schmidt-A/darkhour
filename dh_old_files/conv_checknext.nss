int StartingConditional()
{   object oPC = GetPCSpeaker();
    int iPageLen = 10;
    int iPage = GetLocalInt(oPC, "iConvPage");
    int iTotalItems = GetLocalInt(oPC, "iConvTotal");


    return (iTotalItems > ((iPage * iPageLen) + iPageLen));
}
