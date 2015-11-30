void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "iConvChoice", 5);
    string sScript = GetLocalString(oPC, "sConvScript");
    ExecuteScript(sScript, oPC);
}
