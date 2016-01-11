void DoVariableConvoScript(object oPC, string sConvScript, int iStoredPos, int iPos)
{
    SetLocalInt(oPC, "iConvPos", (10 * iStoredPos) + iPos);
    ExecuteScript(sConvScript, oPC);
    DeleteLocalInt(oPC, "iConvPos");
    DeleteLocalInt(oPC, "iConvScript");
}
