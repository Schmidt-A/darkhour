#include "_incl_pcinteract"

void main()
{
    object oPC = GetLastUsedBy();
    UniversalDoor(oPC, OBJECT_SELF);
}
