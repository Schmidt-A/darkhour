#include "rb_pc_func"
void main()
{
    // make a strength roll
    object oPC = OBJECT_SELF;
    int bOpenRoll = GetLocalInt(oPC, "bOpenRoll");
    int iAbility = GetLocalInt(oPC, "iAbility");
    int iRoll = AbilityRoll(iAbility, oPC);
    string sMessage = GetName(oPC) + " makes a " + GetAbilityName(iAbility) + " roll of " + IntToString(iRoll);

    if (bOpenRoll)
        SpeakString(sMessage);

}
