#include "rb_pc_func"
void main()
{
    // Set ability then execute script
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "iAbility", ABILITY_CHARISMA);
    ExecuteScript("rb_ability_roll", oPC);
}
