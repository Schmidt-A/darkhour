#include "_incl_subrace"
void main()
{
    object oTemp;
    oTemp = GetFirstItemInInventory();
    while (GetIsObjectValid(oTemp))
    {
        DestroyObject(oTemp);
        oTemp = GetNextItemInInventory();
    }
    SubraceLogin(OBJECT_SELF);
    oTemp = CreateItemOnObject("dmfi_pc_emote",OBJECT_SELF);
    oTemp = CreateItemOnObject("greatroleplay",OBJECT_SELF);
    oTemp = CreateItemOnObject("dmfi_pc_dicebag",OBJECT_SELF);
    oTemp = CreateItemOnObject("scavenger",OBJECT_SELF);
    oTemp = CreateItemOnObject("professionpc",OBJECT_SELF);
    oTemp = CreateItemOnObject("langselect", OBJECT_SELF);
    if ((GetHasFeat(FEAT_WEAPON_PROFICIENCY_DRUID)) || (GetHasFeat(FEAT_WEAPON_PROFICIENCY_MONK)) || (GetHasFeat(FEAT_WEAPON_PROFICIENCY_ROGUE)) || (GetHasFeat(FEAT_WEAPON_PROFICIENCY_SIMPLE)))
    {
        oTemp = CreateItemOnObject("zn_sling",OBJECT_SELF);
        oTemp = CreateItemOnObject("zn_stones",OBJECT_SELF,99);
        oTemp = CreateItemOnObject("chairleg",OBJECT_SELF);
    }
    else
    {
        oTemp = CreateItemOnObject("zn_crossbow",OBJECT_SELF);
        oTemp = CreateItemOnObject("zn_bolts",OBJECT_SELF,50);
        oTemp = CreateItemOnObject("chairleg",OBJECT_SELF);
    }
    oTemp = CreateItemOnObject("zn_medkit",OBJECT_SELF);
    oTemp = CreateItemOnObject("mil_dyekit002",OBJECT_SELF);
    oTemp = CreateItemOnObject("bread",OBJECT_SELF);
    oTemp = CreateItemOnObject("bread",OBJECT_SELF);
    if (GetLevelByClass(CLASS_TYPE_MONK,OBJECT_SELF) >= 1)
    {
        CreateItemOnObject("kishuriken",OBJECT_SELF,20);
    }
}
