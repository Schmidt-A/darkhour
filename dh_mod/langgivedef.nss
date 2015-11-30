void main()
{
object oPC = GetPCSpeaker();
SetLocalInt(oPC, "deflangs", 1);
if((GetRacialType(oPC) == RACIAL_TYPE_ELF) && GetItemPossessedBy(oPC, "hlslang_1") == OBJECT_INVALID)
    {
    CreateItemOnObject("hlslang_1", oPC);
    }
if((GetRacialType(oPC) == RACIAL_TYPE_GNOME) && GetItemPossessedBy(oPC, "hlslang_2") == OBJECT_INVALID)
    {
    CreateItemOnObject("hlslang_2", oPC);
    }
if((GetRacialType(oPC) == RACIAL_TYPE_HALFELF) && GetItemPossessedBy(oPC, "hlslang_1") == OBJECT_INVALID)
    {
    CreateItemOnObject("hlslang_1", oPC);
    }
if((GetRacialType(oPC) == RACIAL_TYPE_HALFLING) && GetItemPossessedBy(oPC, "hlslang_3") == OBJECT_INVALID)
    {
    CreateItemOnObject("hlslang_3", oPC);
    }
if((GetRacialType(oPC) == RACIAL_TYPE_HALFORC) && GetItemPossessedBy(oPC, "hlslang_5") == OBJECT_INVALID)
    {
    CreateItemOnObject("hlslang_5", oPC);
    }
if((GetRacialType(oPC) == RACIAL_TYPE_DWARF) && GetItemPossessedBy(oPC, "hlslang_4") == OBJECT_INVALID)
    {
    CreateItemOnObject("hlslang_4", oPC);
    }
if((GetLevelByClass(CLASS_TYPE_ROGUE, oPC) > 0) && GetItemPossessedBy(oPC, "hlslang_9") == OBJECT_INVALID)
    {
    CreateItemOnObject("hlslang_9", oPC);
    }
if((GetLevelByClass(CLASS_TYPE_RANGER, oPC) > 0) && GetItemPossessedBy(oPC, "hlslang_8") == OBJECT_INVALID)
    {
    CreateItemOnObject("hlslang_8", oPC);
    if(GetAbilityModifier(ABILITY_INTELLIGENCE, oPC) > 0)
        {
        if((GetHasFeat(FEAT_FAVORED_ENEMY_DRAGON, oPC) == TRUE) && GetItemPossessedBy(oPC, "hlslang_7") == OBJECT_INVALID)
            {
            CreateItemOnObject("hlslang_7", oPC);
            }
        if((GetHasFeat(FEAT_FAVORED_ENEMY_DWARF, oPC) == TRUE) && GetItemPossessedBy(oPC, "hlslang_4") == OBJECT_INVALID)
            {
            CreateItemOnObject("hlslang_4", oPC);
            }
        if((GetHasFeat(FEAT_FAVORED_ENEMY_ELF, oPC) == TRUE) && GetItemPossessedBy(oPC, "hlslang_1") == OBJECT_INVALID)
            {
            CreateItemOnObject("hlslang_1", oPC);
            }
        if((GetHasFeat(FEAT_FAVORED_ENEMY_GNOME, oPC) == TRUE) && GetItemPossessedBy(oPC, "hlslang_2") == OBJECT_INVALID)
            {
            CreateItemOnObject("hlslang_2", oPC);
            }
        if((GetHasFeat(FEAT_FAVORED_ENEMY_GOBLINOID, oPC) == TRUE) && GetItemPossessedBy(oPC, "hlslang_6") == OBJECT_INVALID)
            {
            CreateItemOnObject("hlslang_6", oPC);
            }
        if((GetHasFeat(FEAT_FAVORED_ENEMY_HALFELF, oPC) == TRUE) && GetItemPossessedBy(oPC, "hlslang_1") == OBJECT_INVALID)
            {
            CreateItemOnObject("hlslang_1", oPC);
            }
        if((GetHasFeat(FEAT_FAVORED_ENEMY_HALFLING, oPC) == TRUE) && GetItemPossessedBy(oPC, "hlslang_3") == OBJECT_INVALID)
            {
            CreateItemOnObject("hlslang_3", oPC);
            }
        if((GetHasFeat(FEAT_FAVORED_ENEMY_HALFORC, oPC) == TRUE) && GetItemPossessedBy(oPC, "hlslang_5") == OBJECT_INVALID)
            {
            CreateItemOnObject("hlslang_5", oPC);
            }
        if((GetHasFeat(FEAT_FAVORED_ENEMY_ORC, oPC) == TRUE) && GetItemPossessedBy(oPC, "hlslang_5") == OBJECT_INVALID)
            {
            CreateItemOnObject("hlslang_5", oPC);
            }
        }
    }
if((GetLevelByClass(CLASS_TYPE_DRUID, oPC) > 0) && GetItemPossessedBy(oPC, "hlslang_8") == OBJECT_INVALID)
    {
    CreateItemOnObject("hlslang_8", oPC);
    }
if((GetLevelByClass(CLASS_TYPE_SORCERER, oPC) > 0) && GetItemPossessedBy(oPC, "hlslang_7") == OBJECT_INVALID)
    {
    CreateItemOnObject("hlslang_7", oPC);
    }
if(((GetLevelByClass(CLASS_TYPE_PALADIN, oPC) > 0) && GetItemPossessedBy(oPC, "hlslang_10") == OBJECT_INVALID)&& GetAbilityModifier(ABILITY_INTELLIGENCE, oPC) > 0)
    {
    CreateItemOnObject("hlslang_10", oPC);
    }
SendMessageToPC(oPC, "You have been given all languages entitled to you by default.");
}
