#include "item_enhancement"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if (Is_1d8(GetLocalInt(oPC,"wep_type")) || Is_1d10(GetLocalInt(oPC,"wep_type"))  || Is_1d12(GetLocalInt(oPC,"wep_type")))
    {
        return TRUE;
    }
    else return FALSE;


}
