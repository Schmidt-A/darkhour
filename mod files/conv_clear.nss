void main()
{
    object oPC = GetPCSpeaker();

    DeleteLocalInt(oPC, "iConvPage");
    DeleteLocalInt(oPC, "iConvChoice");
    DeleteLocalString(oPC, "sConvScript");
    DeleteLocalInt(oPC, "iConvTotal");
}
