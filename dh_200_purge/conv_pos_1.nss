/* This is a reimplementation of the DMFI conversational positioning scripts.
 * I've rewritten it because the original implementation was unclear and not
 * repurposable. As is, this allows for option tracking in a conversation with
 * either 1 or two levels of choice. The 'else' case happens when we're at the
 * first level of a conversation while the 'if' happens if we're at the second
 * level and will execute a context script stored on the PC.
 * The expectation for these to work is that the 'sConvScript' variable gets
 * set on a PC prior to ActionStartConversation being called. It will tell us
 * what script handles the conversation results.
 * Tweek 2016 */

#include "_incl_conv"

void main()
{
    object oPC = GetPCSpeaker();
    string sConvScript = GetLocalString(oPC, "sConvScript");
    int iStoredPos = GetLocalInt(oPC, "iConvPos");
    int iPos = 1;

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
