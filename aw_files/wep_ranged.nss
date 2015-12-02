#include "x2_inc_itemprop"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int base_type = GetLocalInt(oPC,"wep_type");

    switch (base_type)
    {
        case BASE_ITEM_SHORTBOW: return TRUE;
        case BASE_ITEM_LONGBOW: return TRUE;
        case BASE_ITEM_HEAVYCROSSBOW: return TRUE;
        case BASE_ITEM_LIGHTCROSSBOW: return TRUE;
        case BASE_ITEM_SLING: return TRUE;
        default: return FALSE;
    }
        return FALSE;
}
