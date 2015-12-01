#include "rb_pc_func"
void main()
{
    // make a strength roll
    object oPC = OBJECT_SELF;
    int bOpenRoll = GetLocalInt(oPC, "bOpenRoll");
    int iSaveType = GetLocalInt(oPC, "iSaveType");
    int iRoll = SavingRoll(iSaveType, oPC);
    string sMessage = GetName(oPC) + " makes a " + GetSavingThrowName(iSaveType) + " roll of " + IntToString(iRoll);

    if (bOpenRoll)
        SpeakString(sMessage);

}
