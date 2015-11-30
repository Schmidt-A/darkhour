void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "iConvChoice", 3);
    string sScript = GetLocalString(oPC, "sConvScript");
    ExecuteScript(sScript, oPC);
}
