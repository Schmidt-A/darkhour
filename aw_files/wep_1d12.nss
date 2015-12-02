#include "item_enhancement"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    return Is_1d12(GetLocalInt(oPC,"wep_type"));




}
