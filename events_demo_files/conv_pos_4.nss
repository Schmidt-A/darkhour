#include "_incl_conv"
void main()
{
    object oPC = GetPCSpeaker();
    string sConvScript = GetLocalString(oPC, "sConvScript");
    int iStoredPos = GetLocalInt(oPC, "iConvPos");
    int iPos = 4;

    // If we hit here it means we had stored a choice from the else case.
    if (iStoredPos)
        DoVariableConvoScript(oPC, sConvScript, iStoredPos, iPos);
    else
    {
        // if special cases with only one level...
        // else
            SetLocalInt(oPC, "iConvPos", iPos);
        return;
    }
}
