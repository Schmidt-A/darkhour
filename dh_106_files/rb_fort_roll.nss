#include "rb_pc_func"
void main()
{
    // Set ability then execute script
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "iSaveType", SAVING_THROW_FORT);
    ExecuteScript("rb_save_roll", oPC);
}
