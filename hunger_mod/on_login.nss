#include "_incl_session"

void main()
{
    object oPC      = GetEnteringObject();
    object oPCToken = GetItemPossessedBy(oPC, "token_pc");

    // First login evaar
    if(oPCToken == OBJECT_INVALID)
    {
        oPCToken = CreateItemOnObject("token_pc", oPC);

        SetLocalFloat(oPCToken, "fSatisfaction", 100.0);
        SetLocalString(oPCToken, "sHungerLevel", "Stuffed");
        SetLocalFloat(oPCToken, "fLossRate", 3.3);
        SetLocalInt(oPCToken, "iSurvivalTime", 0);

        SetLocalString(oPC, "sConvScript", "conv_palate");
        SetLocalInt(oPCToken, "iPalate", 99); // Default because 0 = General
        AssignCommand(oPC, ActionStartConversation(oPC, "palate_choose"));
    }
    //DBLogin(oPC);
}
