void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "iConvChoice", 1);
    string sScript = GetLocalString(oPC, "sConvScript");
    ExecuteScript(sScript, oPC);
}
