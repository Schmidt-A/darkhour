#include "_cls_bard"
#include "_incl_pc_data"

void main()
{
    object oPC = GetPCLevellingUp();
    int iBardLevels = GetLevelByClass(CLASS_TYPE_BARD, oPC);

    if(PCDBardLevelChanged(oPC, iBardLevels))
        BardLevel(oPC, iBardLevels);
}