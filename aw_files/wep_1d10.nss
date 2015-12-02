#include "item_enhancement"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    return Is_1d10(GetLocalInt(oPC,"wep_type"))  || Is_1d12(GetLocalInt(oPC,"wep_type"));




}
