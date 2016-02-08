/* Execute the handler script for a given conversation.
 * Takes the PC object, the handler script to execute, and the conversational
 * positions from the calling conv_pos script. */
void DoVariableConvoScript(object oPC, string sConvScript, int iStoredPos, int iPos);

void DoVariableConvoScript(object oPC, string sConvScript, int iStoredPos, int iPos)
{
    SetLocalInt(oPC, "iConvPos", (10 * iStoredPos) + iPos);
    ExecuteScript(sConvScript, oPC);
    DeleteLocalInt(oPC, "iConvPos");
    DeleteLocalString(oPC, "sConvScript");
}
