void main()
{   object oPC = GetPCSpeaker();
    int iPage = GetLocalInt(oPC, "iConvPage");
    iPage++;
    SetLocalInt(oPC, "iConvPage", iPage);
}
