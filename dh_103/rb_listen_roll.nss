#include "rb_pc_func"
void main()
{
    // Set ability then execute script
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "iSkill", SKILL_LISTEN);
    ExecuteScript("rb_skill_roll", oPC);
}
