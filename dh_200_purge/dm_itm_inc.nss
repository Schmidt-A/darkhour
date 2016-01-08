//::///////////////////////////////////////////////
//::
//:: DM_Itm_Inc
//::
//:: dm_itm_inc.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is an include file used in the
//:: item manipulation system. See the function(s)
//:: for more info.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Nordavind
//::         On: June 4, 2004
//::
//:://////////////////////////////////////////////


//:://////////////////////////////////////////////
//::
//:: FUNCTION: string GetPropertyName(int nPropertyType)
//::
//:: This function gets the name of the item
//:: property type nPropertyType and returns it in
//:: a string.
//::
//:: Created By: Nordavind
//::         On: June 4, 2004
//::
//:://////////////////////////////////////////////
string GetPropertyName(int nPropertyType);
string GetPropertyName(int nPropertyType)
{
    string sPropName = "error";
    switch(nPropertyType)
    {
        case 0: //  ITEM_PROPERTY_ABILITY_BONUS                            = 0 ;
            sPropName = "[Ability Bonus] ";
            break;
        case 1: //  ITEM_PROPERTY_AC_BONUS                                 = 1 ;
            sPropName = "[AC Bonus] ";
            break;
        case 2: //  ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP              = 2 ;
            sPropName = "[AC Bonus vs Alignment Group] ";
            break;
        case 3: //  ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE                  = 3 ;
            sPropName = "[AC Bonus vs Damage Type] ";
            break;
        case 4: //  ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP                 = 4 ;
            sPropName = "[AC Bonus vs Racial Group] ";
            break;
        case 5: //  ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT           = 5 ;
            sPropName = "[AC Bonus vs Specific Alignment] ";
            break;
        case 6: //  ITEM_PROPERTY_ENHANCEMENT_BONUS                        = 6 ;
            sPropName = "[Enchantment Bonus] ";
            break;
        case 7: //  ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP     = 7 ;
            sPropName = "[Enchantment Bonus vs Alignment Group] ";
            break;
        case 8: //  ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP        = 8 ;
            sPropName = "[Enchantment Bonus vs Racial Group] ";
            break;
        case 9: //  ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT = 9 ;
            sPropName = "[Enchantment Bonus vs Specific Alignment] ";
            break;
        case 10: //  ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER           = 10 ;
            sPropName = "[Decreased Enchantment Modifier] ";
            break;
        case 11: //  ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION               = 11 ;
            sPropName = "[Base Item Weight Reduction] ";
            break;
        case 12: //  ITEM_PROPERTY_BONUS_FEAT                               = 12 ;
            sPropName = "[Bonus Feat] ";
            break;
        case 13: //  ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N              = 13 ;
            sPropName = "[Bonus Spell Slot] ";
            break;
        case 15: //  ITEM_PROPERTY_CAST_SPELL                               = 15 ;
            sPropName = "[Cast Spell] ";
            break;
        case 16: //  ITEM_PROPERTY_DAMAGE_BONUS                             = 16 ;
            sPropName = "[Damage Bonus] ";
            break;
        case 17: //  ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP          = 17 ;
            sPropName = "[Damage Bonus vs Alignment Group] ";
            break;
        case 18: //  ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP             = 18 ;
            sPropName = "[Damage Bonus vs Racial Group] ";
            break;
        case 19: //  ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT       = 19 ;
            sPropName = "[Damage Bonus vs Specific Alignment] ";
            break;
        case 20: //  ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE                     = 20 ;
            sPropName = "[Immunity Damage Type] ";
            break;
        case 21: //  ITEM_PROPERTY_DECREASED_DAMAGE                         = 21 ;
            sPropName = "[Decreased Damage] ";
            break;
        case 22: //  ITEM_PROPERTY_DAMAGE_REDUCTION                         = 22 ;
            sPropName = "[Damage Reduction] ";
            break;
        case 23: //  ITEM_PROPERTY_DAMAGE_RESISTANCE                        = 23 ;
            sPropName = "[Damage Resistance] ";
            break;
        case 24: //  ITEM_PROPERTY_DAMAGE_VULNERABILITY                     = 24 ;
            sPropName = "[Damage Vulnerability] ";
            break;
        case 26: //  ITEM_PROPERTY_DARKVISION                               = 26 ;
            sPropName = "[Darkvision] ";
            break;
        case 27: //  ITEM_PROPERTY_DECREASED_ABILITY_SCORE                  = 27 ;
            sPropName = "[Decreased Ability Score] ";
            break;
        case 28: //  ITEM_PROPERTY_DECREASED_AC                             = 28 ;
            sPropName = "[Decreased AC] ";
            break;
        case 29: //  ITEM_PROPERTY_DECREASED_SKILL_MODIFIER                 = 29 ;
            sPropName = "[Decreased Skill Modifier] ";
            break;
        case 32: //  ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT        = 32 ;
            sPropName = "[Enchanced Container Reduced Weight] ";
            break;
        case 33: //  ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE                  = 33 ;
            sPropName = "[Extra Melee Damage Type] ";
            break;
        case 34: //  ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE                 = 34 ;
            sPropName = "[Extra Ranged Damage Type] ";
            break;
        case 35: //  ITEM_PROPERTY_HASTE                                    = 35 ;
            sPropName = "[Haste] ";
            break;
        case 36: //  ITEM_PROPERTY_HOLY_AVENGER                             = 36 ;
            sPropName = "[Holy Avenger] ";
            break;
        case 37: //  ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS                   = 37 ;
            sPropName = "[Immunity Miscellaneous] ";
            break;
        case 38: //  ITEM_PROPERTY_IMPROVED_EVASION                         = 38 ;
            sPropName = "[Improved Evasion] ";
            break;
        case 39: //  ITEM_PROPERTY_SPELL_RESISTANCE                         = 39 ;
            sPropName = "[Spell Resistance] ";
            break;
        case 40: //  ITEM_PROPERTY_SAVING_THROW_BONUS                       = 40 ;
            sPropName = "[Saving Throw Bonus] ";
            break;
        case 41: //  ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC              = 41 ;
            sPropName = "[Saving Throw Bonus: Specific] ";
            break;
        case 43: //  ITEM_PROPERTY_KEEN                                     = 43 ;
            sPropName = "[Keen] ";
            break;
        case 44: //  ITEM_PROPERTY_LIGHT                                    = 44 ;
            sPropName = "[Light] ";
            break;
        case 45: //  ITEM_PROPERTY_MIGHTY                                   = 45 ;
            sPropName = "[Mighty] ";
            break;
        case 46: //  ITEM_PROPERTY_MIND_BLANK                               = 46 ;
            sPropName = "[Mind Blank] ";
            break;
        case 47: //  ITEM_PROPERTY_NO_DAMAGE                                = 47 ;
            sPropName = "[No Damage] ";
            break;
        case 48: //  ITEM_PROPERTY_ON_HIT_PROPERTIES                        = 48 ;
            sPropName = "[On Hit Properties] ";
            break;
        case 49: //  ITEM_PROPERTY_DECREASED_SAVING_THROWS                  = 49 ;
            sPropName = "[Decreased Saving Throws] ";
            break;
        case 50: //  ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC         = 50 ;
            sPropName = "[Decreased Saving Throws: Specific] ";
            break;
        case 51: //  ITEM_PROPERTY_REGENERATION                             = 51 ;
            sPropName = "[Regeneration] ";
            break;
        case 52: //  ITEM_PROPERTY_SKILL_BONUS                              = 52 ;
            sPropName = "[Skill Bonus] ";
            break;
        case 53: //  ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL                  = 53 ;
            sPropName = "[Immunity: Specific Spell] ";
            break;
        case 54: //  ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL                    = 54 ;
            sPropName = "[Immunity: Spell School] ";
            break;
        case 55: //  ITEM_PROPERTY_THIEVES_TOOLS                            = 55 ;
            sPropName = "[Thieves Tools] ";
            break;
        case 56: //  ITEM_PROPERTY_ATTACK_BONUS                             = 56 ;
            sPropName = "[Attack Bonus] ";
            break;
        case 57: //  ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP          = 57 ;
            sPropName = "[Attack Bonus vs Alignment Group] ";
            break;
        case 58: //  ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP             = 58 ;
            sPropName = "[Attack Bonus vs Racial Group] ";
            break;
        case 59: //  ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT       = 59 ;
            sPropName = "[Attack Bonus vs Specific Alignment] ";
            break;
        case 60: //  ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER                = 60 ;
            sPropName = "[Decreased Attack Modifier] ";
            break;
        case 61: //  ITEM_PROPERTY_UNLIMITED_AMMUNITION                     = 61 ;
            sPropName = "[Unlimited Ammunition] ";
            break;
        case 62: //  ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP           = 62 ;
            sPropName = "[Use Limitation: Alignment Group] ";
            break;
        case 63: //  ITEM_PROPERTY_USE_LIMITATION_CLASS                     = 63 ;
            sPropName = "[Use Limitation: Class] ";
            break;
        case 64: //  ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE               = 64 ;
            sPropName = "[Use Limitation: Racial Type] ";
            break;
        case 65: //  ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT        = 65 ;
            sPropName = "[Use Limitation: Specific Alignment] ";
            break;
        case 66: //  ITEM_PROPERTY_USE_LIMITATION_TILESET                   = 66 ;
            sPropName = "[Use Limitation: Tileset] ";
            break;
        case 67: //  ITEM_PROPERTY_REGENERATION_VAMPIRIC                    = 67 ;
            sPropName = "[Regeneration: Vampiric] ";
            break;
        case 70: //  ITEM_PROPERTY_TRAP                                     = 70 ;
            sPropName = "[Trap] ";
            break;
        case 71: //  ITEM_PROPERTY_TRUE_SEEING                              = 71 ;
            sPropName = "[True Seeing] ";
            break;
        case 72: //  ITEM_PROPERTY_ON_MONSTER_HIT                           = 72 ;
            sPropName = "[On Monster Hit] ";
            break;
        case 73: //  ITEM_PROPERTY_TURN_RESISTANCE                          = 73 ;
            sPropName = "[Turn Resistance] ";
            break;
        case 74: //  ITEM_PROPERTY_MASSIVE_CRITICALS                        = 74 ;
            sPropName = "[Massive Criticals] ";
            break;
        case 75: //  ITEM_PROPERTY_FREEDOM_OF_MOVEMENT                      = 75 ;
            sPropName = "[Freedom of Movement] ";
            break;
        // no longer working, poison is now a on_hit subtype
        case 76: //  ITEM_PROPERTY_POISON                                   = 76 ;
            sPropName = "[Poison] ";
            break;
        case 77: //  ITEM_PROPERTY_MONSTER_DAMAGE                           = 77 ;
            sPropName = "[Monster Damage] ";
            break;
        case 78: //  ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL                 = 78 ;
            sPropName = "[Immunity: Spells by Level] ";
            break;
        case 79: //  ITEM_PROPERTY_SPECIAL_WALK                             = 79;
            sPropName = "[Special Walk] ";
            break;
        case 80: //  ITEM_PROPERTY_HEALERS_KIT                              = 80;
            sPropName = "[Healers Kit] ";
            break;
        case 81: //  ITEM_PROPERTY_WEIGHT_INCREASE                          = 81;
            sPropName = "[Weight Increase] ";
            break;
        case 82: //  ITEM_PROPERTY_ONHITCASTSPELL                           = 82;
            sPropName = "[On Hit Cast Spell] ";
            break;
        case 83: //  ITEM_PROPERTY_VISUALEFFECT                             = 83;
            sPropName = "[Visual Effect] ";
            break;
        case 84: //  ITEM_PROPERTY_ARCANE_SPELL_FAILURE                     = 84;
            sPropName = "[Arcane Spell Failure] ";
            break;
    }

    return sPropName;
}
