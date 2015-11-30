void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "iConvChoice", 2);
    string sScript = GetLocalString(oPC, "sConvScript");
    ExecuteScript(sScript, oPC);
}
