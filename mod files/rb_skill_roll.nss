#include "rb_pc_func"
void main()
{
    // make a strength roll
    object oPC = OBJECT_SELF;
    int bOpenRoll = GetLocalInt(oPC, "bOpenRoll");
    int iSkill = GetLocalInt(oPC, "iSkill");
    int iRoll = SkillRoll(iSkill, oPC);
    string sMessage = GetName(oPC) + " makes a " + GetSkillName(iSkill) + " roll of " + IntToString(iRoll);

    if (bOpenRoll)
        SpeakString(sMessage);

}
