void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "iConvChoice", 4);
    string sScript = GetLocalString(oPC, "sConvScript");
    ExecuteScript(sScript, oPC);
}
