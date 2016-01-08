//::///////////////////////////////////////////////
//::
//:: DM_Itm_GetPrefct
//::
//:: dm_itm_getprefct.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script gets the item property sub category
//:: and sets the appropriate custom tokens. This is
//:: the second script in creating the item property.
//::
//:: <CUSTOM60001> The last item sub property
//:: <CUSTOM60002> The current item sub property
//:: <CUSTOM60003> The next item sub property
//:: <CUSTOM60004> The item sub property number
//:: <CUSTOM60005> The name of the item property
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Nordavind
//::         On: June 4, 2004
//::
//:://////////////////////////////////////////////


int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem = GetLocalObject(oPC, "TARGETED_ITEM");
    int nPropertyNumber = GetLocalInt(oPC, "ITEM_PROPERTY_SELECTED");
    int nSubPropertyNumber = GetLocalInt(oPC, "ITEM_SUB_PROPERTY_SELECTED");
    int nSubPropertyMax = GetLocalInt(oPC, "ITEM_SUB_PROPERTY_MAXIMUM");
    int nSubSubProperty;
    int nItemType = GetBaseItemType(oItem);

    int nResult = TRUE;

    string sNumber = IntToString(nSubPropertyNumber);
    string sItemProperty = GetLocalString(oPC, "ITEM_PROPERTY_NAME");
    string sLast;
    string sSelected;
    string sNext;
    string sSubPropertyName;

    switch(nPropertyNumber)
    {
        case 0: // ITEM_PROPERTY_ABILITY_BONUS                            = 0 ;
        case 27: // ITEM_PROPERTY_DECREASED_ABILITY_SCORE                  = 27 ;
            switch(nSubPropertyNumber)
            {
                case 0: // IP_CONST_ABILITY_STR
                    sLast = "5: Charisma";
                    sSelected = "0: Strength";
                    sNext = "1: Dexterity";
                    break;
                case 1: // IP_CONST_ABILITY_DEX
                    sLast = "0: Strength";
                    sSelected = "1: Dexterity";
                    sNext = "2: Constitution";
                    break;
                case 2: // IP_CONST_ABILITY_CON
                    sLast = "1: Dexterity";
                    sSelected = "2: Constitution";
                    sNext = "3: Intelligence";
                    break;
                case 3: // IP_CONST_ABILITY_INT
                    sLast = "2: Constitution";
                    sSelected = "3: Intelligence";
                    sNext = "4: Wizdom";
                    break;
                case 4: // IP_CONST_ABILITY_WIS
                    sLast = "3: Intelligence";
                    sSelected = "4: Wizdom";
                    sNext = "5: Charisma";
                    break;
                case 5: // IP_CONST_ABILITY_CHA
                    sLast = "4: Wizdom";
                    sSelected = "5: Charisma";
                    sNext = "0: Strength";
                    break;
            }
            nSubPropertyMax = 5;
            break;
        case 1: // ITEM_PROPERTY_AC_BONUS                                 = 1 ;
        case 6: // ITEM_PROPERTY_ENHANCEMENT_BONUS                        = 6 ;
        case 10: // ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER           = 10 ;
        case 11: // ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION               = 11 ;
        case 12: // ITEM_PROPERTY_BONUS_FEAT                               = 12 ;
        case 21: // ITEM_PROPERTY_DECREASED_DAMAGE                         = 21 ;
        case 32: // ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT        = 32 ;
        case 39: // ITEM_PROPERTY_SPELL_RESISTANCE                         = 39 ;
        case 45: // ITEM_PROPERTY_MIGHTY        -=Max Strength Mod=-       = 45 ;
        case 51: // ITEM_PROPERTY_REGENERATION                             = 51 ;
        case 55: // ITEM_PROPERTY_THIEVES_TOOLS                            = 55 ;
        case 56: // ITEM_PROPERTY_ATTACK_BONUS                             = 56 ;
        case 60: // ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER                = 60 ;
        case 61: // ITEM_PROPERTY_UNLIMITED_AMMUNITION                     = 61 ;
        case 67: // ITEM_PROPERTY_REGENERATION_VAMPIRIC                    = 67 ;
        case 73: // ITEM_PROPERTY_TURN_RESISTANCE                          = 73 ;
        case 74: // ITEM_PROPERTY_MASSIVE_CRITICALS                        = 74 ;
        case 77: // ITEM_PROPERTY_MONSTER_DAMAGE                           = 77 ;
        case 78: // ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL                 = 78 ;
        case 80: // ITEM_PROPERTY_HEALERS_KIT                              = 80;
        case 81: // ITEM_PROPERTY_WEIGHT_INCREASE                          = 81;
        case 83: // ITEM_PROPERTY_VISUALEFFECT                             = 83;
        case 84: // ITEM_PROPERTY_ARCANE_SPELL_FAILURE                     = 84;
            sLast = "No Sub Category";
            sSelected = "No Sub Category";
            sNext = "No Sub Category";
            if (nSubPropertyNumber == 32 & nItemType == BASE_ITEM_LARGEBOX ||
                nSubPropertyNumber == 45 & nItemType == BASE_ITEM_LIGHTCROSSBOW ||
                nSubPropertyNumber == 45 & nItemType == BASE_ITEM_LONGBOW ||
                nSubPropertyNumber == 45 & nItemType == BASE_ITEM_SHORTBOW ||
                nSubPropertyNumber == 45 & nItemType == BASE_ITEM_DART ||
                nSubPropertyNumber == 45 & nItemType == BASE_ITEM_HEAVYCROSSBOW ||
                nSubPropertyNumber == 45 & nItemType == BASE_ITEM_SLING ||
                nSubPropertyNumber == 45 & nItemType == BASE_ITEM_SHURIKEN ||
                nSubPropertyNumber == 45 & nItemType == BASE_ITEM_THROWINGAXE)
                nResult = FALSE;
            nSubPropertyMax = 0;
            break;

    //:://///////////////////
    //:: ALIGNMENT GROUPS
    //:://///////////////////
        case 2: // ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP              = 2 ;
        case 7: // ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP     = 7 ;
        case 17: // ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP          = 17 ;
        case 57: // ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP          = 57 ;
        case 62: // ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP           = 62 ;
            switch(nSubPropertyNumber)
            {
                case 0: // IP_CONST_ALIGNMENTGROUP_ALL                 = 0;
                    sLast = "5: Alignment Group: Evil";
                    sSelected = "0: Alignment Group: All";
                    sNext = "1: Alignment Group: Neutral";
                    break;
                case 1: // IP_CONST_ALIGNMENTGROUP_NEUTRAL             = 1;
                    sLast = "0: Alignment Group: All";
                    sSelected = "1: Alignment Group: Neutral";
                    sNext = "2: Alignment Group: Lawful";
                    break;
                case 2: // IP_CONST_ALIGNMENTGROUP_LAWFUL              = 2;
                    sLast = "1: Alignment Group: Neutral";
                    sSelected = "2: Alignment Group: Lawful";
                    sNext = "3: Alignment Group: Chaotic";
                    break;
                case 3: // IP_CONST_ALIGNMENTGROUP_CHAOTIC             = 3;
                    sLast = "2: Alignment Group: Lawful";
                    sSelected = "3: Alignment Group: Chaotic";
                    sNext = "4: Alignment Group: Good";
                    break;
                case 4: // IP_CONST_ALIGNMENTGROUP_GOOD                = 4;
                    sLast = "3: Alignment Group: Chaotic";
                    sSelected = "4: Alignment Group: Good";
                    sNext = "5: Alignment Group: Evil";
                    break;
                case 5: // IP_CONST_ALIGNMENTGROUP_EVIL                = 5;
                    sLast = "4: Alignment Group: Good";
                    sSelected = "5: Alignment Group: Evil";
                    sNext = "0: Alignment Group: All";
                    break;
            }
            nSubPropertyMax = 5;
//            nSubSubProperty = TRUE;
            break;
//::///////////////////
//:: DAMAGE TYPE
//::///////////////////
        case 3: // ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE                  = 3 ;
        case 16: // ITEM_PROPERTY_DAMAGE_BONUS                             = 16 ;
        case 20: // ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE                     = 20 ;
        case 23: // ITEM_PROPERTY_DAMAGE_RESISTANCE                        = 23 ;
        case 24: // ITEM_PROPERTY_DAMAGE_VULNERABILITY                     = 24 ;
            switch(nSubPropertyNumber)
            {
                case 0: // IP_CONST_DAMAGETYPE_BLUDGEONING             = 0;
                    sLast = "13: Damage Type: Sonic";
                    sSelected = "0: Damage Type: Bludgeoning";
                    sNext = "1: Damage Type: Piercing";
                    break;
                case 1: // int IP_CONST_DAMAGETYPE_PIERCING                = 1;
                    sLast = "0: Damage Type: Bludgeoning";
                    sSelected = "1: Damage Type: Piercing";
                    sNext = "2: Damage Type: Slashing";
                    break;
                case 2: // int IP_CONST_DAMAGETYPE_SLASHING                = 2;
                    sLast = "1: Damage Type: Piercing";
                    sSelected = "2: Damage Type: Slashing";
                    sNext = "3: Damage Type: Subdual";
                    break;
                case 3: // int IP_CONST_DAMAGETYPE_SUBDUAL                 = 3;
                    sLast = "2: Damage Type: Slashing";
                    sSelected = "3: Damage Type: Subdual";
                    sNext = "4: Damage Type: Physical";
                    break;
                case 4: // int IP_CONST_DAMAGETYPE_PHYSICAL                = 4;
                    sLast = "3: Damage Type: Subdual";
                    sSelected = "4: Damage Type: Physical";
                    sNext = "5: Damage Type: Magical";
                    break;
                case 5: // int IP_CONST_DAMAGETYPE_MAGICAL                 = 5;
                    sLast = "4: Damage Type: Physical";
                    sSelected = "5: Damage Type: Magical";
                    sNext = "6: Damage Type: Acid";
                    break;
                case 6: // int IP_CONST_DAMAGETYPE_ACID                    = 6;
                    sLast = "5: Damage Type: Magical";
                    sSelected = "6: Damage Type: Acid";
                    sNext = "7: Damage Type: Cold";
                    break;
                case 7: // int IP_CONST_DAMAGETYPE_COLD                    = 7;
                    sLast = "4: Damage Type: Acid";
                    sSelected = "5: Damage Type: Cold";
                    sNext = "6: Damage Type: Divine";
                    break;
                case 8: // int IP_CONST_DAMAGETYPE_DIVINE                  = 8;
                    sLast = "7: Damage Type: Cold";
                    sSelected = "8: Damage Type: Divine";
                    sNext = "9: Damage Type: Electrical";
                    break;
                case 9: // int IP_CONST_DAMAGETYPE_ELECTRICAL              = 9;
                    sLast = "8: Damage Type: Divine";
                    sSelected = "9: Damage Type: Electrical";
                    sNext = "10: Damage Type: Fire";
                    break;
                case 10: // int IP_CONST_DAMAGETYPE_FIRE                    = 10;
                    sLast = "9: Damage Type: Electrical";
                    sSelected = "10: Damage Type: Fire";
                    sNext = "11: Damage Type: Negative";
                    break;
                case 11: // int IP_CONST_DAMAGETYPE_NEGATIVE                = 11;
                    sLast = "10: Damage Type: Fire";
                    sSelected = "11: Damage Type: Negative";
                    sNext = "12: Damage Type: Positive";
                    break;
                case 12: // int IP_CONST_DAMAGETYPE_POSITIVE                = 12;
                    sLast = "11: Damage Type: Negative";
                    sSelected = "12: Damage Type: Positive";
                    sNext = "13: Damage Type: Sonic";
                    break;
                case 13: // int IP_CONST_DAMAGETYPE_SONIC                   = 13;
                    sLast = "12: Damage Type: Positive";
                    sSelected = "13: Damage Type: Sonic";
                    sNext = "0: Damage Type: Bludgeoning";
                    break;
            }
            nSubPropertyMax = 13;
            break;

        case 4: // ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP                 = 4 ;
        case 8: // ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP        = 8 ;
        case 18: // ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP             = 18 ;
        case 58: // ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP             = 58 ;
        case 64: // ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE               = 64 ;
            switch(nSubPropertyNumber)
            {
                case 0: // IP_CONST_RACIALTYPE_DWARF                   = 0;
                    sLast = "23: Racialtype: Vermin";
                    sSelected = "0: Racialtype: Dwarf";
                    sNext = "1: Racialtype: Elf";
                    break;
                case 1: // IP_CONST_RACIALTYPE_ELF                     = 1;
                    sLast = "0: Racialtype: Dwarf";
                    sSelected = "1: Racialtype: Elf";
                    sNext = "2: Racialtype: Gnome";
                    break;
                case 2: // IP_CONST_RACIALTYPE_GNOME                   = 2;
                    sLast = "1: Racialtype: Elf";
                    sSelected = "2: Racialtype: Gnome";
                    sNext = "3: Racialtype: Halfling";
                    break;
                case 3: // IP_CONST_RACIALTYPE_HALFLING                = 3;
                    sLast = "2: Racialtype: Gnome";
                    sSelected = "3: Racialtype: Halfling";
                    sNext = "4: Racialtype: Half-Elf";
                    break;
                case 4: // IP_CONST_RACIALTYPE_HALFELF                 = 4;
                    sLast = "3: Racialtype: Halfling";
                    sSelected = "4: Racialtype: Half-Elf";
                    sNext = "5: Racialtype: Half-Orc";
                    break;
                case 5: // IP_CONST_RACIALTYPE_HALFORC                 = 5;
                    sLast = "4: Racialtype: Half-Elf";
                    sSelected = "5: Racialtype: Half-Orc";
                    sNext = "6: Racialtype: Human";
                    break;
                case 6: // IP_CONST_RACIALTYPE_HUMAN                   = 6;
                    sLast = "5: Racialtype: Half-Orc";
                    sSelected = "6: Racialtype: Human";
                    sNext = "7: Racialtype: Aberration";
                    break;
                case 7: // IP_CONST_RACIALTYPE_ABERRATION              = 7;
                    sLast = "6: Racialtype: Human";
                    sSelected = "7: Racialtype: Aberration";
                    sNext = "8: Racialtype: Animal";
                    break;
                case 8: // IP_CONST_RACIALTYPE_ANIMAL                  = 8;
                    sLast = "7: Racialtype: Aberration";
                    sSelected = "8: Racialtype: Animal";
                    sNext = "9: Racialtype: Beast";
                    break;
                case 9: // IP_CONST_RACIALTYPE_BEAST                   = 9;
                    sLast = "8: Racialtype: Animal";
                    sSelected = "9: Racialtype: Beast";
                    sNext = "10: Racialtype: Construct";
                    break;
                case 10: // IP_CONST_RACIALTYPE_CONSTRUCT               = 10;
                    sLast = "9: Racialtype: Beast";
                    sSelected = "10: Racialtype: Construct";
                    sNext = "11: Racialtype: Dragon";
                    break;
                case 11: // IP_CONST_RACIALTYPE_DRAGON                  = 11;
                    sLast = "10: Racialtype: Construct";
                    sSelected = "11: Racialtype: Dragon";
                    sNext = "12: Racialtype: Humanoid Goblinoid";
                    break;
                case 12: // IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID      = 12;
                    sLast = "11: Racialtype: Dragon";
                    sSelected = "12: Racialtype: Humanoid Goblinoid";
                    sNext = "13: Racialtype: Humanoid Monstrous";
                    break;
                case 13: // IP_CONST_RACIALTYPE_HUMANOID_MONSTROUS      = 13;
                    sLast = "12: Racialtype: Humanoid Goblinoid";
                    sSelected = "13: Racialtype: Humanoid Monstrous";
                    sNext = "14: Racialtype: Humanoid Orc";
                    break;
                case 14: // IP_CONST_RACIALTYPE_HUMANOID_ORC            = 14;
                    sLast = "13: Racialtype: Humanoid Monstrous";
                    sSelected = "14: Racialtype: Humanoid Orc";
                    sNext = "14: Racialtype: Humanoid Reptilian";
                    break;
                case 15: // IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN      = 15;
                    sLast = "14: Racialtype: Humanoid Orc";
                    sSelected = "15: Racialtype: Humanoid Reptilian";
                    sNext = "16: Racialtype: Elemental";
                    break;
                case 16: // IP_CONST_RACIALTYPE_ELEMENTAL               = 16;
                    sLast = "15: Racialtype: Humanoid Reptilian";
                    sSelected = "16: Racialtype: Elemental";
                    sNext = "17: Racialtype: Fey";
                    break;
                case 17: // IP_CONST_RACIALTYPE_FEY                     = 17;
                    sLast = "16: Racialtype: Elemental";
                    sSelected = "17: Racialtype: Fey";
                    sNext = "18: Racialtype: Giant";
                    break;
                case 18: // IP_CONST_RACIALTYPE_GIANT                   = 18;
                    sLast = "17: Racialtype: Fey";
                    sSelected = "18: Racialtype: Giant";
                    sNext = "19: Racialtype: Magical Beast";
                    break;
                case 19: // IP_CONST_RACIALTYPE_MAGICAL_BEAST           = 19;
                    sLast = "18: Racialtype: Giant";
                    sSelected = "19: Racialtype: Magical Beast";
                    sNext = "20: Racialtype: Outsider";
                    break;
                case 20: // IP_CONST_RACIALTYPE_OUTSIDER                = 20;
                    sLast = "19: Racialtype: Magical Beast";
                    sSelected = "20: Racialtype: Outsider";
                    sNext = "21: not valid";
                    break;
                case 21:
                    sLast = "20: Racialtype: Outsider";
                    sSelected = "21: not valid";
                    sNext = "22: not valid";
                    break;
                case 22:
                    sLast = "21: not valid";
                    sSelected = "22: not valid";
                    sNext = "23: Racialtype: Shapechanger";
                    break;
                case 23: // IP_CONST_RACIALTYPE_SHAPECHANGER            = 23;
                    sLast = "22: not valid";
                    sSelected = "23: Racialtype: Shapechanger";
                    sNext = "24: Racialtype: Undead";
                    break;
                case 24: // IP_CONST_RACIALTYPE_UNDEAD                  = 24;
                    sLast = "23: Racialtype: Shapechanger";
                    sSelected = "24: Racialtype: Undead";
                    sNext = "25: Racialtype: Vermin";
                    break;
                case 25: // IP_CONST_RACIALTYPE_VERMIN                  = 25;
                    sLast = "24: Racialtype: Undead";
                    sSelected = "25: Racialtype: Vermin";
                    sNext = "0: Racialtype: Dwarf";
                    break;
            }
            nSubPropertyMax = 25;
            break;
        case 5: // ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT           = 5 ;
        case 9: // ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT = 9 ;
        case 19: // ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT       = 19 ;
        case 59: // ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT       = 59 ;
        case 65: // ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT        = 65 ;
            switch(nSubPropertyNumber)
            {
                case 0: // IP_CONST_ALIGNMENT_LG                       = 0;
                    sLast = "8: Alignment: Chaotic Evil";
                    sSelected = "0: Alignment: Lawfull Good";
                    sNext = "1: Alignment: Lawfull Neutral";
                    break;
                case 1: // IP_CONST_ALIGNMENT_LN                       = 1;
                    sLast = "0: Alignment: Lawfull Good";
                    sSelected = "1: Alignment: Lawfull Neutral";
                    sNext = "2: Alignment: Lawfull Evil";
                    break;
                case 2: // IP_CONST_ALIGNMENT_LE                       = 2;
                    sLast = "1: Alignment: Lawfull Neutral";
                    sSelected = "2: Alignment: Lawfull Evil";
                    sNext = "3: Alignment: Neutral Good";
                    break;
                case 3: // IP_CONST_ALIGNMENT_NG                       = 3;
                    sLast = "2: Alignment: Lawfull Evil";
                    sSelected = "3: Alignment: Neutral Good";
                    sNext = "4: Alignment: True Neutral";
                    break;
                case 4: // IP_CONST_ALIGNMENT_TN                       = 4;
                    sLast = "3: Alignment: Neutral Good";
                    sSelected = "4: Alignment: True Neutral";
                    sNext = "5: Alignment: Neutral Evil";
                    break;
                case 5: // IP_CONST_ALIGNMENT_NE                       = 5;
                    sLast = "4: Alignment: True Neutral";
                    sSelected = "5: Alignment: Neutral Evil";
                    sNext = "6: Alignment: Chaotic Good";
                    break;
                case 6: // IP_CONST_ALIGNMENT_CG                       = 6;
                    sLast = "5: Alignment: Neutral Evil";
                    sSelected = "6: Alignment: Chaotic Good";
                    sNext = "7: Alignment: Chaotic Neutral";
                    break;
                case 7: // IP_CONST_ALIGNMENT_CN                       = 7;
                    sLast = "6: Alignment: Chaotic Good";
                    sSelected = "7: Alignment: Chaotic Neutral";
                    sNext = "8: Alignment: Chaotic Evil";
                    break;
                case 8: // IP_CONST_ALIGNMENT_CE                       = 8;
                    sLast = "7: Alignment: Chaotic Neutral";
                    sSelected = "8: Alignment: Chaotic Evil";
                    sNext = "0: Alignment: Lawfull Good";
                    break;
            }
            nSubPropertyMax = 8;
            break;
//        case 6: // ITEM_PROPERTY_ENHANCEMENT_BONUS                        = 6 ;
//            break;
//        case 7: // ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP     = 7 ;
//            break;
//        case 8: // ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP        = 8 ;
//            break;
//        case 9: // ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT = 9 ;
//            break;
//        case 10: // ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER           = 10 ;
//            break;
//        case 11: // ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION               = 11 ;
//            break;
//        case 11: // ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION               = 11 ;
//        case 12: // ITEM_PROPERTY_BONUS_FEAT                               = 12 ;
//            break;
        case 13: // ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N              = 13 ;
        case 63: // ITEM_PROPERTY_USE_LIMITATION_CLASS                     = 63 ;
            switch(nSubPropertyNumber)
            {
                case 0: // IP_CONST_CLASS_BARBARIAN                            = 0;
                    sLast = "10: Class: Wizard";
                    sSelected = "0: Class: Barbarian [No Spell Slots]";
                    sNext = "1: Class: Bard";
                    break;
                case 1: // IP_CONST_CLASS_BARD                                 = 1;
                    sLast = "0: Class: Barbarian [No Spell Slots]";
                    sSelected = "1: Class: Bard";
                    sNext = "2: Class: Cleric";
                    break;
                case 2: // IP_CONST_CLASS_CLERIC                               = 2;
                    sLast = "1: Class: Bard";
                    sSelected = "2: Class: Cleric";
                    sNext = "3: Class: Druid";
                    break;
                case 3: // IP_CONST_CLASS_DRUID                                = 3;
                    sLast = "2: Class: Cleric";
                    sSelected = "3: Class: Druid";
                    sNext = "4: Class: Fighter [No Spell Slots]";
                    break;
                case 4: // IP_CONST_CLASS_FIGHTER                              = 4;
                    sLast = "3: Class: Druid";
                    sSelected = "4: Class: Fighter [No Spell Slots]";
                    sNext = "5: Class: Monk [No Spell Slots]";
                    break;
                case 5: // IP_CONST_CLASS_MONK                                 = 5;
                    sLast = "4: Class: Fighter [No Spell Slots]";
                    sSelected = "5: Class: Monk [No Spell Slots]";
                    sNext = "6: Class: Paladin";
                    break;
                case 6: // IP_CONST_CLASS_PALADIN                              = 6;
                    sLast = "5: Class: Monk [No Spell Slots]";
                    sSelected = "6: Class: Paladin";
                    sNext = "7: Class: Ranger";
                    break;
                case 7: // IP_CONST_CLASS_RANGER                               = 7;
                    sLast = "6: Class: Paladin";
                    sSelected = "7: Class: Ranger";
                    sNext = "8: Class: Rogue [No Spell Slots]";
                    break;
                case 8: // IP_CONST_CLASS_ROGUE                                = 8;
                    sLast = "7: Class: Ranger";
                    sSelected = "8: Class: Rogue [No Spell Slots]";
                    sNext = "9: Class: Sorcerer";
                    break;
                case 9: // IP_CONST_CLASS_SORCERER                             = 9;
                    sLast = "8: Class: Rogue [No Spell Slots]";
                    sSelected = "9: Class: Sorcerer";
                    sNext = "10: Class: Wizard";
                    break;
                case 10: // IP_CONST_CLASS_WIZARD                               = 10
                    sLast = "9: Class: Sorcerer";
                    sSelected = "10: Class: Wizard";
                    sNext = "0: Class: Barbarian [No Spell Slots]";
                    break;
            }
            nSubPropertyMax = 10;
            break;
        case 14: //
        case 25: //
        case 30: //
        case 31: //
        case 42: //
        case 68: //
        case 69: //
        case 76: // ITEM_PROPERTY_POISON (not woring)
            sLast = "NOT AN ITEM PROPERTY";
            sSelected = "NOT AN ITEM PROPERTY";
            sNext = "NOT AN ITEM PROPERTY";
            nResult = FALSE;
            break;
        case 15: // ITEM_PROPERTY_CAST_SPELL                               = 15 ;
            switch(nSubPropertyNumber)
            {
                case 0: // int IP_CONST_CASTSPELL_ACID_FOG_11                      = 0:
                    sLast = "410: Cast Spell: Gust of Wind [10]";
                    sSelected = "0: Cast Spell: Acid Fog [11]";
                    sNext = "1: Cast Spell: Aid [3]";
                    break;
                case 1: // int IP_CONST_CASTSPELL_AID_3                            = 1:
                    sLast = "0: Cast Spell: Acid Fog [11]";
                    sSelected = "1: Cast Spell: Aid [3]";
                    sNext = "2: Cast Spell: Animate Dead [5]";
                    break;
                case 2: // int IP_CONST_CASTSPELL_ANIMATE_DEAD_5                   = 2:
                    sLast = "1: Cast Spell: Aid [3]";
                    sSelected = "2: Cast Spell: Animate Dead [5]";
                    sNext = "3: Cast Spell: Animate Dead [10]";
                    break;
                case 3: // int IP_CONST_CASTSPELL_ANIMATE_DEAD_10                  = 3:
                    sLast = "2: Cast Spell: Animate Dead [5]";
                    sSelected = "3: Cast Spell: Animate Dead [10]";
                    sNext = "4: Cast Spell: Animate Dead [15]";
                    break;
                case 4: // int IP_CONST_CASTSPELL_ANIMATE_DEAD_15                  = 4:
                    sLast = "3: Cast Spell: Animate Dead [10]";
                    sSelected = "4: Cast Spell: Animate Dead [15]";
                    sNext = "5: Cast Spell: Barkskin [3]";
                    break;
                case 5: // int IP_CONST_CASTSPELL_BARKSKIN_3                       = 5:
                    sLast = "4: Cast Spell: Animate Dead [15]";
                    sSelected = "5: Cast Spell: Barkskin [3]";
                    sNext = "6: Cast Spell: Barkskin [6]";
                    break;
                case 6: // int IP_CONST_CASTSPELL_BARKSKIN_6                       = 6:
                    sLast = "5: Cast Spell: Barkskin [3]";
                    sSelected = "6: Cast Spell: Barkskin [6]";
                    sNext = "7: Cast Spell: Barkskin [12]";
                    break;
                case 7: // int IP_CONST_CASTSPELL_BARKSKIN_12                      = 7:
                    sLast = "6: Cast Spell: Barkskin [6]";
                    sSelected = "7: Cast Spell: Barkskin [12]";
                    sNext = "8: Cast Spell: Bestowe Curse [5]";
                    break;
                case 8: // int IP_CONST_CASTSPELL_BESTOW_CURSE_5                   = 8:
                    sLast = "7: Cast Spell: Barkskin [12]";
                    sSelected = "8: Cast Spell: Bestowe Curse [5]";
                    sNext = "9: Cast Spell: Blade Barrier [11]";
                    break;
                case 9: // int IP_CONST_CASTSPELL_BLADE_BARRIER_11                 = 9:
                    sLast = "8: Cast Spell: Bestowe Curse [5]";
                    sSelected = "9: Cast Spell: Blade Barrier [11]";
                    sNext = "10: Cast Spell: Blade Barrier [15]";
                    break;
                case 10: // int IP_CONST_CASTSPELL_BLADE_BARRIER_15                 = 10:
                    sLast = "9: Cast Spell: Blade Barrier [11]";
                    sSelected = "10: Cast Spell: Blade Barrier [15]";
                    sNext = "11: Cast Spell: Bless [2]";
                    break;
                case 11: // int IP_CONST_CASTSPELL_BLESS_2                          = 11:
                    sLast = "10: Cast Spell: Blade Barrier [15]";
                    sSelected = "11: Cast Spell: Bless [2]";
                    sNext = "12: <No Spell>";
                    break;
                case 12:
                    sLast = "11: Cast Spell: Bless [2]";
                    sSelected = "12: <No Spell>";
                    sNext = "13: <No Spell>";
                    break;
                case 13:
                    sLast = "12: <No Spell>";
                    sSelected = "13: <No Spell>";
                    sNext = "14: Cast Spell: Blindness/Deafness [3]";
                    break;
                case 14: // int IP_CONST_CASTSPELL_BLINDNESS_DEAFNESS_3             = 14:
                    sLast = "13: <No Spell>";
                    sSelected = "14: Cast Spell: Blindness/Deafness [3]";
                    sNext = "15: Cast Spell: Bulls Strength [3]";
                    break;
                case 15: // int IP_CONST_CASTSPELL_BULLS_STRENGTH_3                 = 15:
                    sLast = "14: Cast Spell: Blindness/Deafness [3]";
                    sSelected = "15: Cast Spell: Bulls Strength [3]";
                    sNext = "16: Cast Spell: Bulls Strength [10]";
                    break;
                case 16: // int IP_CONST_CASTSPELL_BULLS_STRENGTH_10                = 16:
                    sLast = "15: Cast Spell: Bulls Strength [3]";
                    sSelected = "16: Cast Spell: Bulls Strength [10]";
                    sNext = "17: Cast Spell: Bulls Strength [15]";
                    break;
                case 17: // int IP_CONST_CASTSPELL_BULLS_STRENGTH_15                = 17:
                    sLast = "16: Cast Spell: Bulls Strength [10]";
                    sSelected = "17: Cast Spell: Bulls Strength [15]";
                    sNext = "18: Cast Spell: Burning Hands [2]";
                    break;
                case 18: // int IP_CONST_CASTSPELL_BURNING_HANDS_2                  = 18:
                    sLast = "17: Cast Spell: Bulls Strength [15]";
                    sSelected = "18: Cast Spell: Burning Hands [2]";
                    sNext = "19: Cast Spell: Burning Hands [5]";
                    break;
                case 19: // int IP_CONST_CASTSPELL_BURNING_HANDS_5                  = 19:
                    sLast = "18: Cast Spell: Burning Hands [2]";
                    sSelected = "19: Cast Spell: Burning Hands [5]";
                    sNext = "20: Cast Spell: Call Lightning [5]";
                    break;
                case 20: // int IP_CONST_CASTSPELL_CALL_LIGHTNING_5                 = 20:
                    sLast = "19: Cast Spell: Burning Hands [5]";
                    sSelected = "20: Cast Spell: Call Lightning [5]";
                    sNext = "21: Cast Spell: Call Lightning [10]";
                    break;
                case 21: // int IP_CONST_CASTSPELL_CALL_LIGHTNING_10                = 21:
                    sLast = "20: Cast Spell: Call Lightning [5]";
                    sSelected = "21: Cast Spell: Call Lightning [10]";
                    sNext = "22: <No Spell>";
                    break;
                case 22:
                    sLast = "21: Cast Spell: Call Lightning [10]";
                    sSelected = "22: <No Spell>";
                    sNext = "23: <No Spell>";
                    break;
                case 23:
                    sLast = "22: <No Spell>";
                    sSelected = "23: <No Spell>";
                    sNext = "24: <No Spell>";
                    break;
                case 24:
                    sLast = "23: <No Spell>";
                    sSelected = "24: <No Spell>";
                    sNext = "25: Cast Spell: Cats Grace [3]";
                    break;
                case 25: // int IP_CONST_CASTSPELL_CATS_GRACE_3                     = 25:
                    sLast = "24: <No Spell>";
                    sSelected = "25: Cast Spell: Cats Grace [3]";
                    sNext = "26: Cast Spell: Cats Grace [10]";
                    break;
                case 26: // int IP_CONST_CASTSPELL_CATS_GRACE_10                    = 26:
                    sLast = "25: Cast Spell: Cats Grace [3]";
                    sSelected = "26: Cast Spell: Cats Grace [10]";
                    sNext = "27: Cast Spell: Cats Grace [15]";
                    break;
                case 27: // int IP_CONST_CASTSPELL_CATS_GRACE_15                    = 27:
                    sLast = "26: Cast Spell: Cats Grace [10]";
                    sSelected = "27: Cast Spell: Cats Grace [15]";
                    sNext = "28: Cast Spell: Chain Lightning [11]";
                    break;
                case 28: // int IP_CONST_CASTSPELL_CHAIN_LIGHTNING_11               = 28:
                    sLast = "27: Cast Spell: Cats Grace [15]";
                    sSelected = "28: Cast Spell: Chain Lightning [11]";
                    sNext = "29: Cast Spell: Chain Lightning [15]";
                    break;
                case 29: // int IP_CONST_CASTSPELL_CHAIN_LIGHTNING_15               = 29:
                    sLast = "28: Cast Spell: Chain Lightning [11]";
                    sSelected = "29: Cast Spell: Chain Lightning [15]";
                    sNext = "30: Cast Spell: Chain Lightning [20]";
                    break;
                case 30: // int IP_CONST_CASTSPELL_CHAIN_LIGHTNING_20               = 30:
                    sLast = "29: Cast Spell: Chain Lightning [15]";
                    sSelected = "30: Cast Spell: Chain Lightning [20]";
                    sNext = "31: Cast Spell: Charm Monster [5]";
                    break;
                case 31: // int IP_CONST_CASTSPELL_CHARM_MONSTER_5                  = 31:
                    sLast = "30: Cast Spell: Chain Lightning [20]";
                    sSelected = "31: Cast Spell: Charm Monster [5]";
                    sNext = "32: Cast Spell: Charm Monster [10]";
                    break;
                case 32: // int IP_CONST_CASTSPELL_CHARM_MONSTER_10                 = 32:
                    sLast = "31: Cast Spell: Charm Monster [5]";
                    sSelected = "32: Cast Spell: Charm Monster [10]";
                    sNext = "33: Cast Spell: Charm Person [2]";
                    break;
                case 33: // int IP_CONST_CASTSPELL_CHARM_PERSON_2                   = 33:
                    sLast = "32: Cast Spell: Charm Monster [10]";
                    sSelected = "33: Cast Spell: Charm Person [2]";
                    sNext = "34: Cast Spell: Charm Person [10]";
                    break;
                case 34: // int IP_CONST_CASTSPELL_CHARM_PERSON_10                  = 34:
                    sLast = "33: Cast Spell: Charm Person [2]";
                    sSelected = "34: Cast Spell: Charm Person [10]";
                    sNext = "35: Cast Spell: Charm Person or Animal [3]";
                    break;
                case 35: // int IP_CONST_CASTSPELL_CHARM_PERSON_OR_ANIMAL_3         = 35:
                    sLast = "34: Cast Spell: Charm Person [10]";
                    sSelected = "35: Cast Spell: Charm Person or Animal [3]";
                    sNext = "36: Cast Spell: Charm Person or Animal [10]";
                    break;
                case 36: // int IP_CONST_CASTSPELL_CHARM_PERSON_OR_ANIMAL_10        = 36:
                    sLast = "35: Cast Spell: Charm Person or Animal [3]";
                    sSelected = "36: Cast Spell: Charm Person or Animal [10]";
                    sNext = "37: Cast Spell: Circle of Death [11]";
                    break;
                case 37: // int IP_CONST_CASTSPELL_CIRCLE_OF_DEATH_11               = 37:
                    sLast = "36: Cast Spell: Charm Person or Animal [10]";
                    sSelected = "37: Cast Spell: Circle of Death [11]";
                    sNext = "38: Cast Spell: Circle of Death [15]";
                    break;
                case 38: // int IP_CONST_CASTSPELL_CIRCLE_OF_DEATH_15               = 38:
                    sLast = "37: Cast Spell: Circle of Death [11]";
                    sSelected = "38: Cast Spell: Circle of Death [15]";
                    sNext = "39: Cast Spell: Circle of Death [20]";
                    break;
                case 39: // int IP_CONST_CASTSPELL_CIRCLE_OF_DEATH_20               = 39:
                    sLast = "38: Cast Spell: Circle of Death [15]";
                    sSelected = "39: Cast Spell: Circle of Death [20]";
                    sNext = "40: Cast Spell: Circle of Doom [9]";
                    break;
                case 40: // int IP_CONST_CASTSPELL_CIRCLE_OF_DOOM_9                 = 40:
                    sLast = "39: Cast Spell: Circle of Death [20]";
                    sSelected = "40: Cast Spell: Circle of Doom [9]";
                    sNext = "41: Cast Spell: Circle of Doom [15]";
                    break;
                case 41: // int IP_CONST_CASTSPELL_CIRCLE_OF_DOOM_15                = 41:
                    sLast = "40: Cast Spell: Circle of Doom [9]";
                    sSelected = "41: Cast Spell: Circle of Doom [15]";
                    sNext = "42: Cast Spell: Circle of Doom [20]";
                    break;
                case 42: // int IP_CONST_CASTSPELL_CIRCLE_OF_DOOM_20                = 42:
                    sLast = "41: Cast Spell: Circle of Doom [15]";
                    sSelected = "42: Cast Spell: Circle of Doom [20]";
                    sNext = "43: Cast Spell: Clairaudience/Clairvoyance [5]";
                    break;
                case 43: // int IP_CONST_CASTSPELL_CLAIRAUDIENCE_CLAIRVOYANCE_5     = 43:
                    sLast = "42: Cast Spell: Circle of Doom [20]";
                    sSelected = "43: Cast Spell: Clairaudience/Clairvoyance [5]";
                    sNext = "44: Cast Spell: Clairaudience/Clairvoyance [10]";
                    break;
                case 44: // int IP_CONST_CASTSPELL_CLAIRAUDIENCE_CLAIRVOYANCE_10    = 44:
                    sLast = "43: Cast Spell: Clairaudience/Clairvoyance [5]";
                    sSelected = "44: Cast Spell: Clairaudience/Clairvoyance [10]";
                    sNext = "45: Cast Spell: Clairaudience/Clairvoyance [15]";
                    break;
                case 45: // int IP_CONST_CASTSPELL_CLAIRAUDIENCE_CLAIRVOYANCE_15    = 45:
                    sLast = "44: Cast Spell: Clairaudience/Clairvoyance [10]";
                    sSelected = "45: Cast Spell: Clairaudience/Clairvoyance [15]";
                    sNext = "46: Cast Spell: Clarity [3]";
                    break;
                case 46: // int IP_CONST_CASTSPELL_CLARITY_3                        = 46:
                    sLast = "45: Cast Spell: Clairaudience/Clairvoyance [15]";
                    sSelected = "46: Cast Spell: Clarity [3]";
                    sNext = "47: <No Spell>";
                    break;
                case 47:
                    sLast = "46: Cast Spell: Clarity [3]";
                    sSelected = "47: <No Spell>";
                    sNext = "48: Cast Spell: Cloudkill [9]";
                    break;
                case 48: // int IP_CONST_CASTSPELL_CLOUDKILL_9                      = 48:
                    sLast = "47: <No Spell>";
                    sSelected = "48: Cast Spell: Cloudkill [9]";
                    sNext = "49: Cast Spell: Color Spray [2]";
                    break;
                case 49: // int IP_CONST_CASTSPELL_COLOR_SPRAY_2                    = 49:
                    sLast = "48: Cast Spell: Cloudkill [9]";
                    sSelected = "49: Cast Spell: Color Spray [2]";
                    sNext = "50: Cast Spell: Cone of Cold [9]";
                    break;
                case 50: // int IP_CONST_CASTSPELL_CONE_OF_COLD_9                   = 50:
                    sLast = "49: Cast Spell: Color Spray [2]";
                    sSelected = "50: Cast Spell: Cone of Cold [9]";
                    sNext = "51: Cast Spell: Cone of Cold [15]";
                    break;
                case 51: // int IP_CONST_CASTSPELL_CONE_OF_COLD_15                  = 51:
                    sLast = "50: Cast Spell: Cone of Cold [9]";
                    sSelected = "51: Cast Spell: Cone of Cold [15]";
                    sNext = "52: Cast Spell: Confusion [5]";
                    break;
                case 52: // int IP_CONST_CASTSPELL_CONFUSION_5                      = 52:
                    sLast = "51: Cast Spell: Cone of Cold [15]";
                    sSelected = "52: Cast Spell: Confusion [5]";
                    sNext = "53: Cast Spell: Confusion [10]";
                    break;
                case 53: // int IP_CONST_CASTSPELL_CONFUSION_10                     = 53:
                    sLast = "52: Cast Spell: Confusion [5]";
                    sSelected = "53: Cast Spell: Confusion [10]";
                    sNext = "54: Cast Spell: Contagion [5]";
                    break;
                case 54: // int IP_CONST_CASTSPELL_CONTAGION_5                      = 54:
                    sLast = "53: Cast Spell: Confusion [10]";
                    sSelected = "54: Cast Spell: Contagion [5]";
                    sNext = "55: Cast Spell: Control Undead [13]";
                    break;
                case 55: // int IP_CONST_CASTSPELL_CONTROL_UNDEAD_13                = 55:
                    sLast = "54: Cast Spell: Contagion [5]";
                    sSelected = "55: Cast Spell: Control Undead [13]";
                    sNext = "56: Cast Spell: Control Undead [20]";
                    break;
                case 56: // int IP_CONST_CASTSPELL_CONTROL_UNDEAD_20                = 56:
                    sLast = "55: Cast Spell: Control Undead [13]";
                    sSelected = "56: Cast Spell: Control Undead [20]";
                    sNext = "57: Cast Spell: Create Greater Undead [15]";
                    break;
                case 57: // int IP_CONST_CASTSPELL_CREATE_GREATER_UNDEAD_15         = 57:
                    sLast = "56: Cast Spell: Control Undead [20]";
                    sSelected = "57: Cast Spell: Create Greater Undead [15]";
                    sNext = "58: Cast Spell: Create Greater Undead [16]";
                    break;
                case 58: // int IP_CONST_CASTSPELL_CREATE_GREATER_UNDEAD_16         = 58:
                    sLast = "57: Cast Spell: Create Greater Undead [15]";
                    sSelected = "58: Cast Spell: Create Greater Undead [16]";
                    sNext = "59: Cast Spell: Create Greater Undead [18]";
                    break;
                case 59: // int IP_CONST_CASTSPELL_CREATE_GREATER_UNDEAD_18         = 59:
                    sLast = "58: Cast Spell: Create Greater Undead [16]";
                    sSelected = "59: Cast Spell: Create Greater Undead [18]";
                    sNext = "60: Cast Spell: Create Undead [11]";
                    break;
                case 60: // int IP_CONST_CASTSPELL_CREATE_UNDEAD_11                 = 60:
                    sLast = "59: Cast Spell: Create Greater Undead [18]";
                    sSelected = "60: Cast Spell: Create Undead [11]";
                    sNext = "61: Cast Spell: Create Undead [14]";
                    break;
                case 61: // int IP_CONST_CASTSPELL_CREATE_UNDEAD_14                 = 61:
                    sLast = "60: Cast Spell: Create Undead [11]";
                    sSelected = "61: Cast Spell: Create Undead [14]";
                    sNext = "62: Cast Spell: Create Undead [16]";
                    break;
                case 62: // int IP_CONST_CASTSPELL_CREATE_UNDEAD_16                 = 62:
                    sLast = "61: Cast Spell: Create Undead [14]";
                    sSelected = "62: Cast Spell: Create Undead [16]";
                    sNext = "63: Cast Spell: Cure Critical Wounds [7]";
                    break;
                case 63: // int IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_7           = 63:
                    sLast = "62: Cast Spell: Create Undead [16]";
                    sSelected = "63: Cast Spell: Cure Critical Wounds [7]";
                    sNext = "64: Cast Spell: Cure Critical Wounds [12]";
                    break;
                case 64: // int IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_12          = 64:
                    sLast = "63: Cast Spell: Cure Critical Wounds [7]";
                    sSelected = "64: Cast Spell: Cure Critical Wounds [12]";
                    sNext = "65: Cast Spell: Cure Critical Wounds [15]";
                    break;
                case 65: // int IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_15          = 65:
                    sLast = "64: Cast Spell: Cure Critical Wounds [12]";
                    sSelected = "65: Cast Spell: Cure Critical Wounds [15]";
                    sNext = "66: Cast Spell: Cure Light Wounds [2]";
                    break;
                case 66: // int IP_CONST_CASTSPELL_CURE_LIGHT_WOUNDS_2              = 66:
                    sLast = "65: Cast Spell: Cure Critical Wounds [15]";
                    sSelected = "66: Cast Spell: Cure Light Wounds [2]";
                    sNext = "67: Cast Spell: Cure Light Wounds [5]";
                    break;
                case 67: // int IP_CONST_CASTSPELL_CURE_LIGHT_WOUNDS_5              = 67:
                    sLast = "66: Cast Spell: Cure Light Wounds [2]";
                    sSelected = "67: Cast Spell: Cure Light Wounds [5]";
                    sNext = "68: Cast Spell: Cure Minor Wounds [1]";
                    break;
                case 68: // int IP_CONST_CASTSPELL_CURE_MINOR_WOUNDS_1              = 68:
                    sLast = "67: Cast Spell: Cure Light Wounds [5]";
                    sSelected = "68: Cast Spell: Cure Minor Wounds [1]";
                    sNext = "69: Cast Spell: Cure Moderate Wounds [3]";
                    break;
                case 69: // int IP_CONST_CASTSPELL_CURE_MODERATE_WOUNDS_3           = 69:
                    sLast = "68: Cast Spell: Cure Minor Wounds [1]";
                    sSelected = "69: Cast Spell: Cure Moderate Wounds [3]";
                    sNext = "70: Cast Spell: Cure Moderate Wounds [6]";
                    break;
                case 70: // int IP_CONST_CASTSPELL_CURE_MODERATE_WOUNDS_6           = 70:
                    sLast = "69: Cast Spell: Cure Moderate Wounds [3]";
                    sSelected = "70: Cast Spell: Cure Moderate Wounds [6]";
                    sNext = "71: Cast Spell: Cure Moderate Wounds [10]";
                    break;
                case 71: // int IP_CONST_CASTSPELL_CURE_MODERATE_WOUNDS_10          = 71:
                    sLast = "70: Cast Spell: Cure Moderate Wounds [6]";
                    sSelected = "71: Cast Spell: Cure Moderate Wounds [10]";
                    sNext = "72: Cast Spell: Cure Serious Wounds [5]";
                    break;
                case 72: // int IP_CONST_CASTSPELL_CURE_SERIOUS_WOUNDS_5            = 72:
                    sLast = "71: Cast Spell: Cure Moderate Wounds [10]";
                    sSelected = "72: Cast Spell: Cure Serious Wounds [5]";
                    sNext = "73: Cast Spell: Cure Serious Wounds [10]";
                    break;
                case 73: // int IP_CONST_CASTSPELL_CURE_SERIOUS_WOUNDS_10           = 73:
                    sLast = "72: Cast Spell: Cure Serious Wounds [5]";
                    sSelected = "73: Cast Spell: Cure Serious Wounds [10]";
                    sNext = "74: <No Spell>";
                    break;
                case 74:
                    sLast = "73: Cast Spell: Cure Serious Wounds [10]";
                    sSelected = "74: <No Spell>";
                    sNext = "75: Cast Spell: Darkness [3]";
                    break;
                case 75: // int IP_CONST_CASTSPELL_DARKNESS_3                       = 75:
                    sLast = "74: <No Spell>";
                    sSelected = "75: Cast Spell: Darkness [3]";
                    sNext = "76: Cast Spell: Daze [1]";
                    break;
                case 76: // int IP_CONST_CASTSPELL_DAZE_1                           = 76:
                    sLast = "75: Cast Spell: Darkness [3]";
                    sSelected = "76: Cast Spell: Daze [1]";
                    sNext = "77: Cast Spell: Death Ward [7]";
                    break;
                case 77: // int IP_CONST_CASTSPELL_DEATH_WARD_7                     = 77:
                    sLast = "76: Cast Spell: Daze [1]";
                    sSelected = "77: Cast Spell: Death Ward [7]";
                    sNext = "78: Cast Spell: Delayed Fireball Blast [13]";
                    break;
                case 78: // int IP_CONST_CASTSPELL_DELAYED_BLAST_FIREBALL_13        = 78:
                    sLast = "77: Cast Spell: Death Ward [7]";
                    sSelected = "78: Cast Spell: Delayed Fireball Blast [13]";
                    sNext = "79: Cast Spell: Delayed Fireball Blast [15]";
                    break;
                case 79: // int IP_CONST_CASTSPELL_DELAYED_BLAST_FIREBALL_15        = 79:
                    sLast = "78: Cast Spell: Delayed Fireball Blast [13]";
                    sSelected = "79: Cast Spell: Delayed Fireball Blast [15]";
                    sNext = "80: Cast Spell: Delayed Fireball Blast [20]";
                    break;
                case 80: // int IP_CONST_CASTSPELL_DELAYED_BLAST_FIREBALL_20        = 80:
                    sLast = "79: Cast Spell: Delayed Fireball Blast [15]";
                    sSelected = "80: Cast Spell: Delayed Fireball Blast [20]";
                    sNext = "81: Cast Spell: Dismissal [7]";
                    break;
                case 81: // int IP_CONST_CASTSPELL_DISMISSAL_7                      = 81:
                    sLast = "80: Cast Spell: Delayed Fireball Blast [20]";
                    sSelected = "81: Cast Spell: Dismissal [7]";
                    sNext = "82: Cast Spell: Dismissal [12]";
                    break;
                case 82: // int IP_CONST_CASTSPELL_DISMISSAL_12                     = 82:
                    sLast = "81: Cast Spell: Dismissal [7]";
                    sSelected = "82: Cast Spell: Dismissal [12]";
                    sNext = "83: Cast Spell: Dismissal [18]";
                    break;
                case 83: // int IP_CONST_CASTSPELL_DISMISSAL_18                     = 83:
                    sLast = "82: Cast Spell: Dismissal [12]";
                    sSelected = "83: Cast Spell: Dismissal [18]";
                    sNext = "84: Cast Spell: Dispel Magic [5]";
                    break;
                case 84: // int IP_CONST_CASTSPELL_DISPEL_MAGIC_5                   = 84:
                    sLast = "83: Cast Spell: Dismissal [18]";
                    sSelected = "84: Cast Spell: Dispel Magic [5]";
                    sNext = "85: Cast Spell: Dispel Magic [10]";
                    break;
                case 85: // int IP_CONST_CASTSPELL_DISPEL_MAGIC_10                  = 85:
                    sLast = "84: Cast Spell: Dispel Magic [5]";
                    sSelected = "85: Cast Spell: Dispel Magic [10]";
                    sNext = "86: Cast Spell: Divine Power [7]";
                    break;
                case 86: // int IP_CONST_CASTSPELL_DIVINE_POWER_7                   = 86:
                    sLast = "85: Cast Spell: Dispel Magic [10]";
                    sSelected = "86: Cast Spell: Divine Power [7]";
                    sNext = "87: Cast Spell: Dominate Animal [5]";
                    break;
                case 87: // int IP_CONST_CASTSPELL_DOMINATE_ANIMAL_5                = 87:
                    sLast = "86: Cast Spell: Divine Power [7]";
                    sSelected = "87: Cast Spell: Dominate Animal [5]";
                    sNext = "88: Cast Spell: Dominate Monster [17]";
                    break;
                case 88: // int IP_CONST_CASTSPELL_DOMINATE_MONSTER_17              = 88:
                    sLast = "87: Cast Spell: Dominate Animal [5]";
                    sSelected = "88: Cast Spell: Dominate Monster [17]";
                    sNext = "89: Cast Spell: Dominate Person [7]";
                    break;
                case 89: // int IP_CONST_CASTSPELL_DOMINATE_PERSON_7                = 89:
                    sLast = "88: Cast Spell: Dominate Monster [17]";
                    sSelected = "89: Cast Spell: Dominate Person [7]";
                    sNext = "90: Cast Spell: Doom [2]";
                    break;
                case 90: // int IP_CONST_CASTSPELL_DOOM_2                           = 90:
                    sLast = "89: Cast Spell: Dominate Person [7]";
                    sSelected = "90: Cast Spell: Doom [2]";
                    sNext = "91: Cast Spell: Doom [5]";
                    break;
                case 91: // int IP_CONST_CASTSPELL_DOOM_5                           = 91:
                    sLast = "90: Cast Spell: Doom [2]";
                    sSelected = "91: Cast Spell: Doom [5]";
                    sNext = "92: Cast Spell: Elemental Shield [7]";
                    break;
                case 92: // int IP_CONST_CASTSPELL_ELEMENTAL_SHIELD_7               = 92:
                    sLast = "91: Cast Spell: Doom [5]";
                    sSelected = "92: Cast Spell: Elemental Shield [7]";
                    sNext = "93: Cast Spell: Elemental Shield [12]";
                    break;
                case 93: // int IP_CONST_CASTSPELL_ELEMENTAL_SHIELD_12              = 93:
                    sLast = "92: Cast Spell: Elemental Shield [7]";
                    sSelected = "93: Cast Spell: Elemental Shield [12]";
                    sNext = "94: Cast Spell: Elemental Swarm [17]";
                    break;
                case 94: // int IP_CONST_CASTSPELL_ELEMENTAL_SWARM_17               = 94:
                    sLast = "93: Cast Spell: Elemental Shield [12]";
                    sSelected = "94: Cast Spell: Elemental Swarm [17]";
                    sNext = "95: Cast Spell: Endurance [3]";
                    break;
                case 95: // int IP_CONST_CASTSPELL_ENDURANCE_3                      = 95:
                    sLast = "94: Cast Spell: Elemental Swarm [17]";
                    sSelected = "95: Cast Spell: Endurance [3]";
                    sNext = "96: Cast Spell: Endurance [10]";
                    break;
                case 96: // int IP_CONST_CASTSPELL_ENDURANCE_10                     = 96:
                    sLast = "95: Cast Spell: Endurance [3]";
                    sSelected = "96: Cast Spell: Endurance [10]";
                    sNext = "97: Cast Spell: Endurance [15]";
                    break;
                case 97: // int IP_CONST_CASTSPELL_ENDURANCE_15                     = 97:
                    sLast = "96: Cast Spell: Endurance [10]";
                    sSelected = "97: Cast Spell: Endurance [15]";
                    sNext = "98: Cast Spell: Endure Elements [2]";
                    break;
                case 98: // int IP_CONST_CASTSPELL_ENDURE_ELEMENTS_2                = 98:
                    sLast = "97: Cast Spell: Endurance [15]";
                    sSelected = "98: Cast Spell: Endure Elements [2]";
                    sNext = "99: Cast Spell: Energy Drain [17]";
                    break;
                case 99: // int IP_CONST_CASTSPELL_ENERGY_DRAIN_17                  = 99:
                    sLast = "98: Cast Spell: Endure Elements [2]";
                    sSelected = "99: Cast Spell: Energy Drain [17]";
                    sNext = "100: Cast Spell: Enervation [7]";
                    break;
                case 100: // int IP_CONST_CASTSPELL_ENERVATION_7                     = 100:
                    sLast = "99: Cast Spell: Energy Drain [17]";
                    sSelected = "100: Cast Spell: Enervation [7]";
                    sNext = "101: Cast Spell: Entangle [2]";
                    break;
                case 101: // int IP_CONST_CASTSPELL_ENTANGLE_2                       = 101:
                    sLast = "100: Cast Spell: Enervation [7]";
                    sSelected = "101: Cast Spell: Entangle [2]";
                    sNext = "102: Cast Spell: Entangle [5]";
                    break;
                case 102: // int IP_CONST_CASTSPELL_ENTANGLE_5                       = 102:
                    sLast = "101: Cast Spell: Entangle [2]";
                    sSelected = "102: Cast Spell: Entangle [5]";
                    sNext = "103: Cast Spell: Fear [5]";
                    break;
                case 103: // int IP_CONST_CASTSPELL_FEAR_5                           = 103:
                    sLast = "102: Cast Spell: Entangle [5]";
                    sSelected = "103: Cast Spell: Fear [5]";
                    sNext = "104: Cast Spell: Feeblemind [9]";
                    break;
                case 104: // int IP_CONST_CASTSPELL_FEEBLEMIND_9                     = 104:
                    sLast = "103: Cast Spell: Fear [5]";
                    sSelected = "104: Cast Spell: Feeblemind [9]";
                    sNext = "105: Cast Spell: Finger of Death [13]";
                    break;
                case 105: // int IP_CONST_CASTSPELL_FINGER_OF_DEATH_13               = 105:
                    sLast = "104: Cast Spell: Feeblemind [9]";
                    sSelected = "105: Cast Spell: Finger of Death [13]";
                    sNext = "106: Cast Spell: Fire Storm [13]";
                    break;
                case 106: // int IP_CONST_CASTSPELL_FIRE_STORM_13                    = 106:
                    sLast = "105: Cast Spell: Finger of Death [13]";
                    sSelected = "106: Cast Spell: Fire Storm [13]";
                    sNext = "107: Cast Spell: Fire Storm [18]";
                    break;
                case 107: // int IP_CONST_CASTSPELL_FIRE_STORM_18                    = 107:
                    sLast = "106: Cast Spell: Fire Storm [13]";
                    sSelected = "107: Cast Spell: Fire Storm [18]";
                    sNext = "108: Cast Spell: Fireball [5]";
                    break;
                case 108: // int IP_CONST_CASTSPELL_FIREBALL_5                       = 108:
                    sLast = "107: Cast Spell: Fire Storm [18]";
                    sSelected = "108: Cast Spell: Fireball [5]";
                    sNext = "109: Cast Spell: Fireball [10]";
                    break;
                case 109: // int IP_CONST_CASTSPELL_FIREBALL_10                      = 109:
                    sLast = "108: Cast Spell: Fireball [5]";
                    sSelected = "109: Cast Spell: Fireball [10]";
                    sNext = "110: Cast Spell: Flame Arrow [5]";
                    break;
                case 110: // int IP_CONST_CASTSPELL_FLAME_ARROW_5                    = 110:
                    sLast = "109: Cast Spell: Fireball [10]";
                    sSelected = "110: Cast Spell: Flame Arrow [5]";
                    sNext = "111: Cast Spell: Flame Arrow [12]";
                    break;
                case 111: // int IP_CONST_CASTSPELL_FLAME_ARROW_12                   = 111:
                    sLast = "110: Cast Spell: Flame Arrow [5]";
                    sSelected = "111: Cast Spell: Flame Arrow [12]";
                    sNext = "112: Cast Spell: Flame Arrow [18]";
                    break;
                case 112: // int IP_CONST_CASTSPELL_FLAME_ARROW_18                   = 112:
                    sLast = "111: Cast Spell: Flame Arrow [12]";
                    sSelected = "112: Cast Spell: Flame Arrow [18]";
                    sNext = "113: Cast Spell: Flame Lash [3]";
                    break;
                case 113: // int IP_CONST_CASTSPELL_FLAME_LASH_3                     = 113:
                    sLast = "112: Cast Spell: Flame Arrow [18]";
                    sSelected = "113: Cast Spell: Flame Lash [3]";
                    sNext = "114: Cast Spell: Flame Lash [10]";
                    break;
                case 114: // int IP_CONST_CASTSPELL_FLAME_LASH_10                    = 114:
                    sLast = "113: Cast Spell: Flame Lash [3]";
                    sSelected = "114: Cast Spell: Flame Lash [10]";
                    sNext = "115: Cast Spell: Flame Strike [7]";
                    break;
                case 115: // int IP_CONST_CASTSPELL_FLAME_STRIKE_7                   = 115:
                    sLast = "114: Cast Spell: Flame Lash [10]";
                    sSelected = "115: Cast Spell: Flame Strike [7]";
                    sNext = "116: Cast Spell: Flame Strike [12]";
                    break;
                case 116: // int IP_CONST_CASTSPELL_FLAME_STRIKE_12                  = 116:
                    sLast = "115: Cast Spell: Flame Strike [7]";
                    sSelected = "116: Cast Spell: Flame Strike [12]";
                    sNext = "117: Cast Spell: Flame Strike [18]";
                    break;
                case 117: // int IP_CONST_CASTSPELL_FLAME_STRIKE_18                  = 117:
                    sLast = "116: Cast Spell: Flame Strike [12]";
                    sSelected = "117: Cast Spell: Flame Strike [18]";
                    sNext = "118: Cast Spell: Freedom of Movement [7]";
                    break;
                case 118: // int IP_CONST_CASTSPELL_FREEDOM_OF_MOVEMENT_7            = 118:
                    sLast = "117: Cast Spell: Flame Strike [18]";
                    sSelected = "118: Cast Spell: Freedom of Movement [7]";
                    sNext = "119: Cast Spell: Gate [17]";
                    break;
                case 119: // int IP_CONST_CASTSPELL_GATE_17                          = 119:
                    sLast = "118: Cast Spell: Freedom of Movement [7]";
                    sSelected = "119: Cast Spell: Gate [17]";
                    sNext = "120: Cast Spell: Ghoul Touch [3]";
                    break;
                case 120: // int IP_CONST_CASTSPELL_GHOUL_TOUCH_3                    = 120:
                    sLast = "119: Cast Spell: Gate [17]";
                    sSelected = "120: Cast Spell: Ghoul Touch [3]";
                    sNext = "121: Cast Spell: Globe of Invulnerability [11]";
                    break;
                case 121: // int IP_CONST_CASTSPELL_GLOBE_OF_INVULNERABILITY_11      = 121:
                    sLast = "120: Cast Spell: Ghoul Touch [3]";
                    sSelected = "121: Cast Spell: Globe of Invulnerability [11]";
                    sNext = "122: Cast Spell: Grease [2]";
                    break;
                case 122: // int IP_CONST_CASTSPELL_GREASE_2                         = 122:
                    sLast = "121: Cast Spell: Globe of Invulnerability [11]";
                    sSelected = "122: Cast Spell: Grease [2]";
                    sNext = "123: Cast Spell: Greater Dispelling [7]";
                    break;
                case 123: // int IP_CONST_CASTSPELL_GREATER_DISPELLING_7             = 123:
                    sLast = "122: Cast Spell: Grease [2]";
                    sSelected = "123: Cast Spell: Greater Dispelling [7]";
                    sNext = "124: Cast Spell: Greater Dispelling [15]";
                    break;
                case 124: // int IP_CONST_CASTSPELL_GREATER_DISPELLING_15            = 124:
                    sLast = "123: Cast Spell: Greater Dispelling [7]";
                    sSelected = "124: Cast Spell: Greater Dispelling [15]";
                    sNext = "125: <No Spell>";
                    break;
                case 125:
                    sLast = "124: Cast Spell: Greater Dispelling [15]";
                    sSelected = "125: <No Spell>";
                    sNext = "126: Cast Spell: Greater Planar Binding [15]";
                    break;
                case 126: // int IP_CONST_CASTSPELL_GREATER_PLANAR_BINDING_15        = 126:
                    sLast = "125: <No Spell>";
                    sSelected = "126: Cast Spell: Greater Planar Binding [15]";
                    sNext = "127: Cast Spell: Greater Restoration [13]";
                    break;
                case 127: // int IP_CONST_CASTSPELL_GREATER_RESTORATION_13           = 127:
                    sLast = "126: Cast Spell: Greater Planar Binding [15]";
                    sSelected = "127: Cast Spell: Greater Restoration [13]";
                    sNext = "128: Cast Spell: Greater Shadow Conjuration [9]";
                    break;
                case 128: // int IP_CONST_CASTSPELL_GREATER_SHADOW_CONJURATION_9     = 128:
                    sLast = "127: Cast Spell: Greater Restoration [13]";
                    sSelected = "128: Cast Spell: Greater Shadow Conjuration [9]";
                    sNext = "129: Cast Spell: Greater Spell Breach [11]";
                    break;
                case 129: // int IP_CONST_CASTSPELL_GREATER_SPELL_BREACH_11          = 129:
                    sLast = "128: Cast Spell: Greater Shadow Conjuration [9]";
                    sSelected = "129: Cast Spell: Greater Spell Breach [11]";
                    sNext = "130: Cast Spell: Greater Spell Mantle [17]";
                    break;
                case 130: // int IP_CONST_CASTSPELL_GREATER_SPELL_MANTLE_17          = 130:
                    sLast = "129: Cast Spell: Greater Spell Breach [11]";
                    sSelected = "130: Cast Spell: Greater Spell Mantle [17]";
                    sNext = "131: Cast Spell: Greater Stoneskin [11]";
                    break;
                case 131: // int IP_CONST_CASTSPELL_GREATER_STONESKIN_11             = 131:
                    sLast = "130: Cast Spell: Greater Spell Mantle [17]";
                    sSelected = "131: Cast Spell: Greater Stoneskin [11]";
                    sNext = "132: <No Spell>";
                    break;
                case 132:
                    sLast = "131: Cast Spell: Greater Stoneskin [11]";
                    sSelected = "132: <No Spell>";
                    sNext = "133: Cast Spell: Hammer of the Gods [7]";
                    break;
                case 133: // int IP_CONST_CASTSPELL_HAMMER_OF_THE_GODS_7             = 133:
                    sLast = "132: <No Spell>";
                    sSelected = "133: Cast Spell: Hammer of the Gods [7]";
                    sNext = "134: Cast Spell: Hammer of the Gods [12]";
                    break;
                case 134: // int IP_CONST_CASTSPELL_HAMMER_OF_THE_GODS_12            = 134:
                    sLast = "133: Cast Spell: Hammer of the Gods [7]";
                    sSelected = "134: Cast Spell: Hammer of the Gods [12]";
                    sNext = "135: <No Spell>";
                    break;
                case 135:
                    sLast = "134: Cast Spell: Hammer of the Gods [12]";
                    sSelected = "135: <No Spell>";
                    sNext = "136: Cast Spell: Harm [11]";
                    break;
                case 136: // int IP_CONST_CASTSPELL_HARM_11                          = 136:
                    sLast = "135: <No Spell>";
                    sSelected = "136: Cast Spell: Harm [11]";
                    sNext = "137: Cast Spell: Haste [5]";
                    break;
                case 137: // int IP_CONST_CASTSPELL_HASTE_5                          = 137:
                    sLast = "136: Cast Spell: Harm [11]";
                    sSelected = "137: Cast Spell: Haste [5]";
                    sNext = "138: Cast Spell: Haste [10]";
                    break;
                case 138: // int IP_CONST_CASTSPELL_HASTE_10                         = 138:
                    sLast = "137: Cast Spell: Haste [5]";
                    sSelected = "138: Cast Spell: Haste [10]";
                    sNext = "139: Cast Spell: Heal [11]";
                    break;
                case 139: // int IP_CONST_CASTSPELL_HEAL_11                          = 139:
                    sLast = "138: Cast Spell: Haste [10]";
                    sSelected = "139: Cast Spell: Heal [11]";
                    sNext = "140: Cast Spell: Healing Circle [9]";
                    break;
                case 140: // int IP_CONST_CASTSPELL_HEALING_CIRCLE_9                 = 140:
                    sLast = "139: Cast Spell: Heal [11]";
                    sSelected = "140: Cast Spell: Healing Circle [9]";
                    sNext = "141: Cast Spell: Healing Circle [16]";
                    break;
                case 141: // int IP_CONST_CASTSPELL_HEALING_CIRCLE_16                = 141:
                    sLast = "140: Cast Spell: Healing Circle [9]";
                    sSelected = "141: Cast Spell: Healing Circle [16]";
                    sNext = "142: Cast Spell: Hold Animal [2]";
                    break;
                case 142: // int IP_CONST_CASTSPELL_HOLD_ANIMAL_3                    = 142:
                    sLast = "141: Cast Spell: Healing Circle [16]";
                    sSelected = "142: Cast Spell: Hold Animal [2]";
                    sNext = "143: Cast Spell: Hold Monster [7]";
                    break;
                case 143: // int IP_CONST_CASTSPELL_HOLD_MONSTER_7                   = 143:
                    sLast = "142: Cast Spell: Hold Animal [2]";
                    sSelected = "143: Cast Spell: Hold Monster [7]";
                    sNext = "144: Cast Spell: Hold Person [3]";
                    break;
                case 144: // int IP_CONST_CASTSPELL_HOLD_PERSON_3                    = 144:
                    sLast = "143: Cast Spell: Hold Monster [7]";
                    sSelected = "144: Cast Spell: Hold Person [3]";
                    sNext = "145: <No Spell>";
                    break;
                case 145:
                    sLast = "144: Cast Spell: Hold Person [3]";
                    sSelected = "145: <No Spell>";
                    sNext = "146: <No Spell>";
                    break;
                case 146:
                    sLast = "145: <No Spell>";
                    sSelected = "146: <No Spell>";
                    sNext = "147: Cast Spell: Identify [3]";
                    break;
                case 147: // int IP_CONST_CASTSPELL_IDENTIFY_3                       = 147:
                    sLast = "146: <No Spell>";
                    sSelected = "147: Cast Spell: Identify [3]";
                    sNext = "148: Cast Spell: Implosion [17]";
                    break;
                case 148: // int IP_CONST_CASTSPELL_IMPLOSION_17                     = 148:
                    sLast = "147: Cast Spell: Identify [3]";
                    sSelected = "148: Cast Spell: Implosion [17]";
                    sNext = "149: Cast Spell: Improved Invisibility [7]";
                    break;
                case 149: // int IP_CONST_CASTSPELL_IMPROVED_INVISIBILITY_7          = 149:
                    sLast = "148: Cast Spell: Implosion [17]";
                    sSelected = "149: Cast Spell: Improved Invisibility [7]";
                    sNext = "150: Cast Spell: Incendiary Cloud [15]";
                    break;
                case 150: // int IP_CONST_CASTSPELL_INCENDIARY_CLOUD_15              = 150:
                    sLast = "149: Cast Spell: Improved Invisibility [7]";
                    sSelected = "150: Cast Spell: Incendiary Cloud [15]";
                    sNext = "151: Cast Spell: Invisibility [3]";
                    break;
                case 151: // int IP_CONST_CASTSPELL_INVISIBILITY_3                   = 151:
                    sLast = "150: Cast Spell: Incendiary Cloud [15]";
                    sSelected = "151: Cast Spell: Invisibility [3]";
                    sNext = "152: Cast Spell: Invisibility Purge [5]";
                    break;
                case 152: // int IP_CONST_CASTSPELL_INVISIBILITY_PURGE_5             = 152:
                    sLast = "151: Cast Spell: Invisibility [3]";
                    sSelected = "152: Cast Spell: Invisibility Purge [5]";
                    sNext = "153: Cast Spell: Invisibility Sphere [5]";
                    break;
                case 153: // int IP_CONST_CASTSPELL_INVISIBILITY_SPHERE_5            = 153:
                    sLast = "152: Cast Spell: Invisibility Purge [5]";
                    sSelected = "153: Cast Spell: Invisibility Sphere [5]";
                    sNext = "154: Cast Spell: Knock [3]";
                    break;
                case 154: // int IP_CONST_CASTSPELL_KNOCK_3                          = 154:
                    sLast = "153: Cast Spell: Invisibility Sphere [5]";
                    sSelected = "154: Cast Spell: Knock [3]";
                    sNext = "155: Cast Spell: Lesser Dispel [3]";
                    break;
                case 155: // int IP_CONST_CASTSPELL_LESSER_DISPEL_3                  = 155:
                    sLast = "154: Cast Spell: Knock [3]";
                    sSelected = "155: Cast Spell: Lesser Dispel [3]";
                    sNext = "156: Cast Spell: Lesser Dispel [5]";
                    break;
                case 156: // int IP_CONST_CASTSPELL_LESSER_DISPEL_5                  = 156:
                    sLast = "155: Cast Spell: Lesser Dispel [3]";
                    sSelected = "156: Cast Spell: Lesser Dispel [5]";
                    sNext = "157: Cast Spell: Lesser Mind Blank [9]";
                    break;
                case 157: // int IP_CONST_CASTSPELL_LESSER_MIND_BLANK_9              = 157:
                    sLast = "156: Cast Spell: Lesser Dispel [5]";
                    sSelected = "157: Cast Spell: Lesser Mind Blank [9]";
                    sNext = "158: Cast Spell: Lesser Planar Binding [9]";
                    break;
                case 158: // int IP_CONST_CASTSPELL_LESSER_PLANAR_BINDING_9          = 158:
                    sLast = "157: Cast Spell: Lesser Mind Blank [9]";
                    sSelected = "158: Cast Spell: Lesser Planar Binding [9]";
                    sNext = "159: Cast Spell: Lesser Restoration [3]";
                    break;
                case 159: // int IP_CONST_CASTSPELL_LESSER_RESTORATION_3             = 159:
                    sLast = "158: Cast Spell: Lesser Planar Binding [9]";
                    sSelected = "159: Cast Spell: Lesser Restoration [3]";
                    sNext = "160: Cast Spell: Lesser Spell Breach [7]";
                    break;
                case 160: // int IP_CONST_CASTSPELL_LESSER_SPELL_BREACH_7            = 160:
                    sLast = "159: Cast Spell: Lesser Restoration [3]";
                    sSelected = "160: Cast Spell: Lesser Spell Breach [7]";
                    sNext = "161: Cast Spell: Lesser Spell Mantle [9]";
                    break;
                case 161: // int IP_CONST_CASTSPELL_LESSER_SPELL_MANTLE_9            = 161:
                    sLast = "160: Cast Spell: Lesser Spell Breach [7]";
                    sSelected = "161: Cast Spell: Lesser Spell Mantle [9]";
                    sNext = "162: Cast Spell: Light [1]";
                    break;
                case 162: // int IP_CONST_CASTSPELL_LIGHT_1                          = 162:
                    sLast = "161: Cast Spell: Lesser Spell Mantle [9]";
                    sSelected = "162: Cast Spell: Light [1]";
                    sNext = "163: Cast Spell: Light [5]";
                    break;
                case 163: // int IP_CONST_CASTSPELL_LIGHT_5                          = 163:
                    sLast = "162: Cast Spell: Light [1]";
                    sSelected = "163: Cast Spell: Light [5]";
                    sNext = "164: Cast Spell: Lightning Bolt [5]";
                    break;
                case 164: // int IP_CONST_CASTSPELL_LIGHTNING_BOLT_5                 = 164:
                    sLast = "163: Cast Spell: Light [5]";
                    sSelected = "164: Cast Spell: Lightning Bolt [5]";
                    sNext = "165: Cast Spell: Lightning Bolt [10]";
                    break;
                case 165: // int IP_CONST_CASTSPELL_LIGHTNING_BOLT_10                = 165:
                    sLast = "164: Cast Spell: Lightning Bolt [5]";
                    sSelected = "165: Cast Spell: Lightning Bolt [10]";
                    sNext = "166: <No Spell>";
                    break;
                case 166:
                    sLast = "165: Cast Spell: Lightning Bolt [10]";
                    sSelected = "166: <No Spell>";
                    sNext = "167: Cast Spell: Mage Armor [2]";
                    break;
                case 167: // int IP_CONST_CASTSPELL_MAGE_ARMOR_2                     = 167:
                    sLast = "166: <No Spell>";
                    sSelected = "167: Cast Spell: Mage Armor [2]";
                    sNext = "168: <No Spell>";
                    break;
                case 168:
                    sLast = "167: Cast Spell: Mage Armor [2]";
                    sSelected = "168: <No Spell>";
                    sNext = "169: <No Spell>";
                    break;
                case 169:
                    sLast = "168: <No Spell>";
                    sSelected = "169: <No Spell>";
                    sNext = "170: <No Spell>";
                    break;
                case 170:
                    sLast = "169: <No Spell>";
                    sSelected = "170: <No Spell>";
                    sNext = "171: <No Spell>";
                    break;
                case 171:
                    sLast = "170: <No Spell>";
                    sSelected = "171: <No Spell>";
                    sNext = "172: Cast Spell: Magic Missile [3]";
                    break;
                case 172: // int IP_CONST_CASTSPELL_MAGIC_MISSILE_3                  = 172:
                    sLast = "168: <No Spell>";
                    sSelected = "172: Cast Spell: Magic Missile [3]";
                    sNext = "173: Cast Spell: Magic Missile [5]";
                    break;
                case 173: // int IP_CONST_CASTSPELL_MAGIC_MISSILE_5                  = 173:
                    sLast = "172: Cast Spell: Magic Missile [3]";
                    sSelected = "173: Cast Spell: Magic Missile [5]";
                    sNext = "174: Cast Spell: Magic Missile [9]";
                    break;
                case 174: // int IP_CONST_CASTSPELL_MAGIC_MISSILE_9                  = 174:
                    sLast = "173: Cast Spell: Magic Missile [5]";
                    sSelected = "174: Cast Spell: Magic Missile [9]";
                    sNext = "175: <No Spell>";
                    break;
                case 175:
                    sLast = "174: Cast Spell: Magic Missile [9]";
                    sSelected = "175: <No Spell>";
                    sNext = "176: <No Spell>";
                    break;
                case 176:
                    sLast = "175: <No Spell>";
                    sSelected = "176: <No Spell>";
                    sNext = "177: <No Spell>";
                    break;
                case 177:
                    sLast = "176: <No Spell>";
                    sSelected = "177: <No Spell>";
                    sNext = "178: <No Spell>";
                    break;
                case 178:
                    sLast = "177: <No Spell>";
                    sSelected = "178: <No Spell>";
                    sNext = "179: Cast Spell: Mass Blindness/Deafness [15]";
                    break;
                case 179: // int IP_CONST_CASTSPELL_MASS_BLINDNESS_DEAFNESS_15       = 179:
                    sLast = "178: <No Spell>";
                    sSelected = "179: Cast Spell: Mass Blindness/Deafness [15]";
                    sNext = "180: Cast Spell: Mass Charm [15]";
                    break;
                case 180: // int IP_CONST_CASTSPELL_MASS_CHARM_15                    = 180:
                    sLast = "179: Cast Spell: Mass Blindness/Deafness [15]";
                    sSelected = "180: Cast Spell: Mass Charm [15]";
                    sNext = "181: <No Spell>";
                    break;
                case 181:
                    sLast = "180: Cast Spell: Mass Charm [15]";
                    sSelected = "181: <No Spell>";
                    sNext = "182: Cast Spell: Mass Haste [11]";
                    break;
                case 182: // int IP_CONST_CASTSPELL_MASS_HASTE_11                    = 182:
                    sLast = "181: <No Spell>";
                    sSelected = "182: Cast Spell: Mass Haste [11]";
                    sNext = "183: Cast Spell: Mass Haste [15]";
                    break;
                case 183: // int IP_CONST_CASTSPELL_MASS_HEAL_15                     = 183:
                    sLast = "182: Cast Spell: Mass Haste [11]";
                    sSelected = "183: Cast Spell: Mass Haste [15]";
                    sNext = "184: Cast Spell: Melf's Acid Arrow [3]";
                    break;
                case 184: // int IP_CONST_CASTSPELL_MELFS_ACID_ARROW_3               = 184:
                    sLast = "183: Cast Spell: Mass Haste [15]";
                    sSelected = "184: Cast Spell: Melf's Acid Arrow [3]";
                    sNext = "185: Cast Spell: Melf's Acid Arrow [6]";
                    break;
                case 185: // int IP_CONST_CASTSPELL_MELFS_ACID_ARROW_6               = 185:
                    sLast = "184: Cast Spell: Melf's Acid Arrow [3]";
                    sSelected = "185: Cast Spell: Melf's Acid Arrow [6]";
                    sNext = "186: Cast Spell: Melf's Acid Arrow [9]";
                    break;
                case 186: // int IP_CONST_CASTSPELL_MELFS_ACID_ARROW_9               = 186:
                    sLast = "185: Cast Spell: Melf's Acid Arrow [6]";
                    sSelected = "186: Cast Spell: Melf's Acid Arrow [9]";
                    sNext = "187: Cast Spell: Meteor Swarm [17]";
                    break;
                case 187: // int IP_CONST_CASTSPELL_METEOR_SWARM_17                  = 187:
                    sLast = "186: Cast Spell: Melf's Acid Arrow [9]";
                    sSelected = "187: Cast Spell: Meteor Swarm [17]";
                    sNext = "188: Cast Spell: Mind Blank [15]";
                    break;
                case 188: // int IP_CONST_CASTSPELL_MIND_BLANK_15                    = 188:
                    sLast = "187: Cast Spell: Meteor Swarm [17]";
                    sSelected = "188: Cast Spell: Mind Blank [15]";
                    sNext = "189: Cast Spell: Mind Fog [9]";
                    break;
                case 189: // int IP_CONST_CASTSPELL_MIND_FOG_9                       = 189:
                    sLast = "188: Cast Spell: Mind Blank [15]";
                    sSelected = "189: Cast Spell: Mind Fog [9]";
                    sNext = "190: Cast Spell: Minor Globe of Invulnerability [7]";
                    break;
                case 190: // int IP_CONST_CASTSPELL_MINOR_GLOBE_OF_INVULNERABILITY_7 = 190:
                    sLast = "189: Cast Spell: Mind Fog [9]";
                    sSelected = "190: Cast Spell: Minor Globe of Invulnerability [7]";
                    sNext = "191: Cast Spell: Minor Globe of Invulnerability [15]";
                    break;
                case 191: // int IP_CONST_CASTSPELL_MINOR_GLOBE_OF_INVULNERABILITY_15 = 191:
                    sLast = "190: Cast Spell: Minor Globe of Invulnerability [7]";
                    sSelected = "191: Cast Spell: Minor Globe of Invulnerability [15]";
                    sNext = "192: Cast Spell: Ghostly Visage [3]";
                    break;
                case 192: // int IP_CONST_CASTSPELL_GHOSTLY_VISAGE_3                 = 192:
                    sLast = "191: Cast Spell: Minor Globe of Invulnerability [15]";
                    sSelected = "192: Cast Spell: Ghostly Visage [3]";
                    sNext = "193: Cast Spell: Ghostly Visage [9]";
                    break;
                case 193: // int IP_CONST_CASTSPELL_GHOSTLY_VISAGE_9                 = 193:
                    sLast = "192: Cast Spell: Ghostly Visage [3]";
                    sSelected = "193: Cast Spell: Ghostly Visage [9]";
                    sNext = "194: Cast Spell: Ghostly Visage [15]";
                    break;
                case 194: // int IP_CONST_CASTSPELL_GHOSTLY_VISAGE_15                = 194:
                    sLast = "193: Cast Spell: Ghostly Visage [9]";
                    sSelected = "194: Cast Spell: Ghostly Visage [15]";
                    sNext = "195: Cast Spell: Etheral Visage [9]";
                    break;
                case 195: // int IP_CONST_CASTSPELL_ETHEREAL_VISAGE_9                = 195:
                    sLast = "194: Cast Spell: Ghostly Visage [15]";
                    sSelected = "195: Cast Spell: Etheral Visage [9]";
                    sNext = "196: Cast Spell: Etheral Visage [15]";
                    break;
                case 196: // int IP_CONST_CASTSPELL_ETHEREAL_VISAGE_15               = 196:
                    sLast = "195: Cast Spell: Etheral Visage [9]";
                    sSelected = "196: Cast Spell: Etheral Visage [15]";
                    sNext = "197: Cast Spell: Mordenkainens Disjunktion [17]";
                    break;
                case 197: // int IP_CONST_CASTSPELL_MORDENKAINENS_DISJUNCTION_17     = 197:
                    sLast = "196: Cast Spell: Etheral Visage [15]";
                    sSelected = "197: Cast Spell: Mordenkainens Disjunktion [17]";
                    sNext = "198: Cast Spell: Mordenkainens Sword [13]";
                    break;
                case 198: // int IP_CONST_CASTSPELL_MORDENKAINENS_SWORD_13           = 198:
                    sLast = "197: Cast Spell: Mordenkainens Disjunktion [17]";
                    sSelected = "198: Cast Spell: Mordenkainens Sword [13]";
                    sNext = "199: Cast Spell: Mordenkainens Sword [18]";
                    break;
                case 199: // int IP_CONST_CASTSPELL_MORDENKAINENS_SWORD_18           = 199:
                    sLast = "198: Cast Spell: Mordenkainens Sword [13]";
                    sSelected = "199: Cast Spell: Mordenkainens Sword [18]";
                    sNext = "200: Cast Spell: Natures Balance [15]";
                    break;
                case 200: // int IP_CONST_CASTSPELL_NATURES_BALANCE_15               = 200:
                    sLast = "199: Cast Spell: Mordenkainens Sword [18]";
                    sSelected = "200: Cast Spell: Natures Balance [15]";
                    sNext = "201: Cast Spell: Negative Energy Protection [5]";
                    break;
                case 201: // int IP_CONST_CASTSPELL_NEGATIVE_ENERGY_PROTECTION_5     = 201:
                    sLast = "200: Cast Spell: Natures Balance [15]";
                    sSelected = "201: Cast Spell: Negative Energy Protection [5]";
                    sNext = "202: Cast Spell: Negative Energy Protection [10]";
                    break;
                case 202: // int IP_CONST_CASTSPELL_NEGATIVE_ENERGY_PROTECTION_10    = 202:
                    sLast = "201: Cast Spell: Negative Energy Protection [5]";
                    sSelected = "202: Cast Spell: Negative Energy Protection [10]";
                    sNext = "203: Cast Spell: Negative Energy Protection [15]";
                    break;
                case 203: // int IP_CONST_CASTSPELL_NEGATIVE_ENERGY_PROTECTION_15    = 203:
                    sLast = "202: Cast Spell: Negative Energy Protection [10]";
                    sSelected = "203: Cast Spell: Negative Energy Protection [15]";
                    sNext = "204: Cast Spell: Neutralize Poison [5]";
                    break;
                case 204: // int IP_CONST_CASTSPELL_NEUTRALIZE_POISON_5              = 204:
                    sLast = "203: Cast Spell: Negative Energy Protection [15]";
                    sSelected = "204: Cast Spell: Neutralize Poison [5]";
                    sNext = "205: Cast Spell: Phantasmal Killer [7]";
                    break;
                case 205: // int IP_CONST_CASTSPELL_PHANTASMAL_KILLER_7              = 205:
                    sLast = "204: Cast Spell: Neutralize Poison [5]";
                    sSelected = "205: Cast Spell: Phantasmal Killer [7]";
                    sNext = "206: Cast Spell: Planar Binding [11]";
                    break;
                case 206: // int IP_CONST_CASTSPELL_PLANAR_BINDING_11                = 206:
                    sLast = "205: Cast Spell: Phantasmal Killer [7]";
                    sSelected = "206: Cast Spell: Planar Binding [11]";
                    sNext = "207: Cast Spell: Poison [5]";
                    break;
                case 207: // int IP_CONST_CASTSPELL_POISON_5                         = 207:
                    sLast = "206: Cast Spell: Planar Binding [11]";
                    sSelected = "207: Cast Spell: Poison [5]";
                    sNext = "208: Cast Spell: Polymorph Self [7]";
                    break;
                case 208: // int IP_CONST_CASTSPELL_POLYMORPH_SELF_7                 = 208:
                    sLast = "207: Cast Spell: Poison [5]";
                    sSelected = "208: Cast Spell: Polymorph Self [7]";
                    sNext = "209: Cast Spell: Power Word Kill [17]";
                    break;
                case 209: // int IP_CONST_CASTSPELL_POWER_WORD_KILL_17               = 209:
                    sLast = "208: Cast Spell: Polymorph Self [7]";
                    sSelected = "209: Cast Spell: Power Word Kill [17]";
                    sNext = "210: Cast Spell: Power Word Stun [13]";
                    break;
                case 210: // int IP_CONST_CASTSPELL_POWER_WORD_STUN_13               = 210:
                    sLast = "209: Cast Spell: Power Word Kill [17]";
                    sSelected = "210: Cast Spell: Power Word Stun [13]";
                    sNext = "211: Cast Spell: Prayer [5]";
                    break;
                case 211: // int IP_CONST_CASTSPELL_PRAYER_5                         = 211:
                    sLast = "210: Cast Spell: Power Word Stun [13]";
                    sSelected = "211: Cast Spell: Prayer [5]";
                    sNext = "212: Cast Spell: Premonition [15]";
                    break;
                case 212: // int IP_CONST_CASTSPELL_PREMONITION_15                   = 212:
                    sLast = "211: Cast Spell: Prayer [5]";
                    sSelected = "212: Cast Spell: Premonition [15]";
                    sNext = "213: Cast Spell: Prismatic Spray [13]";
                    break;
                case 213: // int IP_CONST_CASTSPELL_PRISMATIC_SPRAY_13               = 213:
                    sLast = "212: Cast Spell: Premonition [15]";
                    sSelected = "213: Cast Spell: Prismatic Spray [13]";
                    sNext = "216: Cast Spell: Protection From Elements [3]";
                    break;
                case 216: // int IP_CONST_CASTSPELL_PROTECTION_FROM_ELEMENTS_3       = 216:
                    sLast = "213: Cast Spell: Prismatic Spray [13]";
                    sSelected = "216: Cast Spell: Protection From Elements [3]";
                    sNext = "217: Cast Spell: Protection From Elements [10]";
                    break;
                case 217: // int IP_CONST_CASTSPELL_PROTECTION_FROM_ELEMENTS_10      = 217:
                    sLast = "216: Cast Spell: Protection From Elements [3]";
                    sSelected = "217: Cast Spell: Protection From Elements [10]";
                    sNext = "218: <No Spell>";
                    break;
                case 218:
                    sLast = "217: Cast Spell: Protection From Elements [10]";
                    sSelected = "218: <No Spell>";
                    sNext = "219: <No Spell>";
                    break;
                case 219:
                    sLast = "218: <No Spell>";
                    sSelected = "219: <No Spell>";
                    sNext = "220: <No Spell>";
                    break;
                case 220:
                    sLast = "219: <No Spell>";
                    sSelected = "220: <No Spell>";
                    sNext = "221: <No Spell>";
                    break;
                case 221:
                    sLast = "220: <No Spell>";
                    sSelected = "221: <No Spell>";
                    sNext = "222: <No Spell>";
                    break;
                case 222:
                    sLast = "221: <No Spell>";
                    sSelected = "222: <No Spell>";
                    sNext = "223: <No Spell>";
                    break;
                case 223:
                    sLast = "222: <No Spell>";
                    sSelected = "223: <No Spell>";
                    sNext = "224: Cast Spell: Protection From Spells [13]";
                    break;
                case 224: // int IP_CONST_CASTSPELL_PROTECTION_FROM_SPELLS_13        = 224:
                    sLast = "223: <No Spell>";
                    sSelected = "224: Cast Spell: Protection From Spells [13]";
                    sNext = "225: Cast Spell: Protection From Spells [20]";
                    break;
                case 225: // int IP_CONST_CASTSPELL_PROTECTION_FROM_SPELLS_20        = 225:
                    sLast = "224: Cast Spell: Protection From Spells [13]";
                    sSelected = "225: Cast Spell: Protection From Spells [20]";
                    sNext = "226: Cast Spell: Raise Dead [9]";
                    break;
                case 226: // int IP_CONST_CASTSPELL_RAISE_DEAD_9                     = 226:
                    sLast = "225: Cast Spell: Protection From Spells [20]";
                    sSelected = "226: Cast Spell: Raise Dead [9]";
                    sNext = "227: Cast Spell: Ray of Enfeeblement [2]";
                    break;
                case 227: // int IP_CONST_CASTSPELL_RAY_OF_ENFEEBLEMENT_2            = 227:
                    sLast = "226: Cast Spell: Raise Dead [9]";
                    sSelected = "227: Cast Spell: Ray of Enfeeblement [2]";
                    sNext = "228: Cast Spell: Ray of Frost [1]";
                    break;
                case 228: // int IP_CONST_CASTSPELL_RAY_OF_FROST_1                   = 228:
                    sLast = "227: Cast Spell: Ray of Enfeeblement [2]";
                    sSelected = "228: Cast Spell: Ray of Frost [1]";
                    sNext = "229: Cast Spell: Remove Blindness/Deafness [5]";
                    break;
                case 229: // int IP_CONST_CASTSPELL_REMOVE_BLINDNESS_DEAFNESS_5      = 229:
                    sLast = "228: Cast Spell: Ray of Frost [1]";
                    sSelected = "229: Cast Spell: Remove Blindness/Deafness [5]";
                    sNext = "230: Cast Spell: Remove Curse [5]";
                    break;
                case 230: // int IP_CONST_CASTSPELL_REMOVE_CURSE_5                   = 230:
                    sLast = "229: Cast Spell: Remove Blindness/Deafness [5]";
                    sSelected = "230: Cast Spell: Remove Curse [5]";
                    sNext = "231: Cast Spell: Remove Disease [5]";
                    break;
                case 231: // int IP_CONST_CASTSPELL_REMOVE_DISEASE_5                 = 231:
                    sLast = "230: Cast Spell: Remove Curse [5]";
                    sSelected = "231: Cast Spell: Remove Disease [5]";
                    sNext = "232: Cast Spell: Remove Fear [2]";
                    break;
                case 232: // int IP_CONST_CASTSPELL_REMOVE_FEAR_2                    = 232:
                    sLast = "231: Cast Spell: Remove Disease [5]";
                    sSelected = "232: Cast Spell: Remove Fear [2]";
                    sNext = "233: Cast Spell: Remove Paralysis [3]";
                    break;
                case 233: // int IP_CONST_CASTSPELL_REMOVE_PARALYSIS_3               = 233:
                    sLast = "232: Cast Spell: Remove Fear [2]";
                    sSelected = "233: Cast Spell: Remove Paralysis [3]";
                    sNext = "234: Cast Spell: Resist Elements [3]";
                    break;
                case 234: // int IP_CONST_CASTSPELL_RESIST_ELEMENTS_3                = 234:
                    sLast = "233: Cast Spell: Remove Paralysis [3]";
                    sSelected = "234: Cast Spell: Resist Elements [3]";
                    sNext = "235: Cast Spell: Resist Elements [10]";
                    break;
                case 235: // int IP_CONST_CASTSPELL_RESIST_ELEMENTS_10               = 235:
                    sLast = "234: Cast Spell: Resist Elements [3]";
                    sSelected = "235: Cast Spell: Resist Elements [10]";
                    sNext = "236: Cast Spell: Resistance [2]";
                    break;
                case 236: // int IP_CONST_CASTSPELL_RESISTANCE_2                     = 236:
                    sLast = "235: Cast Spell: Resist Elements [10]";
                    sSelected = "236: Cast Spell: Resistance [2]";
                    sNext = "237: Cast Spell: Resistance [5]";
                    break;
                case 237: // int IP_CONST_CASTSPELL_RESISTANCE_5                     = 237:
                    sLast = "236: Cast Spell: Resistance [2]";
                    sSelected = "237: Cast Spell: Resistance [5]";
                    sNext = "238: Cast Spell: Resistance [7]";
                    break;
                case 238: // int IP_CONST_CASTSPELL_RESTORATION_7                    = 238:
                    sLast = "237: Cast Spell: Resistance [5]";
                    sSelected = "238: Cast Spell: Resistance [7]";
                    sNext = "239: Cast Spell: Resurrection [13]";
                    break;
                case 239: // int IP_CONST_CASTSPELL_RESURRECTION_13                  = 239:
                    sLast = "238: Cast Spell: Resistance [7]";
                    sSelected = "239: Cast Spell: Resurrection [13]";
                    sNext = "240: Cast Spell: Sanctuary [2]";
                    break;
                case 240: // int IP_CONST_CASTSPELL_SANCTUARY_2                      = 240:
                    sLast = "239: Cast Spell: Resurrection [13]";
                    sSelected = "240: Cast Spell: Sanctuary [2]";
                    sNext = "241: Cast Spell: Scare [2]";
                    break;
                case 241: // int IP_CONST_CASTSPELL_SCARE_2                          = 241:
                    sLast = "240: Cast Spell: Sanctuary [2]";
                    sSelected = "241: Cast Spell: Scare [2]";
                    sNext = "242: Cast Spell: Searing Light [5]";
                    break;
                case 242: // int IP_CONST_CASTSPELL_SEARING_LIGHT_5                  = 242:
                    sLast = "241: Cast Spell: Scare [2]";
                    sSelected = "242: Cast Spell: Searing Light [5]";
                    sNext = "243: Cast Spell: Invisibility [3]";
                    break;
                case 243: // int IP_CONST_CASTSPELL_SEE_INVISIBILITY_3               = 243:
                    sLast = "242: Cast Spell: Searing Light [5]";
                    sSelected = "243: Cast Spell: Invisibility [3]";
                    sNext = "244: Cast Spell: Shades [11]";
                    break;
                case 244: // int IP_CONST_CASTSPELL_SHADES_11                        = 244:
                    sLast = "243: Cast Spell: Invisibility [3]";
                    sSelected = "244: Cast Spell: Shades [11]";
                    sNext = "245: Cast Spell: Shadow Conjuration [7]";
                    break;
                case 245: // int IP_CONST_CASTSPELL_SHADOW_CONJURATION_7             = 245:
                    sLast = "244: Cast Spell: Shades [11]";
                    sSelected = "245: Cast Spell: Shadow Conjuration [7]";
                    sNext = "246: Cast Spell: Shadow Shield [13]";
                    break;
                case 246: // int IP_CONST_CASTSPELL_SHADOW_SHIELD_13                 = 246:
                    sLast = "245: Cast Spell: Shadow Conjuration [7]";
                    sSelected = "246: Cast Spell: Shadow Shield [13]";
                    sNext = "247: Cast Spell: Shapechange [17]";
                    break;
                case 247: // int IP_CONST_CASTSPELL_SHAPECHANGE_17                   = 247:
                    sLast = "246: Cast Spell: Shadow Shield [13]";
                    sSelected = "247: Cast Spell: Shapechange [17]";
                    sNext = "248: <No Spell>";
                    break;
                case 248:
                    sLast = "247: Cast Spell: Shapechange [17]";
                    sSelected = "248: <No Spell>";
                    sNext = "249: Cast Spell: Silence [2]";
                    break;
                case 249: // int IP_CONST_CASTSPELL_SILENCE_3                        = 249:
                    sLast = "248: <No Spell>";
                    sSelected = "249: Cast Spell: Silence [2]";
                    sNext = "250: Cast Spell: Slay Living [9]";
                    break;
                case 250: // int IP_CONST_CASTSPELL_SLAY_LIVING_9                    = 250:
                    sLast = "249: Cast Spell: Silence [2]";
                    sSelected = "250: Cast Spell: Slay Living [9]";
                    sNext = "251: Cast Spell: Sleep [2]";
                    break;
                case 251: // int IP_CONST_CASTSPELL_SLEEP_2                          = 251:
                    sLast = "250: Cast Spell: Slay Living [9]";
                    sSelected = "251: Cast Spell: Sleep [2]";
                    sNext = "252: Cast Spell: Sleep [5]";
                    break;
                case 252: // int IP_CONST_CASTSPELL_SLEEP_5                          = 252:
                    sLast = "251: Cast Spell: Sleep [2]";
                    sSelected = "252: Cast Spell: Sleep [5]";
                    sNext = "253: Cast Spell: Slow [5]";
                    break;
                case 253: // int IP_CONST_CASTSPELL_SLOW_5                           = 253:
                    sLast = "252: Cast Spell: Sleep [5]";
                    sSelected = "253: Cast Spell: Slow [5]";
                    sNext = "254: Cast Spell: Sound  Burst [3]";
                    break;
                case 254: // int IP_CONST_CASTSPELL_SOUND_BURST_3                    = 254:
                    sLast = "253: Cast Spell: Slow [5]";
                    sSelected = "254: Cast Spell: Sound  Burst [3]";
                    sNext = "255: Cast Spell: Spell Resistance [9]";
                    break;
                case 255: // int IP_CONST_CASTSPELL_SPELL_RESISTANCE_9               = 255:
                    sLast = "254: Cast Spell: Sound  Burst [3]";
                    sSelected = "255: Cast Spell: Spell Resistance [9]";
                    sNext = "256: Cast Spell: Spell Resistance [15]";
                    break;
                case 256: // int IP_CONST_CASTSPELL_SPELL_RESISTANCE_15              = 256:
                    sLast = "255: Cast Spell: Spell Resistance [9]";
                    sSelected = "256: Cast Spell: Spell Resistance [15]";
                    sNext = "257: Cast Spell: Spell Mantle [13]";
                    break;
                case 257: // int IP_CONST_CASTSPELL_SPELL_MANTLE_13                  = 257:
                    sLast = "256: Cast Spell: Spell Resistance [15]";
                    sSelected = "257: Cast Spell: Spell Mantle [13]";
                    sNext = "258: <No Spell>";
                    break;
                case 258:
                    sLast = "257: Cast Spell: Spell Mantle [13]";
                    sSelected = "258: <No Spell>";
                    sNext = "259: Cast Spell: Stinking Cloud [5]";
                    break;
                case 259: // int IP_CONST_CASTSPELL_STINKING_CLOUD_5                 = 259:
                    sLast = "258: <No Spell>";
                    sSelected = "259: Cast Spell: Stinking Cloud [5]";
                    sNext = "260: Cast Spell: Stoneskin [7]";
                    break;
                case 260: // int IP_CONST_CASTSPELL_STONESKIN_7                      = 260:
                    sLast = "259: Cast Spell: Stinking Cloud [5]";
                    sSelected = "260: Cast Spell: Stoneskin [7]";
                    sNext = "261: Cast Spell: Storm of Vengeance [17]";
                    break;
                case 261: // int IP_CONST_CASTSPELL_STORM_OF_VENGEANCE_17            = 261:
                    sLast = "260: Cast Spell: Stoneskin [7]";
                    sSelected = "261: Cast Spell: Storm of Vengeance [17]";
                    sNext = "262: Cast Spell: Summon Creature I [2]";
                    break;
                case 262: // int IP_CONST_CASTSPELL_SUMMON_CREATURE_I_2              = 262:
                    sLast = "261: Cast Spell: Storm of Vengeance [17]";
                    sSelected = "262: Cast Spell: Summon Creature I [2]";
                    sNext = "263: Cast Spell: Summon Creature I [5]";
                    break;
                case 263: // int IP_CONST_CASTSPELL_SUMMON_CREATURE_I_5              = 263:
                    sLast = "262: Cast Spell: Summon Creature I [2]";
                    sSelected = "263: Cast Spell: Summon Creature I [5]";
                    sNext = "264: Cast Spell: Summon Creature II [3]";
                    break;
                case 264: // int IP_CONST_CASTSPELL_SUMMON_CREATURE_II_3             = 264:
                    sLast = "263: Cast Spell: Summon Creature I [5]";
                    sSelected = "264: Cast Spell: Summon Creature II [3]";
                    sNext = "265: Cast Spell: Summon Creature III [5]";
                    break;
                case 265: // int IP_CONST_CASTSPELL_SUMMON_CREATURE_III_5            = 265:
                    sLast = "264: Cast Spell: Summon Creature II [3]";
                    sSelected = "265: Cast Spell: Summon Creature III [5]";
                    sNext = "266: Cast Spell: Summon Creature IV [7]";
                    break;
                case 266: // int IP_CONST_CASTSPELL_SUMMON_CREATURE_IV_7             = 266:
                    sLast = "265: Cast Spell: Summon Creature III [5]";
                    sSelected = "266: Cast Spell: Summon Creature IV [7]";
                    sNext = "267: Cast Spell: Summon Creature IX [17]";
                    break;
                case 267: // int IP_CONST_CASTSPELL_SUMMON_CREATURE_IX_17            = 267:
                    sLast = "266: Cast Spell: Summon Creature IV [7]";
                    sSelected = "267: Cast Spell: Summon Creature IX [17]";
                    sNext = "268: Cast Spell: Summon Creature V [9]";
                    break;
                case 268: // int IP_CONST_CASTSPELL_SUMMON_CREATURE_V_9              = 268:
                    sLast = "267: Cast Spell: Summon Creature IX [17]";
                    sSelected = "268: Cast Spell: Summon Creature V [9]";
                    sNext = "269: Cast Spell: Summon Creature VI [11]";
                    break;
                case 269: // int IP_CONST_CASTSPELL_SUMMON_CREATURE_VI_11            = 269:
                    sLast = "268: Cast Spell: Summon Creature V [9]";
                    sSelected = "269: Cast Spell: Summon Creature VI [11]";
                    sNext = "270: Cast Spell: Summon Creature VII [13]";
                    break;
                case 270: // int IP_CONST_CASTSPELL_SUMMON_CREATURE_VII_13           = 270:
                    sLast = "269: Cast Spell: Summon Creature VI [11]";
                    sSelected = "270: Cast Spell: Summon Creature VII [13]";
                    sNext = "271: Cast Spell: Summon Creature VIII [15]";
                    break;
                case 271: // int IP_CONST_CASTSPELL_SUMMON_CREATURE_VIII_15          = 271:
                    sLast = "270: Cast Spell: Summon Creature VII [13]";
                    sSelected = "271: Cast Spell: Summon Creature VIII [15]";
                    sNext = "272: Cast Spell: Sunbeam [13]";
                    break;
                case 272: // int IP_CONST_CASTSPELL_SUNBEAM_13                       = 272:
                    sLast = "271: Cast Spell: Summon Creature VIII [15]";
                    sSelected = "272: Cast Spell: Sunbeam [13]";
                    sNext = "273: Cast Spell: Tenser Transformation [11]";
                    break;
                case 273: // int IP_CONST_CASTSPELL_TENSERS_TRANSFORMATION_11        = 273:
                    sLast = "272: Cast Spell: Sunbeam [13]";
                    sSelected = "273: Cast Spell: Tenser Transformation [11]";
                    sNext = "274: Cast Spell: Time Stop [17]";
                    break;
                case 274: // int IP_CONST_CASTSPELL_TIME_STOP_17                     = 274:
                    sLast = "273: Cast Spell: Tenser Transformation [11]";
                    sSelected = "274: Cast Spell: Time Stop [17]";
                    sNext = "275: Cast Spell: True Seeing [9]";
                    break;
                case 275: // int IP_CONST_CASTSPELL_TRUE_SEEING_9                    = 275:
                    sLast = "274: Cast Spell: Time Stop [17]";
                    sSelected = "275: Cast Spell: True Seeing [9]";
                    sNext = "277: Cast Spell: Vampiric Touch [5]";
                    break;
                case 277: // int IP_CONST_CASTSPELL_VAMPIRIC_TOUCH_5                 = 277:
                    sLast = "275: Cast Spell: True Seeing [9]";
                    sSelected = "277: Cast Spell: Vampiric Touch [5]";
                    sNext = "278: Cast Spell: Virtue [1]";
                    break;
                case 278: // int IP_CONST_CASTSPELL_VIRTUE_1                         = 278:
                    sLast = "277: Cast Spell: Vampiric Touch [5]";
                    sSelected = "278: Cast Spell: Virtue [1]";
                    sNext = "279: Cast Spell: Wail of the Banshee [17]";
                    break;
                case 279:// int IP_CONST_CASTSPELL_WAIL_OF_THE_BANSHEE_17           = 279:
                    sLast = "278: Cast Spell: Virtue [1]";
                    sSelected = "279: Cast Spell: Wail of the Banshee [17]";
                    sNext = "280: Cast Spell: Wall of Fire [9]";
                    break;
                case 280: // int IP_CONST_CASTSPELL_WALL_OF_FIRE_9                   = 280:
                    sLast = "279: Cast Spell: Wail of the Banshee [17]";
                    sSelected = "280: Cast Spell: Wall of Fire [9]";
                    sNext = "281: Cast Spell: Web [3]";
                    break;
                case 281: // int IP_CONST_CASTSPELL_WEB_3                            = 281:
                    sLast = "280: Cast Spell: Wall of Fire [9]";
                    sSelected = "281: Cast Spell: Web [3]";
                    sNext = "282: Cast Spell: Weird [17]";
                    break;
                case 282: // int IP_CONST_CASTSPELL_WEIRD_17                         = 282:
                    sLast = "281: Cast Spell: Web [3]";
                    sSelected = "282: Cast Spell: Weird [17]";
                    sNext = "283: Cast Spell: Word of Faith [13]";
                    break;
                case 283: // int IP_CONST_CASTSPELL_WORD_OF_FAITH_13                 = 283:
                    sLast = "282: Cast Spell: Weird [17]";
                    sSelected = "283: Cast Spell: Word of Faith [13]";
                    sNext = "284: Cast Spell: Protection From Alignment [2]";
                    break;
                case 284: // int IP_CONST_CASTSPELL_PROTECTION_FROM_ALIGNMENT_2      = 284:
                    sLast = "283: Cast Spell: Word of Faith [13]";
                    sSelected = "284: Cast Spell: Protection From Alignment [2]";
                    sNext = "285: Cast Spell: Protection From Alignment [5]";
                    break;
                case 285: // int IP_CONST_CASTSPELL_PROTECTION_FROM_ALIGNMENT_5      = 285:
                    sLast = "284: Cast Spell: Protection From Alignment [2]";
                    sSelected = "285: Cast Spell: Protection From Alignment [5]";
                    sNext = "286: Cast Spell: Magic Circle Against Alignment [5]";
                    break;
                case 286: // int IP_CONST_CASTSPELL_MAGIC_CIRCLE_AGAINST_ALIGNMENT_5 = 286:
                    sLast = "285: Cast Spell: Protection From Alignment [5]";
                    sSelected = "286: Cast Spell: Magic Circle Against Alignment [5]";
                    sNext = "287: Cast Spell: Aura Versus Alignment [15]";
                    break;
                case 287: // int IP_CONST_CASTSPELL_AURA_VERSUS_ALIGNMENT_15         = 287:
                    sLast = "286: Cast Spell: Magic Circle Against Alignment [5]";
                    sSelected = "287: Cast Spell: Aura Versus Alignment [15]";
                    sNext = "288: Cast Spell: Eagle Spledor [3]";
                    break;
                case 288:// int IP_CONST_CASTSPELL_EAGLE_SPLEDOR_3                  = 288:
                    sLast = "287: Cast Spell: Aura Versus Alignment [15]";
                    sSelected = "288: Cast Spell: Eagle Spledor [3]";
                    sNext = "289: Cast Spell: Eagle Spledor [10]";
                    break;
                case 289: // int IP_CONST_CASTSPELL_EAGLE_SPLEDOR_10                 = 289:
                    sLast = "288: Cast Spell: Eagle Spledor [3]";
                    sSelected = "289: Cast Spell: Eagle Spledor [10]";
                    sNext = "290: Cast Spell: Eagle Spledor [15]";
                    break;
                case 290: // int IP_CONST_CASTSPELL_EAGLE_SPLEDOR_15                 = 290:
                    sLast = "289: Cast Spell: Eagle Spledor [10]";
                    sSelected = "290: Cast Spell: Eagle Spledor [15]";
                    sNext = "291: Cast Spell: Owls Wisdom [3]";
                    break;
                case 291: // int IP_CONST_CASTSPELL_OWLS_WISDOM_3                    = 291:
                    sLast = "290: Cast Spell: Eagle Spledor [15]";
                    sSelected = "291: Cast Spell: Owls Wisdom [3]";
                    sNext = "292: Cast Spell: Owls Wisdom [10]";
                    break;
                case 292: // int IP_CONST_CASTSPELL_OWLS_WISDOM_10                   = 292:
                    sLast = "291: Cast Spell: Owls Wisdom [3]";
                    sSelected = "292: Cast Spell: Owls Wisdom [10]";
                    sNext = "293: Cast Spell: Owls Wisdom [15]";
                    break;
                case 293: // int IP_CONST_CASTSPELL_OWLS_WISDOM_15                   = 293:
                    sLast = "292: Cast Spell: Owls Wisdom [10]";
                    sSelected = "293: Cast Spell: Owls Wisdom [15]";
                    sNext = "294: Cast Spell: Foxs Cunning [3]";
                    break;
                case 294: // int IP_CONST_CASTSPELL_FOXS_CUNNING_3                   = 294:
                    sLast = "293: Cast Spell: Owls Wisdom [15]";
                    sSelected = "294: Cast Spell: Foxs Cunning [3]";
                    sNext = "295: Cast Spell: Foxs Cunning [10]";
                    break;
                case 295: // int IP_CONST_CASTSPELL_FOXS_CUNNING_10                  = 295:
                    sLast = "294: Cast Spell: Foxs Cunning [3]";
                    sSelected = "295: Cast Spell: Foxs Cunning [10]";
                    sNext = "296: Cast Spell: Foxs Cunning [15]";
                    break;
                case 296: // int IP_CONST_CASTSPELL_FOXS_CUNNING_15                  = 296:
                    sLast = "295: Cast Spell: Foxs Cunning [10]";
                    sSelected = "296: Cast Spell: Foxs Cunning [15]";
                    sNext = "297: Cast Spell: Greater Eagles Splendor [11]";
                    break;
                case 297: // int IP_CONST_CASTSPELL_GREATER_EAGLES_SPLENDOR_11       = 297:
                    sLast = "296: Cast Spell: Foxs Cunning [15]";
                    sSelected = "297: Cast Spell: Greater Eagles Splendor [11]";
                    sNext = "298: Cast Spell: Greater Owls Wisdom [11]";
                    break;
                case 298: // int IP_CONST_CASTSPELL_GREATER_OWLS_WISDOM_11           = 298:
                    sLast = "297: Cast Spell: Greater Eagles Splendor [11]";
                    sSelected = "298: Cast Spell: Greater Owls Wisdom [11]";
                    sNext = "299: Cast Spell: Greater Foxs Cunning [11]";
                    break;
                case 299: // int IP_CONST_CASTSPELL_GREATER_FOXS_CUNNING_11          = 299:
                    sLast = "298: Cast Spell: Greater Owls Wisdom [11]";
                    sSelected = "299: Cast Spell: Greater Foxs Cunning [11]";
                    sNext = "300: Cast Spell: Greater Bulls Strength [11]";
                    break;
                case 300: // int IP_CONST_CASTSPELL_GREATER_BULLS_STRENGTH_11        = 300:
                    sLast = "299: Cast Spell: Greater Foxs Cunning [11]";
                    sSelected = "300: Cast Spell: Greater Bulls Strength [11]";
                    sNext = "301: Cast Spell: Greater Cats Grace [11]";
                    break;
                case 301: // int IP_CONST_CASTSPELL_GREATER_CATS_GRACE_11            = 301:
                    sLast = "300: Cast Spell: Greater Bulls Strength [11]";
                    sSelected = "301: Cast Spell: Greater Cats Grace [11]";
                    sNext = "302: Cast Spell: Greater Endurance [11]";
                    break;
                case 302: // int IP_CONST_CASTSPELL_GREATER_ENDURANCE_11             = 302:
                    sLast = "301: Cast Spell: Greater Cats Grace [11]";
                    sSelected = "302: Cast Spell: Greater Endurance [11]";
                    sNext = "303: Cast Spell: Greater Awaken [9]";
                    break;
                case 303: // int IP_CONST_CASTSPELL_AWAKEN_9                         = 303:
                    sLast = "302: Cast Spell: Greater Endurance [11]";
                    sSelected = "303: Cast Spell: Greater Awaken [9]";
                    sNext = "304: Cast Spell: Creeping Doom [13]";
                    break;
                case 304: // int IP_CONST_CASTSPELL_CREEPING_DOOM_13                 = 304:
                    sLast = "303: Cast Spell: Greater Awaken [9]";
                    sSelected = "304: Cast Spell: Creeping Doom [13]";
                    sNext = "305: Cast Spell: Darkvision [3]";
                    break;
                case 305: // int IP_CONST_CASTSPELL_DARKVISION_3                     = 305:
                    sLast = "304: Cast Spell: Creeping Doom [13]";
                    sSelected = "305: Cast Spell: Darkvision [3]";
                    sNext = "306: Cast Spell: Darkvision [6]";
                    break;
                case 306: // int IP_CONST_CASTSPELL_DARKVISION_6                     = 306:
                    sLast = "305: Cast Spell: Darkvision [3]";
                    sSelected = "306: Cast Spell: Darkvision [6]";
                    sNext = "307: Cast Spell: Destruction [13]";
                    break;
                case 307: // int IP_CONST_CASTSPELL_DESTRUCTION_13                   = 307:
                    sLast = "306: Cast Spell: Darkvision [6]";
                    sSelected = "307: Cast Spell: Destruction [13]";
                    sNext = "308: Cast Spell: Horrid Wilting [15]";
                    break;
                case 308: // int IP_CONST_CASTSPELL_HORRID_WILTING_15                = 308:
                    sLast = "307: Cast Spell: Destruction [13]";
                    sSelected = "308: Cast Spell: Horrid Wilting [15]";
                    sNext = "309: Cast Spell: Horrid Wilting [20]";
                    break;
                case 309: // int IP_CONST_CASTSPELL_HORRID_WILTING_20                = 309:
                    sLast = "308: Cast Spell: Horrid Wilting [15]";
                    sSelected = "309: Cast Spell: Horrid Wilting [20]";
                    sNext = "310: Cast Spell: Ice Storm [9]";
                    break;
                case 310: // int IP_CONST_CASTSPELL_ICE_STORM_9                      = 310:
                    sLast = "309: Cast Spell: Horrid Wilting [20]";
                    sSelected = "310: Cast Spell: Ice Storm [9]";
                    sNext = "311: Cast Spell: Energy Buffer [11]";
                    break;
                case 311: // int IP_CONST_CASTSPELL_ENERGY_BUFFER_11                 = 311:
                    sLast = "310: Cast Spell: Ice Storm [9]";
                    sSelected = "311: Cast Spell: Energy Buffer [11]";
                    sNext = "312: Cast Spell: Energy Buffer [15]";
                    break;
                case 312: // int IP_CONST_CASTSPELL_ENERGY_BUFFER_15                 = 312:
                    sLast = "311: Cast Spell: Energy Buffer [11]";
                    sSelected = "312: Cast Spell: Energy Buffer [15]";
                    sNext = "313: Cast Spell: Energy Buffer [20]";
                    break;
                case 313: // int IP_CONST_CASTSPELL_ENERGY_BUFFER_20                 = 313:
                    sLast = "312: Cast Spell: Energy Buffer [15]";
                    sSelected = "313: Cast Spell: Energy Buffer [20]";
                    sNext = "314: Cast Spell: Negative Energy Burst [5]";
                    break;
                case 314: // int IP_CONST_CASTSPELL_NEGATIVE_ENERGY_BURST_5          = 314:
                    sLast = "313: Cast Spell: Energy Buffer [20]";
                    sSelected = "314: Cast Spell: Negative Energy Burst [5]";
                    sNext = "315: Cast Spell: Negative Energy Burst [10]";
                    break;
                case 315: // int IP_CONST_CASTSPELL_NEGATIVE_ENERGY_BURST_10         = 315:
                    sLast = "314: Cast Spell: Negative Energy Burst [5]";
                    sSelected = "315: Cast Spell: Negative Energy Burst [10]";
                    sNext = "316: Cast Spell: Negative Energy Ray [1]";
                    break;
                case 316: // int IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_1            = 316:
                    sLast = "315: Cast Spell: Negative Energy Burst [10]";
                    sSelected = "316: Cast Spell: Negative Energy Ray [1]";
                    sNext = "317: Cast Spell: Negative Energy Ray [3]";
                    break;
                case 317: // int IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_3            = 317:
                    sLast = "316: Cast Spell: Negative Energy Ray [1]";
                    sSelected = "317: Cast Spell: Negative Energy Ray [3]";
                    sNext = "318: Cast Spell: Negative Energy Ray [5]";
                    break;
                case 318: // int IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_5            = 318:
                    sLast = "317: Cast Spell: Negative Energy Ray [3]";
                    sSelected = "318: Cast Spell: Negative Energy Ray [5]";
                    sNext = "319: Cast Spell: Negative Energy Ray [7]";
                    break;
                case 319: // int IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_7            = 319:
                    sLast = "318: Cast Spell: Negative Energy Ray [5]";
                    sSelected = "319: Cast Spell: Negative Energy Ray [7]";
                    sNext = "320: Cast Spell: Negative Energy Ray [9]";
                    break;
                case 320: // int IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_9            = 320:
                    sLast = "319: Cast Spell: Negative Energy Ray [7]";
                    sSelected = "320: Cast Spell: Negative Energy Ray [9]";
                    sNext = "321: Cast Spell: Aura of Vitality [13]";
                    break;
                case 321: // int IP_CONST_CASTSPELL_AURA_OF_VITALITY_13              = 321:
                    sLast = "320: Cast Spell: Negative Energy Ray [9]";
                    sSelected = "321: Cast Spell: Aura of Vitality [13]";
                    sNext = "322: Cast Spell: War Cry [7]";
                    break;
                case 322: // int IP_CONST_CASTSPELL_WAR_CRY_7                        = 322:
                    sLast = "321: Cast Spell: Aura of Vitality [13]";
                    sSelected = "322: Cast Spell: War Cry [7]";
                    sNext = "323: Cast Spell: Regenerate [13]";
                    break;
                case 323: // int IP_CONST_CASTSPELL_REGENERATE_13                    = 323:
                    sLast = "322: Cast Spell: War Cry [7]";
                    sSelected = "323: Cast Spell: Regenerate [13]";
                    sNext = "324: Cast Spell: Evards Black Tentacles [7]";
                    break;
                case 324: // int IP_CONST_CASTSPELL_EVARDS_BLACK_TENTACLES_7         = 324:
                    sLast = "323: Cast Spell: Regenerate [13]";
                    sSelected = "324: Cast Spell: Evards Black Tentacles [7]";
                    sNext = "325: Cast Spell: Evards Black Tentacles [15]";
                    break;
                case 325: // int IP_CONST_CASTSPELL_EVARDS_BLACK_TENTACLES_15        = 325:
                    sLast = "324: Cast Spell: Evards Black Tentacles [7]";
                    sSelected = "325: Cast Spell: Evards Black Tentacles [15]";
                    sNext = "326: Cast Spell: Legend Lore [5]";
                    break;
                case 326: // int IP_CONST_CASTSPELL_LEGEND_LORE_5                    = 326:
                    sLast = "325: Cast Spell: Evards Black Tentacles [15]";
                    sSelected = "326: Cast Spell: Legend Lore [5]";
                    sNext = "327: Cast Spell: Find Traps [3]";
                    break;
                case 327: // int IP_CONST_CASTSPELL_FIND_TRAPS_3                     = 327:
                    sLast = "326: Cast Spell: Legend Lore [5]";
                    sSelected = "327: Cast Spell: Find Traps [3]";
                    sNext = "328: Cast Spell: Rogues Cunning [3]";
                    break;
                case 328: // int IP_CONST_CASTSPELL_ROGUES_CUNNING_3                 = 328:
                    sLast = "327: Cast Spell: Find Traps [3]";
                    sSelected = "328: Cast Spell: Rogues Cunning [3]";
                    sNext = "329: Cast Spell: Unique Power [Runs OnActivateItem Script]";
                    break;
                case 329: // int IP_CONST_CASTSPELL_UNIQUE_POWER                     = 329:
                    sLast = "328: Cast Spell: Rogues Cunning [3]";
                    sSelected = "329: Cast Spell: Unique Power [Runs OnActivateItem Script]";
                    sNext = "330: Cast Spell: Special Alcohol Beer [ONLY apply to bottles!]";
                    break;
                case 330: // int IP_CONST_CASTSPELL_SPECIAL_ALCOHOL_BEER             = 330:
                    sLast = "329: Cast Spell: Unique Power [Runs OnActivateItem Script]";
                    sSelected = "330: Cast Spell: Special Alcohol Beer [ONLY apply to bottles!]";
                    sNext = "331: Cast Spell: Special Alcohol Wine [ONLY apply to bottles!]";
                    break;
                case 331: // int IP_CONST_CASTSPELL_SPECIAL_ALCOHOL_WINE             = 331:
                    sLast = "330: Cast Spell: Special Alcohol Beer [ONLY apply to bottles!]";
                    sSelected = "331: Cast Spell: Special Alcohol Wine [ONLY apply to bottles!]";
                    sNext = "332: Cast Spell: Special Alcohol Spirits [ONLY apply to bottles!]";
                    break;
                case 332: // int IP_CONST_CASTSPELL_SPECIAL_ALCOHOL_SPIRITS          = 332:
                    sLast = "331: Cast Spell: Special Alcohol Wine [ONLY apply to bottles!]";
                    sSelected = "332: Cast Spell: Special Alcohol Spirits [ONLY apply to bottles!]";
                    sNext = "333: Cast Spell: Herb Belladonna";
                    break;
                case 333: // int IP_CONST_CASTSPELL_SPECIAL_HERB_BELLADONNA          = 333:
                    sLast = "332: Cast Spell: Special Alcohol Spirits [ONLY apply to bottles!]";
                    sSelected = "333: Cast Spell: Herb Belladonna";
                    sNext = "334: Cast Spell: Herb Garlic";
                    break;
                case 334: // int IP_CONST_CASTSPELL_SPECIAL_HERB_GARLIC              = 334:
                    sLast = "333: Cast Spell: Herb Belladonna";
                    sSelected = "334: Cast Spell: Herb Garlic";
                    sNext = "335: Cast Spell: Unique Power Self Only [Runs OnActivateItem Script]";
                    break;
                case 335: // int IP_CONST_CASTSPELL_UNIQUE_POWER_SELF_ONLY           = 335:
                    sLast = "334: Cast Spell: Herb Garlic";
                    sSelected = "335: Cast Spell: Unique Power Self Only [Runs OnActivateItem Script]";
                    sNext = "336: Cast Spell: Grenade Fire [1]";
                    break;
                case 336: // int IP_CONST_CASTSPELL_GRENADE_FIRE_1                   = 336:
                    sLast = "335: Cast Spell: Unique Power Self Only [Runs OnActivateItem Script]";
                    sSelected = "336: Cast Spell: Grenade Fire [1]";
                    sNext = "337: Cast Spell: Grenade Tangle [1]";
                    break;
                case 337: // int IP_CONST_CASTSPELL_GRENADE_TANGLE_1                 = 337:
                    sLast = "336: Cast Spell: Grenade Fire [1]";
                    sSelected = "337: Cast Spell: Grenade Tangle [1]";
                    sNext = "338: Cast Spell: Grenade Holy [1]";
                    break;
                case 338: // int IP_CONST_CASTSPELL_GRENADE_HOLY_1                   = 338:
                    sLast = "337: Cast Spell: Grenade Tangle [1]";
                    sSelected = "338: Cast Spell: Grenade Holy [1]";
                    sNext = "339: Cast Spell: Grenade Choking [1]";
                    break;
                case 339: // int IP_CONST_CASTSPELL_GRENADE_CHOKING_1                = 339:
                    sLast = "338: Cast Spell: Grenade Holy [1]";
                    sSelected = "339: Cast Spell: Grenade Choking [1]";
                    sNext = "340: Cast Spell: Grenade Thunderstone [1]";
                    break;
                case 340: // int IP_CONST_CASTSPELL_GRENADE_THUNDERSTONE_1           = 340:
                    sLast = "339: Cast Spell: Grenade Choking [1]";
                    sSelected = "340: Cast Spell: Grenade Thunderstone [1]";
                    sNext = "341: Cast Spell: Grenade Acid [1]";
                    break;
                case 341: // int IP_CONST_CASTSPELL_GRENADE_ACID_1                   = 341:
                    sLast = "340: Cast Spell: Grenade Thunderstone [1]";
                    sSelected = "341: Cast Spell: Grenade Acid [1]";
                    sNext = "342: Cast Spell: Grenade Chicken [1]";
                    break;
                case 342: // int IP_CONST_CASTSPELL_GRENADE_CHICKEN_1                = 342:
                    sLast = "341: Cast Spell: Grenade Acid [1]";
                    sSelected = "342: Cast Spell: Grenade Chicken [1]";
                    sNext = "343: Cast Spell: Grenade Caltrops [1]";
                    break;
                case 343: // int IP_CONST_CASTSPELL_GRENADE_CALTROPS_1               = 343:
                    sLast = "342: Cast Spell: Grenade Chicken [1]";
                    sSelected = "343: Cast Spell: Grenade Caltrops [1]";
                    sNext = "344: Cast Spell: Manipulate Portal Stone";
                    break;
                case 344: // int IP_CONST_CASTSPELL_MANIPULATE_PORTAL_STONE          = 344:
                    sLast = "343: Cast Spell: Grenade Caltrops [1]";
                    sSelected = "344: Cast Spell: Manipulate Portal Stone";
                    sNext = "345: Cast Spell: Divine Favor [5]";
                    break;
                case 345: // int IP_CONST_CASTSPELL_DIVINE_FAVOR_5                   = 345:
                    sLast = "344: Cast Spell: Manipulate Portal Stone";
                    sSelected = "345: Cast Spell: Divine Favor [5]";
                    sNext = "346: Cast Spell: True Strike [5]";
                    break;
                case 346: // int IP_CONST_CASTSPELL_TRUE_STRIKE_5                    = 346:
                    sLast = "345: Cast Spell: Divine Favor [5]";
                    sSelected = "346: Cast Spell: True Strike [5]";
                    sNext = "347: Cast Spell: Flare [1]";
                    break;
                case 347: // int IP_CONST_CASTSPELL_FLARE_1                          = 347:
                    sLast = "346: Cast Spell: True Strike [5]";
                    sSelected = "347: Cast Spell: Flare [1]";
                    sNext = "348: Cast Spell: Shield [5]";
                    break;
                case 348: // int IP_CONST_CASTSPELL_SHIELD_5                         = 348:
                    sLast = "347: Cast Spell: Flare [1]";
                    sSelected = "348: Cast Spell: Shield [5]";
                    sNext = "349: Cast Spell: Entropic Shield [5]";
                    break;
                case 349: // int IP_CONST_CASTSPELL_ENTROPIC_SHIELD_5                = 349:
                    sLast = "348: Cast Spell: Shield [5]";
                    sSelected = "349: Cast Spell: Entropic Shield [5]";
                    sNext = "350: Cast Spell: Continual Flame [7]";
                    break;
                case 350: // int IP_CONST_CASTSPELL_CONTINUAL_FLAME_7                = 350:
                    sLast = "349: Cast Spell: Entropic Shield [5]";
                    sSelected = "350: Cast Spell: Continual Flame [7]";
                    sNext = "351: Cast Spell: One With the Land [7]";
                    break;
                case 351: // int IP_CONST_CASTSPELL_ONE_WITH_THE_LAND_7              = 351:
                    sLast = "350: Cast Spell: Continual Flame [7]";
                    sSelected = "351: Cast Spell: One With the Land [7]";
                    sNext = "352: Cast Spell: Camoflage [5]";
                    break;
                case 352: // int IP_CONST_CASTSPELL_CAMOFLAGE_5                      = 352:
                    sLast = "351: Cast Spell: One With the Land [7]";
                    sSelected = "352: Cast Spell: Camoflage [5]";
                    sNext = "353: Cast Spell: Blood Frenzy [7]";
                    break;
                case 353: // int IP_CONST_CASTSPELL_BLOOD_FRENZY_7                   = 353:
                    sLast = "352: Cast Spell: Camoflage [5]";
                    sSelected = "353: Cast Spell: Blood Frenzy [7]";
                    sNext = "354: Cast Spell: Bombardment [20]";
                    break;
                case 354: // int IP_CONST_CASTSPELL_BOMBARDMENT_20                   = 354:
                    sLast = "353: Cast Spell: Blood Frenzy [7]";
                    sSelected = "354: Cast Spell: Bombardment [20]";
                    sNext = "355: Cast Spell: Acid Splash [1]";
                    break;
                case 355: // int IP_CONST_CASTSPELL_ACID_SPLASH_1                    = 355:
                    sLast = "354: Cast Spell: Bombardment [20]";
                    sSelected = "355: Cast Spell: Acid Splash [1]";
                    sNext = "356: Cast Spell: Quillfire [8]";
                    break;
                case 356: // int IP_CONST_CASTSPELL_QUILLFIRE_8                      = 356:
                    sLast = "355: Cast Spell: Acid Splash [1]";
                    sSelected = "356: Cast Spell: Quillfire [8]";
                    sNext = "357: Cast Spell: Earthquake [20]";
                    break;
                case 357: // int IP_CONST_CASTSPELL_EARTHQUAKE_20                    = 357:
                    sLast = "356: Cast Spell: Quillfire [8]";
                    sSelected = "357: Cast Spell: Earthquake [20]";
                    sNext = "358: Cast Spell: Sunburst [20]";
                    break;
                case 358: // int IP_CONST_CASTSPELL_SUNBURST_20                      = 358:
                    sLast = "357: Cast Spell: Earthquake [20]";
                    sSelected = "358: Cast Spell: Sunburst [20]";
                    sNext = "359: Cast Spell: Activate Item";
                    break;
                case 359: // int IP_CONST_CASTSPELL_ACTIVATE_ITEM                    = 359:
                    sLast = "358: Cast Spell: Sunburst [20]";
                    sSelected = "359: Cast Spell: Activate Item";
                    sNext = "360: Cast Spell: Aura of Glory [7]";
                    break;
                case 360: // int IP_CONST_CASTSPELL_AURAOFGLORY_7                    = 360:
                    sLast = "359: Cast Spell: Activate Item";
                    sSelected = "360: Cast Spell: Aura of Glory [7]";
                    sNext = "361: Cast Spell: Banishment [15]";
                    break;
                case 361: // int IP_CONST_CASTSPELL_BANISHMENT_15                    = 361:
                    sLast = "360: Cast Spell: Aura of Glory [7]";
                    sSelected = "361: Cast Spell: Banishment [15]";
                    sNext = "362: Cast Spell: Inflict Minor Wounds [1]";
                    break;
                case 362: // int IP_CONST_CASTSPELL_INFLICT_MINOR_WOUNDS_1           = 362:
                    sLast = "361: Cast Spell: Banishment [15]";
                    sSelected = "362: Cast Spell: Inflict Minor Wounds [1]";
                    sNext = "363: Cast Spell: Inflict Light Wounds [5]";
                    break;
                case 363: // int IP_CONST_CASTSPELL_INFLICT_LIGHT_WOUNDS_5           = 363:
                    sLast = "362: Cast Spell: Inflict Minor Wounds [1]";
                    sSelected = "363: Cast Spell: Inflict Light Wounds [5]";
                    sNext = "364: Cast Spell: Inflict Moderate Wounds [7]";
                    break;
                case 364: // int IP_CONST_CASTSPELL_INFLICT_MODERATE_WOUNDS_7        = 364:
                    sLast = "363: Cast Spell: Inflict Light Wounds [5]";
                    sSelected = "364: Cast Spell: Inflict Moderate Wounds [7]";
                    sNext = "365: Cast Spell: Inflict Serious Wounds [9]";
                    break;
                case 365: // int IP_CONST_CASTSPELL_INFLICT_SERIOUS_WOUNDS_9         = 365:
                    sLast = "364: Cast Spell: Inflict Moderate Wounds [7]";
                    sSelected = "365: Cast Spell: Inflict Serious Wounds [9]";
                    sNext = "366: Cast Spell: Inflict Critical Wounds [12]";
                    break;
                case 366: // int IP_CONST_CASTSPELL_INFLICT_CRITICAL_WOUNDS_12       = 366:
                    sLast = "365: Cast Spell: Inflict Serious Wounds [9]";
                    sSelected = "366: Cast Spell: Inflict Critical Wounds [12]";
                    sNext = "367: Cast Spell: Balagarns Iron Horn [7]";
                    break;
                case 367: // int IP_CONST_CASTSPELL_BALAGARNSIRONHORN_7              = 367:
                    sLast = "366: Cast Spell: Inflict Critical Wounds [12]";
                    sSelected = "367: Cast Spell: Balagarns Iron Horn [7]";
                    sNext = "368: Cast Spell: Drown [15]";
                    break;
                case 368: // int IP_CONST_CASTSPELL_DROWN_15                         = 368:
                    sLast = "367: Cast Spell: Balagarns Iron Horn [7]";
                    sSelected = "368: Cast Spell: Drown [15]";
                    sNext = "369: Cast Spell: Owls Insight [15]";
                    break;
                case 369: // int IP_CONST_CASTSPELL_OWLS_INSIGHT_15                  = 369:
                    sLast = "368: Cast Spell: Drown [15]";
                    sSelected = "369: Cast Spell: Owls Insight [15]";
                    sNext = "370: Cast Spell: Electric Jolt [1]";
                    break;
                case 370: // int IP_CONST_CASTSPELL_ELECTRIC_JOLT_1                  = 370:
                    sLast = "369: Cast Spell: Owls Insight [15]";
                    sSelected = "370: Cast Spell: Electric Jolt [1]";
                    sNext = "371: Cast Spell: Firebrand [15]";
                    break;
                case 371: // int IP_CONST_CASTSPELL_FIREBRAND_15                     = 371:
                    sLast = "370: Cast Spell: Electric Jolt [1]";
                    sSelected = "371: Cast Spell: Firebrand [15]";
                    sNext = "372: Cast Spell: Wounding Whispers [9]";
                    break;
                case 372: // int IP_CONST_CASTSPELL_WOUNDING_WHISPERS_9              = 372:
                    sLast = "371: Cast Spell: Firebrand [15]";
                    sSelected = "372: Cast Spell: Wounding Whispers [9]";
                    sNext = "373: Cast Spell: Amplify [5]";
                    break;
                case 373: // int IP_CONST_CASTSPELL_AMPLIFY_5                        = 373:
                    sLast = "372: Cast Spell: Wounding Whispers [9]";
                    sSelected = "373: Cast Spell: Amplify [5]";
                    sNext = "374: Cast Spell: Etherealness [18]";
                    break;
                case 374: // int IP_CONST_CASTSPELL_ETHEREALNESS_18                  = 374:
                    sLast = "373: Cast Spell: Amplify [5]";
                    sSelected = "374: Cast Spell: Etherealness [18]";
                    sNext = "375: Cast Spell: Undeaths Eternal Foe [20]";
                    break;
                case 375: // int IP_CONST_CASTSPELL_UNDEATHS_ETERNAL_FOE_20          = 375:
                    sLast = "374: Cast Spell: Etherealness [18]";
                    sSelected = "375: Cast Spell: Undeaths Eternal Foe [20]";
                    sNext = "376: Cast Spell: Dirge [15]";
                    break;
                case 376: // int IP_CONST_CASTSPELL_DIRGE_15                         = 376:
                    sLast = "375: Cast Spell: Undeaths Eternal Foe [20]";
                    sSelected = "376: Cast Spell: Dirge [15]";
                    sNext = "377: Cast Spell: Inferno [15]";
                    break;
                case 377: // int IP_CONST_CASTSPELL_INFERNO_15                       = 377:
                    sLast = "376: Cast Spell: Dirge [15]";
                    sSelected = "377: Cast Spell: Inferno [15]";
                    sNext = "378: Cast Spell: Isaacs Lesser Missile Storm [13]";
                    break;
                case 378: // int IP_CONST_CASTSPELL_ISAACS_LESSER_MISSILE_STORM_13   = 378:
                    sLast = "377: Cast Spell: Inferno [15]";
                    sSelected = "378: Cast Spell: Isaacs Lesser Missile Storm [13]";
                    sNext = "379: Cast Spell: Isaacs Greater Missile Storm [15]";
                    break;
                case 379: // int IP_CONST_CASTSPELL_ISAACS_GREATER_MISSILE_STORM_15  = 379:
                    sLast = "378: Cast Spell: Isaacs Lesser Missile Storm [13]";
                    sSelected = "379: Cast Spell: Isaacs Greater Missile Storm [15]";
                    sNext = "380: Cast Spell: Bane [5]";
                    break;
                case 380: // int IP_CONST_CASTSPELL_BANE_5                           = 380:
                    sLast = "379: Cast Spell: Isaacs Greater Missile Storm [15]";
                    sSelected = "380: Cast Spell: Bane [5]";
                    sNext = "381: Cast Spell: Shield of Faith [5]";
                    break;
                case 381: // int IP_CONST_CASTSPELL_SHIELD_OF_FAITH_5                = 381:
                    sLast = "380: Cast Spell: Bane [5]";
                    sSelected = "381: Cast Spell: Shield of Faith [5]";
                    sNext = "382: Cast Spell: Planar Ally [15]";
                    break;
                case 382: // int IP_CONST_CASTSPELL_PLANAR_ALLY_15                   = 382:
                    sLast = "381: Cast Spell: Shield of Faith [5]";
                    sSelected = "382: Cast Spell: Planar Ally [15]";
                    sNext = "383: Cast Spell: Magic Fang [5]";
                    break;
                case 383: // int IP_CONST_CASTSPELL_MAGIC_FANG_5                     = 383:
                    sLast = "382: Cast Spell: Planar Ally [15]";
                    sSelected = "383: Cast Spell: Magic Fang [5]";
                    sNext = "384: Cast Spell: Greater Magic Fang [9]";
                    break;
                case 384: // int IP_CONST_CASTSPELL_GREATER_MAGIC_FANG_9             = 384:
                    sLast = "383: Cast Spell: Magic Fang [5]";
                    sSelected = "384: Cast Spell: Greater Magic Fang [9]";
                    sNext = "385: Cast Spell: Spike Growth [9]";
                    break;
                case 385: // int IP_CONST_CASTSPELL_SPIKE_GROWTH_9                   = 385:
                    sLast = "384: Cast Spell: Greater Magic Fang [9]";
                    sSelected = "385: Cast Spell: Spike Growth [9]";
                    sNext = "386: Cast Spell: Mass Camoflage [13]";
                    break;
                case 386: // int IP_CONST_CASTSPELL_MASS_CAMOFLAGE_13                = 386:
                    sLast = "385: Cast Spell: Spike Growth [9]";
                    sSelected = "386: Cast Spell: Mass Camoflage [13]";
                    sNext = "387: Cast Spell: Expeditious Retreat [5]";
                    break;
                case 387: // int IP_CONST_CASTSPELL_EXPEDITIOUS_RETREAT_5            = 387:
                    sLast = "386: Cast Spell: Mass Camoflage [13]";
                    sSelected = "387: Cast Spell: Expeditious Retreat [5]";
                    sNext = "388: Cast Spell: Tashas Hideous Laughter [7]";
                    break;
                case 388: // int IP_CONST_CASTSPELL_TASHAS_HIDEOUS_LAUGHTER_7        = 388:
                    sLast = "387: Cast Spell: Expeditious Retreat [5]";
                    sSelected = "388: Cast Spell: Tashas Hideous Laughter [7]";
                    sNext = "389: Cast Spell: Displacement [9]";
                    break;
                case 389: // int IP_CONST_CASTSPELL_DISPLACEMENT_9                   = 389:
                    sLast = "388: Cast Spell: Tashas Hideous Laughter [7]";
                    sSelected = "389: Cast Spell: Displacement [9]";
                    sNext = "390: Cast Spell: Bigbys Interposing Hand [15]";
                    break;
                case 390: // int IP_CONST_CASTSPELL_BIGBYS_INTERPOSING_HAND_15       = 390:
                    sLast = "389: Cast Spell: Displacement [9]";
                    sSelected = "390: Cast Spell: Bigbys Interposing Hand [15]";
                    sNext = "391: Cast Spell: Bigbys Forceful Hand [15]";
                    break;
                case 391: // int IP_CONST_CASTSPELL_BIGBYS_FORCEFUL_HAND_15          = 391:
                    sLast = "390: Cast Spell: Bigbys Interposing Hand [15]";
                    sSelected = "391: Cast Spell: Bigbys Forceful Hand [15]";
                    sNext = "392: Cast Spell: Bigbys Grasping Hand [17]";
                    break;
                case 392: // int IP_CONST_CASTSPELL_BIGBYS_GRASPING_HAND_17          = 392:
                    sLast = "391: Cast Spell: Bigbys Forceful Hand [15]";
                    sSelected = "392: Cast Spell: Bigbys Grasping Hand [17]";
                    sNext = "393: Cast Spell: Bigbys Clenched Fist [20]";
                    break;
                case 393: // int IP_CONST_CASTSPELL_BIGBYS_CLENCHED_FIST_20          = 393:
                    sLast = "392: Cast Spell: Bigbys Grasping Hand [17]";
                    sSelected = "393: Cast Spell: Bigbys Clenched Fist [20]";
                    sNext = "394: Cast Spell: Bigbys Crushing Hand [20]";
                    break;
                case 394: // int IP_CONST_CASTSPELL_BIGBYS_CRUSHING_HAND_20          = 394:
                    sLast = "393: Cast Spell: Bigbys Clenched Fist [20]";
                    sSelected = "394: Cast Spell: Bigbys Crushing Hand [20]";
                    sNext = "395: Cast Spell: Divine Might [5]";
                    break;
                case 395: // int IP_CONST_CASTSPELL_DIVINE_MIGHT_5                   = 395:
                    sLast = "394: Cast Spell: Bigbys Crushing Hand [20]";
                    sSelected = "395: Cast Spell: Divine Might [5]";
                    sNext = "396: Cast Spell: Divine Shield [5]";
                    break;
                case 396: // int IP_CONST_CASTSPELL_DIVINE_SHIELD_5                  = 396:
                    sLast = "395: Cast Spell: Divine Might [5]";
                    sSelected = "396: Cast Spell: Divine Shield [5]";
                    sNext = "398: Cast Spell: Flesh To Stone [5]";
                    break;
                case 398: // int IP_CONST_CASTSPELL_FLESH_TO_STONE_5                 = 398:
                    sLast = "396: Cast Spell: Divine Shield [5]";
                    sSelected = "398: Cast Spell: Flesh To Stone [5]";
                    sNext = "399: Cast Spell: Stone To Flesh [5]";
                    break;
                case 399: // int IP_CONST_CASTSPELL_STONE_TO_FLESH_5                 = 399:
                    sLast = "398: Cast Spell: Flesh To Stone [5]";
                    sSelected = "399: Cast Spell: Stone To Flesh [5]";
                    sNext = "400: Cast Spell: Dragon Breath Acid [10]";
                    break;
                case 400: // int IP_CONST_CASTSPELL_DRAGON_BREATH_ACID_10            = 400:
                    sLast = "399: Cast Spell: Stone To Flesh [5]";
                    sSelected = "400: Cast Spell: Dragon Breath Acid [10]";
                    sNext = "401: Cast Spell: Dragon Breath Cold [10]";
                    break;
                case 401: // int IP_CONST_CASTSPELL_DRAGON_BREATH_COLD_10            = 401:
                    sLast = "400: Cast Spell: Dragon Breath Acid [10]";
                    sSelected = "401: Cast Spell: Dragon Breath Cold [10]";
                    sNext = "402: Cast Spell: Dragon Breath Fear [10]";
                    break;
                case 402: // int IP_CONST_CASTSPELL_DRAGON_BREATH_FEAR_10            = 402:
                    sLast = "401: Cast Spell: Dragon Breath Cold [10]";
                    sSelected = "402: Cast Spell: Dragon Breath Fear [10]";
                    sNext = "403: Cast Spell: Dragon Breath Fire [10]";
                    break;
                case 403: // int IP_CONST_CASTSPELL_DRAGON_BREATH_FIRE_10            = 403:
                    sLast = "402: Cast Spell: Dragon Breath Fear [10]";
                    sSelected = "403: Cast Spell: Dragon Breath Fire [10]";
                    sNext = "404: Cast Spell: Dragon Breath Gas [10]";
                    break;
                case 404: // int IP_CONST_CASTSPELL_DRAGON_BREATH_GAS_10             = 404:
                    sLast = "403: Cast Spell: Dragon Breath Fire [10]";
                    sSelected = "404: Cast Spell: Dragon Breath Gas [10]";
                    sNext = "405: Cast Spell: Dragon Breath Lightning [10]";
                    break;
                case 405: // int IP_CONST_CASTSPELL_DRAGON_BREATH_LIGHTNING_10       = 405:
                    sLast = "404: Cast Spell: Dragon Breath Gas [10]";
                    sSelected = "405: Cast Spell: Dragon Breath Lightning [10]";
                    sNext = "406: Cast Spell: Dragon Breath Paralyze [10]";
                    break;
                case 406: // int IP_CONST_CASTSPELL_DRAGON_BREATH_PARALYZE_10        = 406:
                    sLast = "405: Cast Spell: Dragon Breath Lightning [10]";
                    sSelected = "406: Cast Spell: Dragon Breath Paralyze [10]";
                    sNext = "407: Cast Spell: Dragon Breath Sleep [10]";
                    break;
                case 407: // int IP_CONST_CASTSPELL_DRAGON_BREATH_SLEEP_10           = 407:
                    sLast = "406: Cast Spell: Dragon Breath Paralyze [10]";
                    sSelected = "407: Cast Spell: Dragon Breath Sleep [10]";
                    sNext = "408: Cast Spell: Dragon Breath Slow [10]";
                    break;
                case 408: // int IP_CONST_CASTSPELL_DRAGON_BREATH_SLOW_10            = 408:
                    sLast = "407: Cast Spell: Dragon Breath Sleep [10]";
                    sSelected = "408: Cast Spell: Dragon Breath Slow [10]";
                    sNext = "409: Cast Spell: Dragon Breath Weaken [10]";
                    break;
                case 409: // int IP_CONST_CASTSPELL_DRAGON_BREATH_WEAKEN_10          = 409:
                    sLast = "408: Cast Spell: Dragon Breath Slow [10]";
                    sSelected = "409: Cast Spell: Dragon Breath Weaken [10]";
                    sNext = "410: Cast Spell: Gust of Wind [10]";
                    break;
                case 410: // int IP_CONST_CASTSPELL_GUST_OF_WIND_10                  = 410:
                    sLast = "409: Cast Spell: Dragon Breath Weaken [10]";
                    sSelected = "410: Cast Spell: Gust of Wind [10]";
                    sNext = "0: Cast Spell: Acid Fog [11]";
                    break;
            }
            nSubPropertyMax = 410;
            break;
//        case 16: // ITEM_PROPERTY_DAMAGE_BONUS                             = 16 ;
//            break;
//        case 17: // ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP          = 17 ;
//            break;
//        case 18: // ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP             = 18 ;
//            break;
//        case 19: // ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT       = 19 ;
//            break;
//        case 20: // ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE                     = 20 ;
//            break;
//        case 21: // ITEM_PROPERTY_DECREASED_DAMAGE                         = 21 ;
//            break;
        case 22: // ITEM_PROPERTY_DAMAGE_REDUCTION                         = 22 ;
            switch(nSubPropertyNumber)
            {
                case 0: // IP_CONST_DAMAGEREDUCTION_1                  = 0;
                    sLast = "19: Damagereduction: 20";
                    sSelected = "0: Damagereduction: 1";
                    sNext = "1: Damagereduction: 2";
                    break;
                case 1: // IP_CONST_DAMAGEREDUCTION_2                  = 1;
                    sLast = "0: Damagereduction: 1";
                    sSelected = "1: Damagereduction: 2";
                    sNext = "2: Damagereduction: 3";
                    break;
                case 2: // IP_CONST_DAMAGEREDUCTION_3                  = 2;
                    sLast = "1: Damagereduction: 2";
                    sSelected = "2: Damagereduction: 3";
                    sNext = "3: Damagereduction: 4";
                    break;
                case 3: // IP_CONST_DAMAGEREDUCTION_4                  = 3;
                    sLast = "2: Damagereduction: 3";
                    sSelected = "3: Damagereduction: 4";
                    sNext = "4: Damagereduction: 5";
                    break;
                case 4: // IP_CONST_DAMAGEREDUCTION_5                  = 4;
                    sLast = "3: Damagereduction: 4";
                    sSelected = "4: Damagereduction: 5";
                    sNext = "5: Damagereduction: 6";
                    break;
                case 5: // IP_CONST_DAMAGEREDUCTION_6                  = 5;
                    sLast = "4: Damagereduction: 5";
                    sSelected = "5: Damagereduction: 6";
                    sNext = "6: Damagereduction: 7";
                    break;
                case 6: // IP_CONST_DAMAGEREDUCTION_7                  = 6;
                    sLast = "5: Damagereduction: 6";
                    sSelected = "6: Damagereduction: 7";
                    sNext = "7: Damagereduction: 8";
                    break;
                case 7: // IP_CONST_DAMAGEREDUCTION_8                  = 7;
                    sLast = "6: Damagereduction: 7";
                    sSelected = "7: Damagereduction: 8";
                    sNext = "8: Damagereduction: 9";
                    break;
                case 8: // IP_CONST_DAMAGEREDUCTION_9                  = 8;
                    sLast = "7: Damagereduction: 8";
                    sSelected = "8: Damagereduction: 9";
                    sNext = "9: Damagereduction: 10";
                    break;
                case 9: // IP_CONST_DAMAGEREDUCTION_10                 = 9;
                    sLast = "8: Damagereduction: 9";
                    sSelected = "9: Damagereduction: 10";
                    sNext = "10: Damagereduction: 11";
                    break;
                case 10: // IP_CONST_DAMAGEREDUCTION_11                 = 10;
                    sLast = "9: Damagereduction: 10";
                    sSelected = "10: Damagereduction: 11";
                    sNext = "11: Damagereduction: 12";
                    break;
                case 11: // IP_CONST_DAMAGEREDUCTION_12                 = 11;
                    sLast = "10: Damagereduction: 11";
                    sSelected = "11: Damagereduction: 12";
                    sNext = "12: Damagereduction: 13";
                    break;
                case 12: // IP_CONST_DAMAGEREDUCTION_13                 = 12;
                    sLast = "11: Damagereduction: 12";
                    sSelected = "12: Damagereduction: 13";
                    sNext = "13: Damagereduction: 14";
                    break;
                case 13: // IP_CONST_DAMAGEREDUCTION_14                 = 13;
                    sLast = "12: Damagereduction: 13";
                    sSelected = "13: Damagereduction: 14";
                    sNext = "14: Damagereduction: 15";
                    break;
                case 14: // IP_CONST_DAMAGEREDUCTION_15                 = 14;
                    sLast = "13: Damagereduction: 14";
                    sSelected = "14: Damagereduction: 15";
                    sNext = "15: Damagereduction: 16";
                    break;
                case 15: // IP_CONST_DAMAGEREDUCTION_16                 = 15;
                    sLast = "14: Damagereduction: 15";
                    sSelected = "15: Damagereduction: 16";
                    sNext = "16: Damagereduction: 17";
                    break;
                case 16: // IP_CONST_DAMAGEREDUCTION_17                 = 16;
                    sLast = "15: Damagereduction: 16";
                    sSelected = "16: Damagereduction: 17";
                    sNext = "17: Damagereduction: 18";
                    break;
                case 17: // IP_CONST_DAMAGEREDUCTION_18                 = 17;
                    sLast = "16: Damagereduction: 17";
                    sSelected = "17: Damagereduction: 18";
                    sNext = "18: Damagereduction: 19";
                    break;
                case 18: // IP_CONST_DAMAGEREDUCTION_19                 = 18;
                    sLast = "17: Damagereduction: 18";
                    sSelected = "18: Damagereduction: 19";
                    sNext = "19: Damagereduction: 20";
                    break;
                case 19: // IP_CONST_DAMAGEREDUCTION_20                 = 19;
                    sLast = "18: Damagereduction: 19";
                    sSelected = "19: Damagereduction: 20";
                    sNext = "0: Damagereduction: 1";
                    break;
            }
            nSubPropertyMax = 19;
            break;
//        case 23: // ITEM_PROPERTY_DAMAGE_RESISTANCE                        = 23 ;
//            break;
//        case 24: // ITEM_PROPERTY_DAMAGE_VULNERABILITY                     = 24 ;
//            break;
//        case 25: //
//            break;
        case 26: // ITEM_PROPERTY_DARKVISION                               = 26 ;
        case 35: // ITEM_PROPERTY_HASTE                                    = 35 ;
        case 36: // ITEM_PROPERTY_HOLY_AVENGER                             = 36 ;
        case 38: // ITEM_PROPERTY_IMPROVED_EVASION                         = 38 ;
        case 43: // ITEM_PROPERTY_KEEN                                     = 43 ;
        case 47: // ITEM_PROPERTY_NO_DAMAGE                                = 47 ;
        case 71: // ITEM_PROPERTY_TRUE_SEEING                              = 71 ;
        case 79: // ITEM_PROPERTY_SPECIAL_WALK                             = 79;
            sLast = "Required Values set, continue to duration";
            sSelected = "Required Values set, continue to duration";
            sNext = "Required Values set, continue to duration";
            break;
//        case 27: // ITEM_PROPERTY_DECREASED_ABILITY_SCORE                  = 27 ;
//            break;
        case 28: // ITEM_PROPERTY_DECREASED_AC                             = 28 ;
            switch(nSubPropertyNumber)
            {
                case 0: // IP_CONST_ACMODIFIERTYPE_DODGE
                    sLast = "4: AC Deflection Modifier";
                    sSelected = "0: AC Dodge Modifier";
                    sNext = "1: AC Natural Modifier";
                    break;
                case 1: // IP_CONST_ACMODIFIERTYPE_NATURAL
                    sLast = "0: AC Dodge Modifier";
                    sSelected = "1: AC Natural Modifier";
                    sNext = "2: AC Armor Modifier";
                    break;
                case 2: // IP_CONST_ACMODIFIERTYPE_ARMOR
                    sLast = "1: AC Natural Modifier";
                    sSelected = "2: AC Armor Modifier";
                    sNext = "3: AC Shield Modifier";
                    break;
                case 3: // IP_CONST_ACMODIFIERTYPE_SHIELD
                    sLast = "2: AC Armor Modifier";
                    sSelected = "3: AC Shield Modifier";
                    sNext = "4: AC Deflection Modifier";
                    break;
                case 4: // IP_CONST_ACMODIFIERTYPE_DEFLECTION
                    sLast = "3: AC Shield Modifier";
                    sSelected = "4: AC Deflection Modifier";
                    sNext = "0: AC Dodge Modifier";
                    break;
            }
            nSubPropertyMax = 4;
            break;
        case 29: // ITEM_PROPERTY_DECREASED_SKILL_MODIFIER                 = 29 ;
        case 52: // ITEM_PROPERTY_SKILL_BONUS                              = 52 ;
            switch(nSubPropertyNumber)
            {
                case 0: // SKILL_ANIMAL_EMPATHY   = 0;
                    sLast = "26: Skill: Craft Weapon";
                    sSelected = "0: Skill: Animal Empathy";
                    sNext = "1: Skill: Concentration";
                    break;
                case 1: // SKILL_CONCENTRATION    = 1;
                    sLast = "0: Skill: Animal Empathy";
                    sSelected = "1: Skill: Concentration";
                    sNext = "2: Skill: Disable Trap";
                    break;
                case 2: // SKILL_DISABLE_TRAP     = 2;
                    sLast = "1: Skill: Concentration";
                    sSelected = "2: Skill: Disable Trap";
                    sNext = "3: Skill: Discipline";
                    break;
                case 3: // SKILL_DISCIPLINE       = 3;
                    sLast = "2: Skill: Disable Trap";
                    sSelected = "3: Skill: Discipline";
                    sNext = "4: Skill: Heal";
                    break;
                case 4: // SKILL_HEAL             = 4;
                    sLast = "3: Skill: Discipline";
                    sSelected = "4: Skill: Heal";
                    sNext = "5: Skill: Hide";
                    break;
                case 5: // SKILL_HIDE             = 5;
                    sLast = "4: Skill: Heal";
                    sSelected = "5: Skill: Hide";
                    sNext = "6: Skill: Listen";
                    break;
                case 6: // SKILL_LISTEN           = 6;
                    sLast = "5: Skill: Hide";
                    sSelected = "6: Skill: Listen";
                    sNext = "7: Skill: Lore";
                    break;
                case 7: // SKILL_LORE             = 7;
                    sLast = "6: Skill: Listen";
                    sSelected = "7: Skill: Lore";
                    sNext = "8: Skill: Move Silently";
                    break;
                case 8: // SKILL_MOVE_SILENTLY    = 8;
                    sLast = "7: Skill: Lore";
                    sSelected = "8: Skill: Move Silently";
                    sNext = "9: Skill: Open Lock";
                    break;
                case 9: // SKILL_OPEN_LOCK        = 9;
                    sLast = "8: Skill: Move Silently";
                    sSelected = "9: Skill: Open Lock";
                    sNext = "10: Skill: Parry";
                    break;
                case 10: // SKILL_PARRY            = 10;
                    sLast = "9: Skill: Open Lock";
                    sSelected = "10: Skill: Parry";
                    sNext = "11: Skill: Perform";
                    break;
                case 11: // SKILL_PERFORM          = 11;
                    sLast = "10: Skill: Parry";
                    sSelected = "11: Skill: Perform";
                    sNext = "12: Skill: Persuade";
                    break;
                case 12: // SKILL_PERSUADE         = 12;
                    sLast = "11: Skill: Perform";
                    sSelected = "12: Skill: Persuade";
                    sNext = "13: Skill: Pick Pocket";
                    break;
                case 13: // SKILL_PICK_POCKET      = 13;
                    sLast = "12: Skill: Persuade";
                    sSelected = "13: Skill: Pick Pocket";
                    sNext = "14: Skill: Search";
                    break;
                case 14: // SKILL_SEARCH           = 14;
                    sLast = "13: Skill: Pick Pocket";
                    sSelected = "14: Skill: Search";
                    sNext = "15: Skill: Set Trap";
                    break;
                case 15: // SKILL_SET_TRAP         = 15;
                    sLast = "14: Skill: Search";
                    sSelected = "15: Skill: Set Trap";
                    sNext = "16: Skill: Spellcraft";
                    break;
                case 16: // SKILL_SPELLCRAFT       = 16;
                    sLast = "15: Skill: Set Trap";
                    sSelected = "16: Skill: Spellcraft";
                    sNext = "17: Skill: Spot";
                    break;
                case 17: // SKILL_SPOT             = 17;
                    sLast = "16: Skill: Spellcraft";
                    sSelected = "17: Skill: Spot";
                    sNext = "18: Skill: Taunt";
                    break;
                case 18: // SKILL_TAUNT            = 18;
                    sLast = "17: Skill: Spot";
                    sSelected = "18: Skill: Taunt";
                    sNext = "19: Skill: Use Magic Device";
                    break;
                case 19: // SKILL_USE_MAGIC_DEVICE = 19;
                    sLast = "18: Skill: Taunt";
                    sSelected = "19: Skill: Use Magic Device";
                    sNext = "20: Skill: Appraise";
                    break;
                case 20: // SKILL_APPRAISE         = 20;
                    sLast = "19: Skill: Use Magic Device";
                    sSelected = "20: Skill: Appraise";
                    sNext = "21: Skill: Tumble";
                    break;
                case 21: // SKILL_TUMBLE           = 21;
                    sLast = "20: Skill: Appraise";
                    sSelected = "21: Skill: Tumble";
                    sNext = "22: Skill: Craft Trap";
                    break;
                case 22: // SKILL_CRAFT_TRAP       = 22;
                    sLast = "21: Skill: Tumble";
                    sSelected = "22: Skill: Craft Trap";
                    sNext = "23: Skill: Bluff";
                    break;
                case 23: // SKILL_BLUFF            = 23;
                    sLast = "22: Skill: Craft Trap";
                    sSelected = "23: Skill: Bluff";
                    sNext = "24: Skill: Intimidate";
                    break;
                case 24: // SKILL_INTIMIDATE       = 24;
                    sLast = "23: Skill: Bluff";
                    sSelected = "24: Skill: Intimidate";
                    sNext = "25: Skill: Craft Armor";
                    break;
                case 25: // SKILL_CRAFT_ARMOR      = 25;
                    sLast = "24: Skill: Intimidate";
                    sSelected = "25: Skill: Craft Armor";
                    sNext = "26: Skill: Craft Weapon";
                    break;
                case 26: // SKILL_CRAFT_WEAPON     = 26;
                    sLast = "25: Skill: Craft Armor";
                    sSelected = "26: Skill: Craft Weapon";
                    sNext = "0: Skill: Animal Empathy";
                    break;
            }
            nSubPropertyMax = 26;
            break;
//        case 30: //
//            break;
//        case 31: //
//            break;
//        case 32: // ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT        = 32 ;
//            break;
        case 33: // ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE                  = 33 ;
        case 34: // ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE                 = 34 ;
            switch(nSubPropertyNumber)
            {
                case 0: // IP_CONST_DAMAGETYPE_BLUDGEONING             = 0;
                    sLast = "2: Damage Type: Slashing";
                    sSelected = "0: Damage Type: Bludgeoning";
                    sNext = "1: Damage Type: Piercing";
                    break;
                case 1: // int IP_CONST_DAMAGETYPE_PIERCING                = 1;
                    sLast = "0: Damage Type: Bludgeoning";
                    sSelected = "1: Damage Type: Piercing";
                    sNext = "2: Damage Type: Slashing";
                    break;
                case 2: // int IP_CONST_DAMAGETYPE_SLASHING                = 2;
                    sLast = "1: Damage Type: Piercing";
                    sSelected = "2: Damage Type: Slashing";
                    sNext = "0: Damage Type: Bludgeoning";
                    break;
            }
            nSubPropertyMax = 2;
            break;
//        case 34: // ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE                 = 34 ;
//            break;
//        case 35: // ITEM_PROPERTY_HASTE                                    = 35 ;
//            break;
//        case 36: // ITEM_PROPERTY_HOLY_AVENGER                             = 36 ;
//            break;
        case 37: // ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS                   = 37 ;
            switch(nSubPropertyNumber)
            {
                case 0: // IP_CONST_IMMUNITYMISC_BACKSTAB              = 0;
                    sLast = "9: Immunity: Death Magic";
                    sSelected = "0: Immunity: Backstab";
                    sNext = "1: Immunity: Level Ability Drain";
                    break;
                case 1: // IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN      = 1;
                    sLast = "0: Immunity: Backstab";
                    sSelected = "1: Immunity: Level Ability Drain";
                    sNext = "2: Immunity: Mind Spells";
                    break;
                case 2: // IP_CONST_IMMUNITYMISC_MINDSPELLS            = 2;
                    sLast = "1: Immunity: Level Ability Drain";
                    sSelected = "2: Immunity: Mind Spells";
                    sNext = "3: Immunity: Poison";
                    break;
                case 3: // IP_CONST_IMMUNITYMISC_POISON                = 3;
                    sLast = "2: Immunity: Mind Spells";
                    sSelected = "3: Immunity: Poison";
                    sNext = "4: Immunity: Disease";
                    break;
                case 4: // IP_CONST_IMMUNITYMISC_DISEASE               = 4;
                    sLast = "3: Immunity: Poison";
                    sSelected = "4: Immunity: Disease";
                    sNext = "5: Immunity: Fear";
                    break;
                case 5: // IP_CONST_IMMUNITYMISC_FEAR                  = 5;
                    sLast = "4: Immunity: Disease";
                    sSelected = "5: Immunity: Fear";
                    sNext = "6: Immunity: Knockdown";
                    break;
                case 6: // IP_CONST_IMMUNITYMISC_KNOCKDOWN             = 6;
                    sLast = "5: Immunity: Fear";
                    sSelected = "6: Immunity: Knockdown";
                    sNext = "7: Immunity: Paralysis";
                    break;
                case 7: // IP_CONST_IMMUNITYMISC_PARALYSIS             = 7;
                    sLast = "6: Immunity: Knockdown";
                    sSelected = "7: Immunity: Paralysis";
                    sNext = "8: Immunity: Critical Hits";
                    break;
                case 8: // IP_CONST_IMMUNITYMISC_CRITICAL_HITS         = 8;
                    sLast = "7: Immunity: Paralysis";
                    sSelected = "8: Immunity: Critical Hits";
                    sNext = "9: Immunity: Death Magic";
                    break;
                case 9: // IP_CONST_IMMUNITYMISC_DEATH_MAGIC           = 9;
                    sLast = "8: Immunity: Critical Hits";
                    sSelected = "9: Immunity: Death Magic";
                    sNext = "0: Immunity: Backstab";
                    break;
            }
            nSubPropertyMax = 9;
            break;
//        case 38: // ITEM_PROPERTY_IMPROVED_EVASION                         = 38 ;
//            break;
//        case 39: // ITEM_PROPERTY_SPELL_RESISTANCE                         = 39 ;
//            break;
        case 40: // ITEM_PROPERTY_SAVING_THROW_BONUS                       = 40 ;
        case 49: // ITEM_PROPERTY_DECREASED_SAVING_THROWS                  = 49 ;
            switch(nSubPropertyNumber)
            {
                case 0:
                    sLast = "3: Saving Throw: Reflex";
                    sSelected = "0: <No Value>";
                    sNext = "1: Saving Throw: Fortitude";
                    break;
                case 1: // IP_CONST_SAVEBASETYPE_FORTITUDE             = 1;
                    sLast = "0: <No Value>";
                    sSelected = "1: Saving Throw: Fortitude";
                    sNext = "2: Saving Throw: Will";
                    break;
                case 2: // IP_CONST_SAVEBASETYPE_WILL                  = 2;
                    sLast = "1: Saving Throw: Fortitude";
                    sSelected = "2: Saving Throw: Will";
                    sNext = "3: Saving Throw: Reflex";
                    break;
                case 3: // IP_CONST_SAVEBASETYPE_REFLEX                = 3;
                    sLast = "2: Saving Throw: Will";
                    sSelected = "3: Saving Throw: Reflex";
                    sNext = "0: <No Value>";
                    break;
                }
            nSubPropertyMax = 3;
            break;
        case 41: // ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC              = 41 ;
        case 50: // ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC         = 50 ;
            switch(nSubPropertyNumber)
            {
                case 0: // IP_CONST_SAVEVS_UNIVERSAL                   = 0;
                    sLast = "13: Saving Throw: Sonic";
                    sSelected = "0: Saving Throw: Universal";
                    sNext = "1: Saving Throw: Acid";
                    break;
                case 1: // IP_CONST_SAVEVS_ACID                        = 1;
                    sLast = "0: Saving Throw: Universal";
                    sSelected = "1: Saving Throw: Acid";
                    sNext = "2: Saving Throw: Cold";
                    break;
                case 2: // IP_CONST_SAVEVS_COLD                        = 3;
                    sLast = "1: Saving Throw: Acid";
                    sSelected = "2: Saving Throw: Cold";
                    sNext = "3: Saving Throw: Death";
                    break;
                case 3: // IP_CONST_SAVEVS_DEATH                       = 4;
                    sLast = "2: Saving Throw: Cold";
                    sSelected = "3: Saving Throw: Death";
                    sNext = "4: Saving Throw: Disease";
                    break;
                case 4: // IP_CONST_SAVEVS_DISEASE                     = 5;
                    sLast = "3: Saving Throw: Death";
                    sSelected = "4: Saving Throw: Disease";
                    sNext = "5: Saving Throw: Divine";
                    break;
                case 5: // IP_CONST_SAVEVS_DIVINE                      = 6;
                    sLast = "4: Saving Throw: Disease";
                    sSelected = "5: Saving Throw: Divine";
                    sNext = "6: Saving Throw: Electrical";
                    break;
                case 6: // IP_CONST_SAVEVS_ELECTRICAL                  = 7;
                    sLast = "5: Saving Throw: Divine";
                    sSelected = "6: Saving Throw: Electrical";
                    sNext = "7: Saving Throw: Fear";
                    break;
                case 7: // IP_CONST_SAVEVS_FEAR                        = 8;
                    sLast = "6: Saving Throw: Electrical";
                    sSelected = "7: Saving Throw: Fear";
                    sNext = "8: Saving Throw: Fire";
                    break;
                case 8: // IP_CONST_SAVEVS_FIRE                        = 9;
                    sLast = "7: Saving Throw: Fear";
                    sSelected = "8: Saving Throw: Fire";
                    sNext = "9: Saving Throw: Mind Affecting";
                    break;
                case 9: // IP_CONST_SAVEVS_MINDAFFECTING               = 11;
                    sLast = "8: Saving Throw: Fire";
                    sSelected = "9: Saving Throw: Mind Affecting";
                    sNext = "10: Saving Throw: Negative";
                    break;
                case 10: // IP_CONST_SAVEVS_NEGATIVE                    = 12;
                    sLast = "9: Saving Throw: Mind Affecting";
                    sSelected = "10: Saving Throw: Negative";
                    sNext = "11: Saving Throw: Poison";
                    break;
                case 11: // IP_CONST_SAVEVS_POISON                      = 13;
                    sLast = "10: Saving Throw: Negative";
                    sSelected = "11: Saving Throw: Poison";
                    sNext = "12: Saving Throw: Positive";
                    break;
                case 12: // IP_CONST_SAVEVS_POSITIVE                    = 14;
                    sLast = "11: Saving Throw: Poison";
                    sSelected = "12: Saving Throw: Positive";
                    sNext = "13: Saving Throw: Sonic";
                    break;
                case 13: // IP_CONST_SAVEVS_SONIC                       = 15;
                    sLast = "12: Saving Throw: Positive";
                    sSelected = "13: Saving Throw: Sonic";
                    sNext = "0: Saving Throw: Universal";
                    break;
            }
            nSubPropertyMax = 13;
            break;
//        case 42: //
//            break;
//        case 43: // ITEM_PROPERTY_KEEN                                     = 43 ;
//            break;
        case 44: // ITEM_PROPERTY_LIGHT                                    = 44 ;
            switch(nSubPropertyNumber)
            {
                case 0: //
                    sLast = "4: Brightness: Bright";
                    sSelected = "0: <No Value>";
                    sNext = "1: Brightness: Dim";
                    break;
                case 1: // IP_CONST_LIGHTBRIGHTNESS_DIM                = 1;
                    sLast = "0: <No Value>";
                    sSelected = "1: Brightness: Dim";
                    sNext = "2: Brightness: Low";
                    break;
                case 2: // IP_CONST_LIGHTBRIGHTNESS_LOW                = 2;
                    sLast = "1: Brightness: Dim";
                    sSelected = "2: Brightness: Low";
                    sNext = "3: Brightness: Normal";
                    break;
                case 3: // IP_CONST_LIGHTBRIGHTNESS_NORMAL             = 3;
                    sLast = "2: Brightness: Low";
                    sSelected = "3: Brightness: Normal";
                    sNext = "4: Brightness: Bright";
                    break;
                case 4: // IP_CONST_LIGHTBRIGHTNESS_BRIGHT             = 4;
                    sLast = "3: Brightness: Normal";
                    sSelected = "4: Brightness: Bright";
                    sNext = "0: <No Value>";
                    break;
            }
            nSubPropertyMax = 4;
            break;
//        case 45: // ITEM_PROPERTY_MIGHTY        -=Max Strength Mod=-       = 45 ;
//            break;
        case 46: // ITEM_PROPERTY_MIND_BLANK                               = 46 ;
        case 66: // ITEM_PROPERTY_USE_LIMITATION_TILESET                   = 66 ;
        case 75: // ITEM_PROPERTY_FREEDOM_OF_MOVEMENT                      = 75 ;
            sLast = "COULD NOT FIND A WAY TO APPLY THIS PROPERTY";
            sSelected = "COULD NOT FIND A WAY TO APPLY THIS PROPERTY";
            sNext = "COULD NOT FIND A WAY TO APPLY THIS PROPERTY";
            break;
//        case 47: // ITEM_PROPERTY_NO_DAMAGE                                = 47 ;
//            break;
        case 48: // ITEM_PROPERTY_ON_HIT_PROPERTIES                        = 48 ;
        case 72: // ITEM_PROPERTY_ON_MONSTER_HIT                           = 72 ;
            switch(nSubPropertyNumber)
            {
                case 0: // IP_CONST_ONHIT_SLEEP                        = 0;
                    sLast = "24: OnHit: Wounding";
                    sSelected = "0: OnHit: Sleep";
                    sNext = "1: OnHit: Stun";
                    break;
                case 1: // IP_CONST_ONHIT_STUN                         = 1;
                    sLast = "0: OnHit: Sleep";
                    sSelected = "1: OnHit: Stun";
                    sNext = "2: OnHit: Hold";
                    break;
                case 2: // IP_CONST_ONHIT_HOLD                         = 2;
                    sLast = "1: OnHit: Stun";
                    sSelected = "2: OnHit: Hold";
                    sNext = "3: OnHit: Confusion";
                    break;
                case 3: // IP_CONST_ONHIT_CONFUSION                    = 3;
                    sLast = "2: OnHit: Hold";
                    sSelected = "3: OnHit: Confusion";
                    sNext = "4: OnHit: Daze";
                    break;
                case 4: // IP_CONST_ONHIT_DAZE                         = 5;
                    sLast = "3: OnHit: Confusion";
                    sSelected = "4: OnHit: Daze";
                    sNext = "5: OnHit: Doom";
                    break;
                case 5: // IP_CONST_ONHIT_DOOM                         = 6;
                    sLast = "4: OnHit: Daze";
                    sSelected = "5: OnHit: Doom";
                    sNext = "6: OnHit: Fear";
                    break;
                case 6: // IP_CONST_ONHIT_FEAR                         = 7;
                    sLast = "5: OnHit: Doom";
                    sSelected = "6: OnHit: Fear";
                    sNext = "7: OnHit: Knock";
                    break;
                case 7: // IP_CONST_ONHIT_KNOCK                        = 8;
                    sLast = "6: OnHit: Fear";
                    sSelected = "7: OnHit: Knock";
                    sNext = "8: OnHit: Slow";
                    break;
                case 8: // IP_CONST_ONHIT_SLOW                         = 9;
                    sLast = "7: OnHit: Knock";
                    sSelected = "8: OnHit: Slow";
                    sNext = "9: OnHit: Lesser Dispel";
                    break;
                case 9: // IP_CONST_ONHIT_LESSERDISPEL                 = 10;
                    sLast = "8: OnHit: Slow";
                    sSelected = "9: OnHit: Lesser Dispel";
                    sNext = "10: OnHit: Dispel Magic";
                    break;
                case 10: // IP_CONST_ONHIT_DISPELMAGIC                  = 11;
                    sLast = "9: OnHit: Lesser Dispel";
                    sSelected = "10: OnHit: Dispel Magic";
                    sNext = "11: OnHit: Greater Dispel";
                    break;
                case 11: // IP_CONST_ONHIT_GREATERDISPEL                = 12;
                    sLast = "10: OnHit: Dispel Magic";
                    sSelected = "11: OnHit: Greater Dispel";
                    sNext = "12: OnHit: Mordkainens Disjunction";
                    break;
                case 12: // IP_CONST_ONHIT_MORDSDISJUNCTION             = 13;
                    sLast = "11: OnHit: Greater Dispel";
                    sSelected = "12: OnHit: Mordkainens Disjunction";
                    sNext = "13: OnHit: Silence";
                    break;
                case 13: // IP_CONST_ONHIT_SILENCE                      = 14;
                    sLast = "12: OnHit: Mordkainens Disjunction";
                    sSelected = "13: OnHit: Silence";
                    sNext = "14: OnHit: Deafness";
                    break;
                case 14: // IP_CONST_ONHIT_DEAFNESS                     = 15;
                    sLast = "13: OnHit: Silence";
                    sSelected = "14: OnHit: Deafness";
                    sNext = "15: OnHit: Blindness";
                    break;
                case 15: // IP_CONST_ONHIT_BLINDNESS                    = 16;
                    sLast = "14: OnHit: Deafness";
                    sSelected = "15: OnHit: Blindness";
                    sNext = "16: OnHit: Level Drain";
                    break;
                case 16: // IP_CONST_ONHIT_LEVELDRAIN                   = 17;
                    sLast = "15: OnHit: Blindness";
                    sSelected = "16: OnHit: Level Drain";
                    sNext = "17: OnHit: Ability Drain";
                    break;
                case 17: // IP_CONST_ONHIT_ABILITYDRAIN                 = 18;
                    sLast = "16: OnHit: Level Drain";
                    sSelected = "17: OnHit: Ability Drain";
                    sNext = "18: OnHit: Poison";
                    break;
                case 18: // IP_CONST_ONHIT_ITEMPOISON                   = 19;
                    sLast = "17: OnHit: Ability Drain";
                    sSelected = "18: OnHit: Poison";
                    sNext = "19: OnHit: Disease";
                    break;
                case 19: // IP_CONST_ONHIT_DISEASE                      = 20;
                    sLast = "18: OnHit: Poison";
                    sSelected = "19: OnHit: Disease";
                    sNext = "20: OnHit: Slay Race";
                    break;
                case 20: // IP_CONST_ONHIT_SLAYRACE                     = 21;
                    sLast = "19: OnHit: Disease";
                    sSelected = "20: OnHit: Slay Race";
                    sNext = "21: OnHit: Slay Alignment Group";
                    break;
                case 21: // IP_CONST_ONHIT_SLAYALIGNMENTGROUP           = 22;
                    sLast = "20: OnHit: Slay Race";
                    sSelected = "21: OnHit: Slay Alignment Group";
                    sNext = "22: OnHit: Slay Alignment";
                    break;
                case 22: // IP_CONST_ONHIT_SLAYALIGNMENT                = 23;
                    sLast = "21: OnHit: Slay Alignment Group";
                    sSelected = "22: OnHit: Slay Alignment";
                    sNext = "23: OnHit: Vorpal";
                    break;
                case 23: // IP_CONST_ONHIT_VORPAL                       = 24;
                    sLast = "22: OnHit: Slay Alignment";
                    sSelected = "23: OnHit: Vorpal";
                    sNext = "24: OnHit: Wounding";
                    break;
                case 24: // IP_CONST_ONHIT_WOUNDING                     = 25;
                    sLast = "23: OnHit: Vorpal";
                    sSelected = "24: OnHit: Wounding";
                    sNext = "0: OnHit: Sleep";
                    break;
            }
            if (nSubPropertyNumber == 72 && nItemType != BASE_ITEM_CBLUDGWEAPON ||
                nSubPropertyNumber == 72 && nItemType != BASE_ITEM_CPIERCWEAPON ||
                nSubPropertyNumber == 72 && nItemType != BASE_ITEM_CREATUREITEM ||
                nSubPropertyNumber == 72 && nItemType != BASE_ITEM_CSLASHWEAPON ||
                nSubPropertyNumber == 72 && nItemType != BASE_ITEM_CSLSHPRCWEAP)
                nResult = FALSE;
            nSubPropertyMax = 24;
            break;
//        case 49: // ITEM_PROPERTY_DECREASED_SAVING_THROWS                  = 49 ;
//            break;
//        case 50: // ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC         = 50 ;
//            break;
//        case 51: // ITEM_PROPERTY_REGENERATION                             = 51 ;
//            break;
//        case 52: // ITEM_PROPERTY_SKILL_BONUS                              = 52 ;
//            break;
        case 53: // ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL                  = 53 ;
            switch(nSubPropertyNumber)
            {
                case 0: // IP_CONST_IMMUNITYSPELL_ACID_FOG                       = 0:
                    sLast = "187: Spell Immunity: Find Traps";
                    sSelected = "0: Spell Immunity: Acid Fog";
                    sNext = "1: Spell Immunity: Aid";
                    break;
                case 1: // IP_CONST_IMMUNITYSPELL_AID                            = 1:
                    sLast = "0: Spell Immunity: Acid Fog";
                    sSelected = "1: Spell Immunity: Aid";
                    sNext = "2: Spell Immunity: Barkskin";
                    break;
                case 2: // IP_CONST_IMMUNITYSPELL_BARKSKIN                       = 2:
                    sLast = "1: Spell Immunity: Aid";
                    sSelected = "2: Spell Immunity: Barkskin";
                    sNext = "3: Spell Immunity: Bestow Curse";
                    break;
                case 3: // IP_CONST_IMMUNITYSPELL_BESTOW_CURSE                   = 3:
                    sLast = "2: Spell Immunity: Barkskin";
                    sSelected = "3: Spell Immunity: Bestow Curse";
                    sNext = "4: <No Value>";
                    break;
                case 4:
                    sLast = "3: Spell Immunity: Bestow Curse";
                    sSelected = "4: <No Value>";
                    sNext = "5: <No Value>";
                    break;
                case 5:
                    sLast = "4: <No Value>";
                    sSelected = "5: <No Value>";
                    sNext = "6: Spell Immunity: Blindness/Deafness";
                    break;
                case 6: // IP_CONST_IMMUNITYSPELL_BLINDNESS_AND_DEAFNESS         = 6:
                    sLast = "5: <No Value>";
                    sSelected = "6: Spell Immunity: Blindness/Deafness";
                    sNext = "7: <No Value>";
                    break;
                case 7:
                    sLast = "6: Spell Immunity: Blindness/Deafness";
                    sSelected = "7: <No Value>";
                    sNext = "8: Spell Immunity: Burning Hands";
                    break;
                case 8: // IP_CONST_IMMUNITYSPELL_BURNING_HANDS                  = 8:
                    sLast = "7: <No Value>";
                    sSelected = "8: Spell Immunity: Burning Hands";
                    sNext = "9: Spell Immunity: Call Lightning";
                    break;
                case 9: // IP_CONST_IMMUNITYSPELL_CALL_LIGHTNING                 = 9:
                    sLast = "8: Spell Immunity: Burning Hands";
                    sSelected = "9: Spell Immunity: Call Lightning";
                    sNext = "10: <No Value>";
                    break;
                case 10:
                    sLast = "9: Spell Immunity: Call Lightning";
                    sSelected = "10: <No Value>";
                    sNext = "11: <No Value>";
                    break;
                case 11:
                    sLast = "10: <No Value>";
                    sSelected = "11: <No Value>";
                    sNext = "12: Spell Immunity: Chain Lightning";
                    break;
                case 12: // IP_CONST_IMMUNITYSPELL_CHAIN_LIGHTNING                = 12:
                    sLast = "11: <No Value>";
                    sSelected = "12: Spell Immunity: Chain Lightning";
                    sNext = "13: Spell Immunity: Charm Monster";
                    break;
                case 13: // IP_CONST_IMMUNITYSPELL_CHARM_MONSTER                  = 13:
                    sLast = "12: Spell Immunity: Chain Lightning";
                    sSelected = "13: Spell Immunity: Charm Monster";
                    sNext = "14: Spell Immunity: Charm Person";
                    break;
                case 14: // IP_CONST_IMMUNITYSPELL_CHARM_PERSON                   = 14:
                    sLast = "13: Spell Immunity: Charm Monster";
                    sSelected = "14: Spell Immunity: Charm Person";
                    sNext = "15: Spell Immunity: Charm Person or Animal";
                    break;
                case 15: // IP_CONST_IMMUNITYSPELL_CHARM_PERSON_OR_ANIMAL         = 15:
                    sLast = "14: Spell Immunity: Charm Person";
                    sSelected = "15: Spell Immunity: Charm Person or Animal";
                    sNext = "16: Spell Immunity: Circle of Death";
                    break;
                case 16: // IP_CONST_IMMUNITYSPELL_CIRCLE_OF_DEATH                = 16:
                    sLast = "15: Spell Immunity: Charm Person or Animal";
                    sSelected = "16: Spell Immunity: Circle of Death";
                    sNext = "17: Spell Immunity: Circle of Doom";
                    break;
                case 17: // IP_CONST_IMMUNITYSPELL_CIRCLE_OF_DOOM                 = 17:
                    sLast = "16: Spell Immunity: Circle of Death";
                    sSelected = "17: Spell Immunity: Circle of Doom";
                    sNext = "18: <No Value>";
                    break;
                case 18:
                    sLast = "17: Spell Immunity: Circle of Doom";
                    sSelected = "18: <No Value>";
                    sNext = "19: <No Value>";
                    break;
                case 19:
                    sLast = "18: <No Value>";
                    sSelected = "19: <No Value>";
                    sNext = "20: <No Value>";
                    break;
                case 20:
                    sLast = "19: <No Value>";
                    sSelected = "20: <No Value>";
                    sNext = "21: Spell Immunity: Cloudkill";
                    break;
                case 21: // IP_CONST_IMMUNITYSPELL_CLOUDKILL                      = 21:
                    sLast = "20: <No Value>";
                    sSelected = "21: Spell Immunity: Cloudkill";
                    sNext = "22: Spell Immunity: Color Spray";
                    break;
                case 22: // IP_CONST_IMMUNITYSPELL_COLOR_SPRAY                    = 22:
                    sLast = "21: Spell Immunity: Cloudkill";
                    sSelected = "22: Spell Immunity: Color Spray";
                    sNext = "23: Spell Immunity: Cone of Cold";
                    break;
                case 23: // IP_CONST_IMMUNITYSPELL_CONE_OF_COLD                   = 23:
                    sLast = "22: Spell Immunity: Color Spray";
                    sSelected = "23: Spell Immunity: Cone of Cold";
                    sNext = "24: Spell Immunity: Confusion";
                    break;
                case 24: // IP_CONST_IMMUNITYSPELL_CONFUSION                      = 24:
                    sLast = "23: Spell Immunity: Cone of Cold";
                    sSelected = "24: Spell Immunity: Confusion";
                    sNext = "25: Spell Immunity: Contagion";
                    break;
                case 25: // IP_CONST_IMMUNITYSPELL_CONTAGION                      = 25:
                    sLast = "24: Spell Immunity: Confusion";
                    sSelected = "25: Spell Immunity: Contagion";
                    sNext = "26: Spell Immunity: Control Undead";
                    break;
                case 26: // IP_CONST_IMMUNITYSPELL_CONTROL_UNDEAD                 = 26:
                    sLast = "25: Spell Immunity: Contagion";
                    sSelected = "26: Spell Immunity: Control Undead";
                    sNext = "27: Spell Immunity: Cure Critical Wounds";
                    break;
                case 27: // IP_CONST_IMMUNITYSPELL_CURE_CRITICAL_WOUNDS           = 27:
                    sLast = "26: Spell Immunity: Control Undead";
                    sSelected = "27: Spell Immunity: Cure Critical Wounds";
                    sNext = "28: Spell Immunity: Cure Light Wounds";
                    break;
                case 28: // IP_CONST_IMMUNITYSPELL_CURE_LIGHT_WOUNDS              = 28:
                    sLast = "27: Spell Immunity: Cure Critical Wounds";
                    sSelected = "28: Spell Immunity: Cure Light Wounds";
                    sNext = "29: Spell Immunity: Cure Minor Wounds";
                    break;
                case 29: // IP_CONST_IMMUNITYSPELL_CURE_MINOR_WOUNDS              = 29:
                    sLast = "28: Spell Immunity: Cure Light Wounds";
                    sSelected = "29: Spell Immunity: Cure Minor Wounds";
                    sNext = "30: Spell Immunity: Cure Moderate Wounds";
                    break;
                case 30: // IP_CONST_IMMUNITYSPELL_CURE_MODERATE_WOUNDS           = 30:
                    sLast = "29: Spell Immunity: Cure Minor Wounds";
                    sSelected = "30: Spell Immunity: Cure Moderate Wounds";
                    sNext = "31: Spell Immunity: Cure Serious Wounds";
                    break;
                case 31: // IP_CONST_IMMUNITYSPELL_CURE_SERIOUS_WOUNDS            = 31:
                    sLast = "30: Spell Immunity: Cure Moderate Wounds";
                    sSelected = "31: Spell Immunity: Cure Serious Wounds";
                    sNext = "32: Spell Immunity: Darkness";
                    break;
                case 32: // IP_CONST_IMMUNITYSPELL_DARKNESS                       = 32:
                    sLast = "31: Spell Immunity: Cure Serious Wounds";
                    sSelected = "32: Spell Immunity: Darkness";
                    sNext = "33: Spell Immunity: Daze";
                    break;
                case 33: // IP_CONST_IMMUNITYSPELL_DAZE                           = 33:
                    sLast = "32: Spell Immunity: Darkness";
                    sSelected = "33: Spell Immunity: Daze";
                    sNext = "34: Spell Immunity: Death Ward";
                    break;
                case 34: // IP_CONST_IMMUNITYSPELL_DEATH_WARD                     = 34:
                    sLast = "33: Spell Immunity: Daze";
                    sSelected = "34: Spell Immunity: Death Ward";
                    sNext = "35: Spell Immunity: Delayed Fireball Blast";
                    break;
                case 35: // IP_CONST_IMMUNITYSPELL_DELAYED_BLAST_FIREBALL         = 35:
                    sLast = "34: Spell Immunity: Death Ward";
                    sSelected = "35: Spell Immunity: Delayed Fireball Blast";
                    sNext = "36: Spell Immunity: Dismissal";
                    break;
                case 36: // IP_CONST_IMMUNITYSPELL_DISMISSAL                      = 36:
                    sLast = "35: Spell Immunity: Delayed Fireball Blast";
                    sSelected = "36: Spell Immunity: Dismissal";
                    sNext = "37: Spell Immunity: Dispel Magic";
                    break;
                case 37: // IP_CONST_IMMUNITYSPELL_DISPEL_MAGIC                   = 37:
                    sLast = "36: Spell Immunity: Dismissal";
                    sSelected = "37: Spell Immunity: Dispel Magic";
                    sNext = "38: <No Value>";
                    break;
                case 38:
                    sLast = "37: Spell Immunity: Dispel Magic";
                    sSelected = "38: <No Value>";
                    sNext = "39: Spell Immunity: Dominate Animal";
                    break;
                case 39: //IP_CONST_IMMUNITYSPELL_DOMINATE_ANIMAL                = 39:
                    sLast = "38: <No Value>";
                    sSelected = "39: Spell Immunity: Dominate Animal";
                    sNext = "40: Spell Immunity: Dominate Monster";
                    break;
                case 40: // IP_CONST_IMMUNITYSPELL_DOMINATE_MONSTER               = 40:
                    sLast = "39: Spell Immunity: Dominate Animal";
                    sSelected = "40: Spell Immunity: Dominate Monster";
                    sNext = "41: Spell Immunity: Dominate Person";
                    break;
                case 41: // IP_CONST_IMMUNITYSPELL_DOMINATE_PERSON                = 41:
                    sLast = "40: Spell Immunity: Dominate Monster";
                    sSelected = "41: Spell Immunity: Dominate Person";
                    sNext = "42: Spell Immunity: Doom";
                    break;
                case 42: // IP_CONST_IMMUNITYSPELL_DOOM                           = 42:
                    sLast = "41: Spell Immunity: Dominate Person";
                    sSelected = "42: Spell Immunity: Doom";
                    sNext = "43: <No Value>";
                    break;
                case 43:
                    sLast = "42: Spell Immunity: Doom";
                    sSelected = "43: <No Value>";
                    sNext = "44: <No Value>";
                    break;
                case 44:
                    sLast = "43: <No Value>";
                    sSelected = "44: <No Value>";
                    sNext = "45: <No Value>";
                    break;
                case 45:
                    sLast = "44: <No Value>";
                    sSelected = "45: <No Value>";
                    sNext = "46: Spell Immunity: Energy Drain";
                    break;
                case 46: // IP_CONST_IMMUNITYSPELL_ENERGY_DRAIN                   = 46:
                    sLast = "45: <No Value>";
                    sSelected = "46: Spell Immunity: Energy Drain";
                    sNext = "47: Spell Immunity: Enervation";
                    break;
                case 47: // IP_CONST_IMMUNITYSPELL_ENERVATION                     = 47:
                    sLast = "46: Spell Immunity: Energy Drain";
                    sSelected = "47: Spell Immunity: Enervation";
                    sNext = "48: Spell Immunity: Entangle";
                    break;
                case 48: // IP_CONST_IMMUNITYSPELL_ENTANGLE                       = 48:
                    sLast = "47: Spell Immunity: Enervation";
                    sSelected = "48: Spell Immunity: Entangle";
                    sNext = "49: Spell Immunity: Fear";
                    break;
                case 49: // IP_CONST_IMMUNITYSPELL_FEAR                           = 49:
                    sLast = "48: Spell Immunity: Entangle";
                    sSelected = "49: Spell Immunity: Fear";
                    sNext = "50: Spell Immunity: Feeblemind";
                    break;
                case 50: // IP_CONST_IMMUNITYSPELL_FEEBLEMIND                     = 50:
                    sLast = "49: Spell Immunity: Fear";
                    sSelected = "50: Spell Immunity: Feeblemind";
                    sNext = "51: Spell Immunity: Finger of Death";
                    break;
                case 51: // IP_CONST_IMMUNITYSPELL_FINGER_OF_DEATH                = 51:
                    sLast = "50: Spell Immunity: Feeblemind";
                    sSelected = "51: Spell Immunity: Finger of Death";
                    sNext = "52: Spell Immunity: Fire Storm";
                    break;
                case 52: // IP_CONST_IMMUNITYSPELL_FIRE_STORM                     = 52:
                    sLast = "51: Spell Immunity: Finger of Death";
                    sSelected = "52: Spell Immunity: Fire Storm";
                    sNext = "53: Spell Immunity: Fireball";
                    break;
                case 53: // IP_CONST_IMMUNITYSPELL_FIREBALL                       = 53:
                    sLast = "52: Spell Immunity: Fire Storm";
                    sSelected = "53: Spell Immunity: Fireball";
                    sNext = "54: Spell Immunity: Flame Arrow";
                    break;
                case 54: // IP_CONST_IMMUNITYSPELL_FLAME_ARROW                    = 54:
                    sLast = "53: Spell Immunity: Fireball";
                    sSelected = "54: Spell Immunity: Flame Arrow";
                    sNext = "55: Spell Immunity: Flame Lash";
                    break;
                case 55: // IP_CONST_IMMUNITYSPELL_FLAME_LASH                     = 55:
                    sLast = "54: Spell Immunity: Flame Arrow";
                    sSelected = "55: Spell Immunity: Flame Lash";
                    sNext = "56: Spell Immunity: Flame Strike";
                    break;
                case 56: // IP_CONST_IMMUNITYSPELL_FLAME_STRIKE                   = 56:
                    sLast = "55: Spell Immunity: Flame Lash";
                    sSelected = "56: Spell Immunity: Flame Strike";
                    sNext = "57: Spell Immunity: Freedom of Movement";
                    break;
                case 57: // IP_CONST_IMMUNITYSPELL_FREEDOM_OF_MOVEMENT            = 57:
                    sLast = "56: Spell Immunity: Flame Strike";
                    sSelected = "57: Spell Immunity: Freedom of Movement";
                    sNext = "58: <No Value>";
                    break;
                case 58:
                    sLast = "57: Spell Immunity: Freedom of Movement";
                    sSelected = "58: <No Value>";
                    sNext = "59: Spell Immunity: Grease";
                    break;
                case 59: // IP_CONST_IMMUNITYSPELL_GREASE                         = 59:
                    sLast = "58: <No Value>";
                    sSelected = "59: Spell Immunity: Grease";
                    sNext = "60: Spell Immunity: Greater Dispelling";
                    break;
                case 60: // IP_CONST_IMMUNITYSPELL_GREATER_DISPELLING             = 60:
                    sLast = "59: Spell Immunity: Grease";
                    sSelected = "60: Spell Immunity: Greater Dispelling";
                    sNext = "61: <No Value>";
                    break;
                case 61:
                    sLast = "60: Spell Immunity: Greater Dispelling";
                    sSelected = "61: <No Value>";
                    sNext = "62: Spell Immunity: Greater Planar Binding";
                    break;
                case 62: // IP_CONST_IMMUNITYSPELL_GREATER_PLANAR_BINDING         = 62:
                    sLast = "61: <No Value>";
                    sSelected = "62: Spell Immunity: Greater Planar Binding";
                    sNext = "63: <No Value>";
                    break;
                case 63:
                    sLast = "62: Spell Immunity: Greater Planar Binding";
                    sSelected = "63: <No Value>";
                    sNext = "64: Spell Immunity: Greater Shadow Conjuration";
                    break;
                case 64: // IP_CONST_IMMUNITYSPELL_GREATER_SHADOW_CONJURATION     = 64:
                    sLast = "63: <No Value>";
                    sSelected = "64: Spell Immunity: Greater Shadow Conjuration";
                    sNext = "65: Spell Immunity: Greater Spell Breach";
                    break;
                case 65: // IP_CONST_IMMUNITYSPELL_GREATER_SPELL_BREACH           = 65:
                    sLast = "64: Spell Immunity: Greater Shadow Conjuration";
                    sSelected = "65: Spell Immunity: Greater Spell Breach";
                    sNext = "66: <No Value>";
                    break;
                case 66:
                    sLast = "65: Spell Immunity: Greater Spell Breach";
                    sSelected = "66: <No Value>";
                    sNext = "67: <No Value>";
                    break;
                case 67:
                    sLast = "66: <No Value>";
                    sSelected = "67: <No Value>";
                    sNext = "68: Spell Immunity: Hammer of the Gods";
                    break;
                case 68: // IP_CONST_IMMUNITYSPELL_HAMMER_OF_THE_GODS             = 68:
                    sLast = "67: <No Value>";
                    sSelected = "68: Spell Immunity: Hammer of the Gods";
                    sNext = "69: Spell Immunity: Harm";
                    break;
                case 69: // IP_CONST_IMMUNITYSPELL_HARM                           = 69:
                    sLast = "68: Spell Immunity: Hammer of the Gods";
                    sSelected = "69: Spell Immunity: Harm";
                    sNext = "70: <No Value>";
                    break;
                case 70:
                    sLast = "69: Spell Immunity: Harm";
                    sSelected = "70: <No Value>";
                    sNext = "71: Spell Immunity: Heal";
                    break;
                case 71: // IP_CONST_IMMUNITYSPELL_HEAL                           = 71:
                    sLast = "70: <No Value>";
                    sSelected = "71: Spell Immunity: Heal";
                    sNext = "72: Spell Immunity: Healing Circle";
                    break;
                case 72: // IP_CONST_IMMUNITYSPELL_HEALING_CIRCLE                 = 72:
                    sLast = "71: Spell Immunity: Heal";
                    sSelected = "72: Spell Immunity: Healing Circle";
                    sNext = "73: Spell Immunity: Hold Animal";
                    break;
                case 73: // IP_CONST_IMMUNITYSPELL_HOLD_ANIMAL                    = 73:
                    sLast = "72: Spell Immunity: Healing Circle";
                    sSelected = "73: Spell Immunity: Hold Animal";
                    sNext = "74: Spell Immunity: Hold Monster";
                    break;
                case 74: // IP_CONST_IMMUNITYSPELL_HOLD_MONSTER                   = 74:
                    sLast = "73: Spell Immunity: Hold Animal";
                    sSelected = "74: Spell Immunity: Hold Monster";
                    sNext = "75: Spell Immunity: Hold Person";
                    break;
                case 75: // IP_CONST_IMMUNITYSPELL_HOLD_PERSON                    = 75:
                    sLast = "74: Spell Immunity: Hold Monster";
                    sSelected = "75: Spell Immunity: Hold Person";
                    sNext = "76: <No Value>";
                    break;
                case 76:
                    sLast = "75: Spell Immunity: Hold Person";
                    sSelected = "76: <No Value>";
                    sNext = "77: <No Value>";
                    break;
                case 77:
                    sLast = "76: <No Value>";
                    sSelected = "77: <No Value>";
                    sNext = "78: Spell Immunity: Implosion";
                    break;
                case 78: // IP_CONST_IMMUNITYSPELL_IMPLOSION                      = 78:
                    sLast = "77: <No Value>";
                    sSelected = "78: Spell Immunity: Implosion";
                    sNext = "79: Spell Immunity: Invisibility";
                    break;
                case 79: // IP_CONST_IMMUNITYSPELL_IMPROVED_INVISIBILITY          = 79:
                    sLast = "78: Spell Immunity: Implosion";
                    sSelected = "79: Spell Immunity: Invisibility";
                    sNext = "80: Spell Immunity: Incendiary Cloud";
                    break;
                case 80: // IP_CONST_IMMUNITYSPELL_INCENDIARY_CLOUD               = 80:
                    sLast = "79: Spell Immunity: Invisibility";
                    sSelected = "80: Spell Immunity: Incendiary Cloud";
                    sNext = "81: <No Value>";
                    break;
                case 81:
                    sLast = "80: Spell Immunity: Incendiary Cloud";
                    sSelected = "81: <No Value>";
                    sNext = "82: Spell Immunity: Invisibility Purge";
                    break;
                case 82: // IP_CONST_IMMUNITYSPELL_INVISIBILITY_PURGE             = 82:
                    sLast = "81: <No Value>";
                    sSelected = "82: Spell Immunity: Invisibility Purge";
                    sNext = "83: <No Value>";
                    break;
                case 83:
                    sLast = "82: Spell Immunity: Invisibility Purge";
                    sSelected = "83: <No Value>";
                    sNext = "84: Spell Immunity: Lesser Dispel";
                    break;
                case 84: // IP_CONST_IMMUNITYSPELL_LESSER_DISPEL                  = 84:
                    sLast = "83: <No Value>";
                    sSelected = "84: Spell Immunity: Lesser Dispel";
                    sNext = "85: <No Value>";
                    break;
                case 85:
                    sLast = "84: Spell Immunity: Lesser Dispel";
                    sSelected = "85: <No Value>";
                    sNext = "86: Spell Immunity: Lesser Planar Binding";
                    break;
                case 86: // IP_CONST_IMMUNITYSPELL_LESSER_PLANAR_BINDING          = 86:
                    sLast = "85: <No Value>";
                    sSelected = "86: Spell Immunity: Lesser Planar Binding";
                    sNext = "87: <No Value>";
                    break;
                case 87:
                    sLast = "86: Spell Immunity: Lesser Planar Binding";
                    sSelected = "87: <No Value>";
                    sNext = "88: Spell Immunity: Lesser Spell Breach";
                    break;
                case 88: // IP_CONST_IMMUNITYSPELL_LESSER_SPELL_BREACH            = 88:
                    sLast = "87: <No Value>";
                    sSelected = "88: Spell Immunity: Lesser Spell Breach";
                    sNext = "89: <No Value>";
                    break;
                case 89:
                    sLast = "88: Spell Immunity: Lesser Spell Breach";
                    sSelected = "89: <No Value>";
                    sNext = "90: <No Value>";
                    break;
                case 90:
                    sLast = "89: <No Value>";
                    sSelected = "90: <No Value>";
                    sNext = "91: Spell Immunity: Lightning Bolt";
                    break;
                case 91: // IP_CONST_IMMUNITYSPELL_LIGHTNING_BOLT                 = 91:
                    sLast = "90: <No Value>";
                    sSelected = "91: Spell Immunity: Lightning Bolt";
                    sNext = "92: <No Value>";
                    break;
                case 92:
                    sLast = "91: Spell Immunity: Lightning Bolt";
                    sSelected = "92: <No Value>";
                    sNext = "93: <No Value>";
                    break;
                case 93:
                    sLast = "92: <No Value>";
                    sSelected = "93: <No Value>";
                    sNext = "94: <No Value>";
                    break;
                case 94:
                    sLast = "93: <No Value>";
                    sSelected = "94: <No Value>";
                    sNext = "95: <No Value>";
                    break;
                case 95:
                    sLast = "94: <No Value>";
                    sSelected = "95: <No Value>";
                    sNext = "96: <No Value>";
                    break;
                case 96:
                    sLast = "95: <No Value>";
                    sSelected = "96: <No Value>";
                    sNext = "97: Spell Immunity: Magic Missile";
                    break;
                case 97: // IP_CONST_IMMUNITYSPELL_MAGIC_MISSILE                  = 97:
                    sLast = "96: <No Value>";
                    sSelected = "97: Spell Immunity: Magic Missile";
                    sNext = "98: <No Value>";
                    break;
                case 98:
                    sLast = "97: Spell Immunity: Magic Missile";
                    sSelected = "98: <No Value>";
                    sNext = "99: <No Value>";
                    break;
                case 99:
                    sLast = "98: <No Value>";
                    sSelected = "99: <No Value>";
                    sNext = "100: Spell Immunity: Mass Blindness/Deafness";
                    break;
                case 100: // IP_CONST_IMMUNITYSPELL_MASS_BLINDNESS_AND_DEAFNESS    = 100:
                    sLast = "99: <No Value>";
                    sSelected = "100: Spell Immunity: Mass Blindness/Deafness";
                    sNext = "101: Spell Immunity: Mass Charm";
                    break;
                case 101: // IP_CONST_IMMUNITYSPELL_MASS_CHARM                     = 101:
                    sLast = "100: Spell Immunity: Mass Blindness/Deafness";
                    sSelected = "101: Spell Immunity: Mass Charm";
                    sNext = "102: <No Value>";
                    break;
                case 102:
                    sLast = "101: Spell Immunity: Mass Charm";
                    sSelected = "102: <No Value>";
                    sNext = "103: <No Value>";
                    break;
                case 103:
                    sLast = "102: <No Value>";
                    sSelected = "103: <No Value>";
                    sNext = "104: Spell Immunity: Mass Heal";
                    break;
                case 104: // IP_CONST_IMMUNITYSPELL_MASS_HEAL                      = 104:
                    sLast = "103: <No Value>";
                    sSelected = "104: Spell Immunity: Mass Heal";
                    sNext = "105: Spell Immunity: Melfs Acid Arrow";
                    break;
                case 105: // IP_CONST_IMMUNITYSPELL_MELFS_ACID_ARROW               = 105:
                    sLast = "104: Spell Immunity: Mass Heal";
                    sSelected = "105: Spell Immunity: Melfs Acid Arrow";
                    sNext = "106: Spell Immunity: Meteor Swarm";
                    break;
                case 106: // IP_CONST_IMMUNITYSPELL_METEOR_SWARM                   = 106:
                    sLast = "105: Spell Immunity: Melfs Acid Arrow";
                    sSelected = "106: Spell Immunity: Meteor Swarm";
                    sNext = "107: <No Value>";
                    break;
                case 107:
                    sLast = "106: Spell Immunity: Meteor Swarm";
                    sSelected = "107: <No Value>";
                    sNext = "108: Spell Immunity: Mind Fog";
                    break;
                case 108: // IP_CONST_IMMUNITYSPELL_MIND_FOG                       = 108:
                    sLast = "107: <No Value>";
                    sSelected = "108: Spell Immunity: Mind Fog";
                    sNext = "109: <No Value>";
                    break;
                case 109:
                    sLast = "108: Spell Immunity: Mind Fog";
                    sSelected = "109: <No Value>";
                    sNext = "110: <No Value>";
                    break;
                case 110:
                    sLast = "109: <No Value>";
                    sSelected = "110: <No Value>";
                    sNext = "111: <No Value>";
                    break;
                case 111:
                    sLast = "110: <No Value>";
                    sSelected = "111: <No Value>";
                    sNext = "112: Spell Immunity: Mordenkainens Disjunction";
                    break;
                case 112: // IP_CONST_IMMUNITYSPELL_MORDENKAINENS_DISJUNCTION      = 112:
                    sLast = "111: <No Value>";
                    sSelected = "112: Spell Immunity: Mordenkainens Disjunction";
                    sNext = "113: <No Value>";
                    break;
                case 113:
                    sLast = "112: Spell Immunity: Mordenkainens Disjunction";
                    sSelected = "113: <No Value>";
                    sNext = "114: <No Value>";
                    break;
                case 114:
                    sLast = "113: <No Value>";
                    sSelected = "114: <No Value>";
                    sNext = "115: <No Value>";
                    break;
                case 115:
                    sLast = "114: <No Value>";
                    sSelected = "115: <No Value>";
                    sNext = "116: Spell Immunity: Phantasmal Killer";
                    break;
                case 116: // IP_CONST_IMMUNITYSPELL_PHANTASMAL_KILLER              = 116:
                    sLast = "115: <No Value>";
                    sSelected = "116: Spell Immunity: Phantasmal Killer";
                    sNext = "117: Spell Immunity: Planar Binding";
                    break;
                case 117: // IP_CONST_IMMUNITYSPELL_PLANAR_BINDING                 = 117:
                    sLast = "116: Spell Immunity: Phantasmal Killer";
                    sSelected = "117: Spell Immunity: Planar Binding";
                    sNext = "118: Spell Immunity: Poison";
                    break;
                case 118: // IP_CONST_IMMUNITYSPELL_POISON                         = 118:
                    sLast = "117: Spell Immunity: Planar Binding";
                    sSelected = "118: Spell Immunity: Poison";
                    sNext = "119: <No Value>";
                    break;
                case 119:
                    sLast = "118: Spell Immunity: Poison";
                    sSelected = "119: <No Value>";
                    sNext = "120: Spell Immunity: Power Word Kill";
                    break;
                case 120: // IP_CONST_IMMUNITYSPELL_POWER_WORD_KILL                = 120:
                    sLast = "119: <No Value>";
                    sSelected = "120: Spell Immunity: Power Word Kill";
                    sNext = "121: Spell Immunity: Power Word Stun";
                    break;
                case 121: // IP_CONST_IMMUNITYSPELL_POWER_WORD_STUN                = 121:
                    sLast = "120: Spell Immunity: Power Word Kill";
                    sSelected = "121: Spell Immunity: Power Word Stun";
                    sNext = "122: <No Value>";
                    break;
                case 122:
                    sLast = "121: Spell Immunity: Power Word Stun";
                    sSelected = "122: <No Value>";
                    sNext = "123: <No Value>";
                    break;
                case 123:
                    sLast = "122: <No Value>";
                    sSelected = "123: <No Value>";
                    sNext = "124: Spell Immunity: Prismatic Spray";
                    break;
                case 124: // IP_CONST_IMMUNITYSPELL_PRISMATIC_SPRAY                = 124:
                    sLast = "123: <No Value>";
                    sSelected = "124: Spell Immunity: Prismatic Spray";
                    sNext = "125: <No Value>";
                    break;
                case 125:
                    sLast = "124: Spell Immunity: Prismatic Spray";
                    sSelected = "125: <No Value>";
                    sNext = "126: <No Value>";
                    break;
                case 126:
                    sLast = "125: <No Value>";
                    sSelected = "126: <No Value>";
                    sNext = "127: <No Value>";
                    break;
                case 127:
                    sLast = "126: <No Value>";
                    sSelected = "127: <No Value>";
                    sNext = "128: <No Value>";
                    break;
                case 128:
                    sLast = "127: <No Value>";
                    sSelected = "128: <No Value>";
                    sNext = "129: <No Value>";
                    break;
                case 129:
                    sLast = "128: <No Value>";
                    sSelected = "129: <No Value>";
                    sNext = "130: <No Value>";
                    break;
                case 130:
                    sLast = "129: <No Value>";
                    sSelected = "130: <No Value>";
                    sNext = "131: Spell Immunity: Ray of Enfeeblement";
                    break;
                case 131: // IP_CONST_IMMUNITYSPELL_RAY_OF_ENFEEBLEMENT            = 131:
                    sLast = "130: <No Value>";
                    sSelected = "131: Spell Immunity: Ray of Enfeeblement";
                    sNext = "132: Spell Immunity: Ray of Frost";
                    break;
                case 132: // IP_CONST_IMMUNITYSPELL_RAY_OF_FROST                   = 132:
                    sLast = "131: Spell Immunity: Ray of Enfeeblement";
                    sSelected = "132: Spell Immunity: Ray of Frost";
                    sNext = "133: <No Value>";
                    break;
                case 133:
                    sLast = "132: Spell Immunity: Ray of Frost";
                    sSelected = "133: <No Value>";
                    sNext = "134: <No Value>";
                    break;
                case 134:
                    sLast = "133: <No Value>";
                    sSelected = "134: <No Value>";
                    sNext = "135: <No Value>";
                    break;
                case 135:
                    sLast = "134: <No Value>";
                    sSelected = "135: <No Value>";
                    sNext = "136: <No Value>";
                    break;
                case 136:
                    sLast = "135: <No Value>";
                    sSelected = "136: <No Value>";
                    sNext = "137: <No Value>";
                    break;
                case 137:
                    sLast = "136: <No Value>";
                    sSelected = "137: <No Value>";
                    sNext = "138 <No Value>";
                    break;
                case 138:
                    sLast = "137: <No Value>";
                    sSelected = "138 <No Value>";
                    sNext = "139 <No Value>";
                    break;
                case 139:
                    sLast = "138 <No Value>";
                    sSelected = "139 <No Value>";
                    sNext = "140 <No Value>";
                    break;
                case 140:
                    sLast = "139 <No Value>";
                    sSelected = "140 <No Value>";
                    sNext = "141 <No Value>";
                    break;
                case 141:
                    sLast = "140 <No Value>";
                    sSelected = "141 <No Value>";
                    sNext = "142: Spell Immunity: Scare";
                    break;
                case 142: // IP_CONST_IMMUNITYSPELL_SCARE                          = 142:
                    sLast = "141 <No Value>";
                    sSelected = "142: Spell Immunity: Scare";
                    sNext = "143: Spell Immunity: Searing Light";
                    break;
                case 143: // IP_CONST_IMMUNITYSPELL_SEARING_LIGHT                  = 143:
                    sLast = "142: Spell Immunity: Scare";
                    sSelected = "143: Spell Immunity: Searing Light";
                    sNext = "144 <No Value>";
                    break;
                case 144:
                    sLast = "143: Spell Immunity: Searing Light";
                    sSelected = "144 <No Value>";
                    sNext = "145: Spell Immunity: Shades";
                    break;
                case 145: // IP_CONST_IMMUNITYSPELL_SHADES                         = 145:
                    sLast = "144 <No Value>";
                    sSelected = "145: Spell Immunity: Shades";
                    sNext = "146: Spell Immunity: Shadow Conjuration";
                    break;
                case 146: // IP_CONST_IMMUNITYSPELL_SHADOW_CONJURATION             = 146:
                    sLast = "145: Spell Immunity: Shades";
                    sSelected = "146: Spell Immunity: Shadow Conjuration";
                    sNext = "147 <No Value>";
                    break;
                case 147:
                    sLast = "146: Spell Immunity: Shadow Conjuration";
                    sSelected = "147 <No Value>";
                    sNext = "148 <No Value>";
                    break;
                case 148:
                    sLast = "147 <No Value>";
                    sSelected = "148 <No Value>";
                    sNext = "149 <No Value>";
                    break;
                case 149:
                    sLast = "148 <No Value>";
                    sSelected = "149 <No Value>";
                    sNext = "150: Spell Immunity: Silence";
                    break;
                case 150: // IP_CONST_IMMUNITYSPELL_SILENCE                        = 150:
                    sLast = "149 <No Value>";
                    sSelected = "150: Spell Immunity: Silence";
                    sNext = "151: Spell Immunity: Slay Living";
                    break;
                case 151: // IP_CONST_IMMUNITYSPELL_SLAY_LIVING                    = 151:
                    sLast = "150: Spell Immunity: Silence";
                    sSelected = "151: Spell Immunity: Slay Living";
                    sNext = "152: Spell Immunity: Sleep";
                    break;
                case 152: // IP_CONST_IMMUNITYSPELL_SLEEP                          = 152:
                    sLast = "151: Spell Immunity: Slay Living";
                    sSelected = "152: Spell Immunity: Sleep";
                    sNext = "153: Spell Immunity: Slow";
                    break;
                case 153: // IP_CONST_IMMUNITYSPELL_SLOW                           = 153:
                    sLast = "152: Spell Immunity: Sleep";
                    sSelected = "153: Spell Immunity: Slow";
                    sNext = "154: Spell Immunity: Sound Burst";
                    break;
                case 154: // IP_CONST_IMMUNITYSPELL_SOUND_BURST                    = 154:
                    sLast = "153: Spell Immunity: Slow";
                    sSelected = "154: Spell Immunity: Sound Burst";
                    sNext = "155: <No Value>";
                    break;
                case 155:
                    sLast = "154: Spell Immunity: Sound Burst";
                    sSelected = "155: <No Value>";
                    sNext = "156: <No Value>";
                    break;
                case 156:
                    sLast = "155: <No Value>";
                    sSelected = "156: <No Value>";
                    sNext = "157: <No Value>";
                    break;
                case 157:
                    sLast = "156: <No Value>";
                    sSelected = "157: <No Value>";
                    sNext = "158: Spell Immunity: Stinking Cloud";
                    break;
                case 158: // IP_CONST_IMMUNITYSPELL_STINKING_CLOUD                 = 158:
                    sLast = "157: <No Value>";
                    sSelected = "158: Spell Immunity: Stinking Cloud";
                    sNext = "159: Spell Immunity: Stoneskin";
                    break;
                case 159: // IP_CONST_IMMUNITYSPELL_STONESKIN                      = 159:
                    sLast = "158: Spell Immunity: Stinking Cloud";
                    sSelected = "159: Spell Immunity: Stoneskin";
                    sNext = "160: Spell Immunity: Storm of Vengeance";
                    break;
                case 160: // IP_CONST_IMMUNITYSPELL_STORM_OF_VENGEANCE             = 160:
                    sLast = "159: Spell Immunity: Stoneskin";
                    sSelected = "160: Spell Immunity: Storm of Vengeance";
                    sNext = "161: Spell Immunity: Sunbeam";
                    break;
                case 161: // IP_CONST_IMMUNITYSPELL_SUNBEAM                        = 161:
                    sLast = "160: Spell Immunity: Storm of Vengeance";
                    sSelected = "161: Spell Immunity: Sunbeam";
                    sNext = "162: <No Value>";
                    break;
                case 162:
                    sLast = "161: Spell Immunity: Sunbeam";
                    sSelected = "162: <No Value>";
                    sNext = "163: <No Value>";
                    break;
                case 163:
                    sLast = "162: <No Value>";
                    sSelected = "163: <No Value>";
                    sNext = "164: <No Value>";
                    break;
                case 164:
                    sLast = "163: <No Value>";
                    sSelected = "164: <No Value>";
                    sNext = "165: Spell Immunity: Virtue";
                    break;
                case 165: // IP_CONST_IMMUNITYSPELL_VIRTUE                         = 165:
                    sLast = "164: <No Value>";
                    sSelected = "165: Spell Immunity: Virtue";
                    sNext = "166: Spell Immunity: Wail of the Banshee";
                    break;
                case 166: // IP_CONST_IMMUNITYSPELL_WAIL_OF_THE_BANSHEE            = 166:
                    sLast = "165: Spell Immunity: Virtue";
                    sSelected = "166: Spell Immunity: Wail of the Banshee";
                    sNext = "167: Spell Immunity: Web";
                    break;
                case 167: // IP_CONST_IMMUNITYSPELL_WEB                            = 167:
                    sLast = "166: Spell Immunity: Wail of the Banshee";
                    sSelected = "167: Spell Immunity: Web";
                    sNext = "168: Spell Immunity: Weird";
                    break;
                case 168: // IP_CONST_IMMUNITYSPELL_WEIRD                          = 168:
                    sLast = "167: Spell Immunity: Web";
                    sSelected = "168: Spell Immunity: Weird";
                    sNext = "169: Spell Immunity: Word of Faith";
                    break;
                case 169: // IP_CONST_IMMUNITYSPELL_WORD_OF_FAITH                  = 169:
                    sLast = "168: Spell Immunity: Weird";
                    sSelected = "169: Spell Immunity: Word of Faith";
                    sNext = "170: <No Value>";
                    break;
                case 170:
                    sLast = "169: Spell Immunity: Word of Faith";
                    sSelected = "170: <No Value>";
                    sNext = "171: Spell Immunity: Magic Circle Against Alignment";
                    break;
                case 171: // IP_CONST_IMMUNITYSPELL_MAGIC_CIRCLE_AGAINST_ALIGNMENT = 171:
                    sLast = "170: <No Value>";
                    sSelected = "171: Spell Immunity: Magic Circle Against Alignment";
                    sNext = "172: <No Value>";
                    break;
                case 172:
                    sLast = "171: Spell Immunity: Magic Circle Against Alignment";
                    sSelected = "172: <No Value>";
                    sNext = "173: Spell Immunity: Eagle Spledor";
                    break;
                case 173: // IP_CONST_IMMUNITYSPELL_EAGLE_SPLEDOR                  = 173:
                    sLast = "172: <No Value>";
                    sSelected = "173: Spell Immunity: Eagle Spledor";
                    sNext = "174: Spell Immunity: Owls Wisdom";
                    break;
                case 174: // IP_CONST_IMMUNITYSPELL_OWLS_WISDOM                    = 174:
                    sLast = "173: Spell Immunity: Eagle Spledor";
                    sSelected = "174: Spell Immunity: Owls Wisdom";
                    sNext = "175: Spell Immunity: Foxs Cunning";
                    break;
                case 175: // IP_CONST_IMMUNITYSPELL_FOXS_CUNNING                   = 175:
                    sLast = "174: Spell Immunity: Owls Wisdom";
                    sSelected = "175: Spell Immunity: Foxs Cunning";
                    sNext = "176: Spell Immunity: Greater Eagles Splendor";
                    break;
                case 176: // IP_CONST_IMMUNITYSPELL_GREATER_EAGLES_SPLENDOR        = 176:
                    sLast = "175: Spell Immunity: Foxs Cunning";
                    sSelected = "176: Spell Immunity: Greater Eagles Splendor";
                    sNext = "177: Spell Immunity: Greater Owls Wisdom";
                    break;
                case 177: // IP_CONST_IMMUNITYSPELL_GREATER_OWLS_WISDOM            = 177:
                    sLast = "176: Spell Immunity: Greater Eagles Splendor";
                    sSelected = "177: Spell Immunity: Greater Owls Wisdom";
                    sNext = "178: Spell Immunity: Greater Foxs Cunning";
                    break;
                case 178: // IP_CONST_IMMUNITYSPELL_GREATER_FOXS_CUNNING           = 178:
                    sLast = "177: Spell Immunity: Greater Owls Wisdom";
                    sSelected = "178: Spell Immunity: Greater Foxs Cunning";
                    sNext = "179: Spell Immunity: Greater Bulls Strength";
                    break;
                case 179: // IP_CONST_IMMUNITYSPELL_GREATER_BULLS_STRENGTH         = 179:
                    sLast = "178: Spell Immunity: Greater Foxs Cunning";
                    sSelected = "179: Spell Immunity: Greater Bulls Strength";
                    sNext = "180: Spell Immunity: Greater Cats Grace";
                    break;
                case 180: // IP_CONST_IMMUNITYSPELL_GREATER_CATS_GRACE             = 180:
                    sLast = "179: Spell Immunity: Greater Bulls Strength";
                    sSelected = "180: Spell Immunity: Greater Cats Grace";
                    sNext = "181: Spell Immunity: Greater Endurance";
                    break;
                case 181: // IP_CONST_IMMUNITYSPELL_GREATER_ENDURANCE              = 181:
                    sLast = "180: Spell Immunity: Greater Cats Grace";
                    sSelected = "181: Spell Immunity: Greater Endurance";
                    sNext = "182: Spell Immunity: Aura of Vitality";
                    break;
                case 182: // IP_CONST_IMMUNITYSPELL_AURA_OF_VITALITY               = 182:
                    sLast = "181: Spell Immunity: Greater Endurance";
                    sSelected = "182: Spell Immunity: Aura of Vitality";
                    sNext = "183: Spell Immunity: War Cry";
                    break;
                case 183: // IP_CONST_IMMUNITYSPELL_WAR_CRY                        = 183:
                    sLast = "182: Spell Immunity: Aura of Vitality";
                    sSelected = "183: Spell Immunity: War Cry";
                    sNext = "184: Spell Immunity: Regenerate";
                    break;
                case 184: // IP_CONST_IMMUNITYSPELL_REGENERATE                     = 184:
                    sLast = "183: Spell Immunity: War Cry";
                    sSelected = "184: Spell Immunity: Regenerate";
                    sNext = "185: Spell Immunity: Evards Black Tentacles";
                    break;
                case 185: // IP_CONST_IMMUNITYSPELL_EVARDS_BLACK_TENTACLES         = 185:
                    sLast = "184: Spell Immunity: Regenerate";
                    sSelected = "185: Spell Immunity: Evards Black Tentacles";
                    sNext = "186: Spell Immunity: Legend Lore";
                    break;
                case 186: // IP_CONST_IMMUNITYSPELL_LEGEND_LORE                    = 186:
                    sLast = "185: Spell Immunity: Evards Black Tentacles";
                    sSelected = "186: Spell Immunity: Legend Lore";
                    sNext = "187: Spell Immunity: Find Traps";
                    break;
                case 187: // IP_CONST_IMMUNITYSPELL_FIND_TRAPS                     = 187:
                    sLast = "186: Spell Immunity: Legend Lore";
                    sSelected = "187: Spell Immunity: Find Traps";
                    sNext = "0: Spell Immunity: Acid Fog";
                    break;
            }
            nSubPropertyMax = 187;
            break;
        case 54: // ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL                    = 54 ;
            switch(nSubPropertyNumber)
            {
                case 0: // IP_CONST_SPELLSCHOOL_ABJURATION                     = 0;
                    sLast = "7: Spell Immunity School: Transmutation";
                    sSelected = "0: Spell Immunity School: Abjuration";
                    sNext = "1: Spell Immunity School: Conjuration";
                    break;
                case 1: // IP_CONST_SPELLSCHOOL_CONJURATION                    = 1;
                    sLast = "0: Spell Immunity School: Abjuration";
                    sSelected = "1: Spell Immunity School: Conjuration";
                    sNext = "2: Spell Immunity School: Divination";
                    break;
                case 2: // IP_CONST_SPELLSCHOOL_DIVINATION                     = 2;
                    sLast = "1: Spell Immunity School: Conjuration";
                    sSelected = "2: Spell Immunity School: Divination";
                    sNext = "3: Spell Immunity School: Enchantment";
                    break;
                case 3: // IP_CONST_SPELLSCHOOL_ENCHANTMENT                    = 3;
                    sLast = "2: Spell Immunity School: Divination";
                    sSelected = "3: Spell Immunity School: Enchantment";
                    sNext = "4: Spell Immunity School: Evocation";
                    break;
                case 4: // IP_CONST_SPELLSCHOOL_EVOCATION                      = 4;
                    sLast = "3: Spell Immunity School: Enchantment";
                    sSelected = "4: Spell Immunity School: Evocation";
                    sNext = "5: Spell Immunity School: Illusion";
                    break;
                case 5: // IP_CONST_SPELLSCHOOL_ILLUSION                       = 5;
                    sLast = "4: Spell Immunity School: Evocation";
                    sSelected = "5: Spell Immunity School: Illusion";
                    sNext = "6: Spell Immunity School: Necromancy";
                    break;
                case 6: // IP_CONST_SPELLSCHOOL_NECROMANCY                     = 6;
                    sLast = "5: Spell Immunity School: Illusion";
                    sSelected = "6: Spell Immunity School: Necromancy";
                    sNext = "7: Spell Immunity School: Transmutation";
                    break;
                case 7: // IP_CONST_SPELLSCHOOL_TRANSMUTATION                  = 7;
                    sLast = "6: Spell Immunity School: Necromancy";
                    sSelected = "7: Spell Immunity School: Transmutation";
                    sNext = "0: Spell Immunity School: Abjuration";
                    break;
            }
            nSubPropertyMax = 7;
            break;
//        case 55: // ITEM_PROPERTY_THIEVES_TOOLS                            = 55 ;
//            break;
//        case 56: // ITEM_PROPERTY_ATTACK_BONUS                             = 56 ;
//            break;
//        case 57: // ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP          = 57 ;
//            break;
//        case 58: // ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP             = 58 ;
//            break;
//        case 59: // ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT       = 59 ;
//            break;
//        case 60: // ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER                = 60 ;
//            break;
//        case 61: // ITEM_PROPERTY_UNLIMITED_AMMUNITION                     = 61 ;
//            break;
//        case 62: // ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP           = 62 ;
//            break;
//        case 63: // ITEM_PROPERTY_USE_LIMITATION_CLASS                     = 63 ;
//            break;
//        case 64: // ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE               = 64 ;
//            break;
//        case 65: // ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT        = 65 ;
//            break;
//        case 66: // ITEM_PROPERTY_USE_LIMITATION_TILESET                   = 66 ;
//            break;
//        case 67: // ITEM_PROPERTY_REGENERATION_VAMPIRIC                    = 67 ;
//            break;
//        case 68: //
//            break;
//        case 69: //
//            break;
        case 70: // ITEM_PROPERTY_TRAP                                     = 70 ;
            switch(nSubPropertyNumber)
            {
                case 0: // IP_CONST_TRAPSTRENGTH_MINOR                         = 0;
                    sLast = "3: Trap Strength: Deadly";
                    sSelected = "0: Trap Strength: Minor";
                    sNext = "1: Trap Strength: Average";
                    break;
                case 1: // IP_CONST_TRAPSTRENGTH_AVERAGE                       = 1;
                    sLast = "0: Trap Strength: Minor";
                    sSelected = "1: Trap Strength: Average";
                    sNext = "2: Trap Strength: Strong";
                    break;
                case 2: // IP_CONST_TRAPSTRENGTH_STRONG                        = 2;
                    sLast = "1: Trap Strength: Average";
                    sSelected = "2: Trap Strength: Strong";
                    sNext = "3: Trap Strength: Deadly";
                    break;
                case 3: // IP_CONST_TRAPSTRENGTH_DEADLY                        = 3;
                    sLast = "2: Trap Strength: Strong";
                    sSelected = "3: Trap Strength: Deadly";
                    sNext = "0: Trap Strength: Minor";
                    break;
            }
            if(nItemType != BASE_ITEM_TRAPKIT)
                nResult = FALSE;
            nSubPropertyMax = 3;
            break;
//        case 71: // ITEM_PROPERTY_TRUE_SEEING                              = 71 ;
//            break;
//        case 72: // ITEM_PROPERTY_ON_MONSTER_HIT                           = 72 ;
//            break;
//        case 73: // ITEM_PROPERTY_TURN_RESISTANCE                          = 73 ;
//            break;
//        case 74: // ITEM_PROPERTY_MASSIVE_CRITICALS                        = 74 ;
//            break;
//        case 75: // ITEM_PROPERTY_FREEDOM_OF_MOVEMENT                      = 75 ;
//            break;
//        case 76: // ITEM_PROPERTY_POISON (not woring)
//            break;
//        case 77: // ITEM_PROPERTY_MONSTER_DAMAGE                           = 77 ;
//            break;
//        case 78: // ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL                 = 78 ;
//            break;
//        case 79: // ITEM_PROPERTY_SPECIAL_WALK                             = 79;
//            break;
//        case 80: // ITEM_PROPERTY_HEALERS_KIT                              = 80;
//            break;
//        case 81: // ITEM_PROPERTY_WEIGHT_INCREASE                          = 81;
//            break;
        case 82: // ITEM_PROPERTY_ONHITCASTSPELL                           = 82;
            switch(nSubPropertyNumber)
            {
                case 0: // IP_CONST_ONHIT_CASTSPELL_ACID_FOG                           = 0:
                    sLast = "140: On Hit Cast Spell: Combust";
                    sSelected = "0: On Hit Cast Spell: Acid Fog";
                    sNext = "1: On Hit Cast Spell: Bestow Curse";
                    break;
                case 1: // IP_CONST_ONHIT_CASTSPELL_BESTOW_CURSE                       = 1:
                    sLast = "0: On Hit Cast Spell: Acid Fog";
                    sSelected = "1: On Hit Cast Spell: Bestow Curse";
                    sNext = "2: On Hit Cast Spell: Blade Barrier";
                    break;
                case 2: // IP_CONST_ONHIT_CASTSPELL_BLADE_BARRIER                      = 2:
                    sLast = "1: On Hit Cast Spell: Bestow Curse";
                    sSelected = "2: On Hit Cast Spell: Blade Barrier";
                    sNext = "3: On Hit Cast Spell: Blindness/Deafness";
                    break;
                case 3: // IP_CONST_ONHIT_CASTSPELL_BLINDNESS_AND_DEAFNESS             = 3:
                    sLast = "2: On Hit Cast Spell: Blade Barrier";
                    sSelected = "3: On Hit Cast Spell: Blindness/Deafness";
                    sNext = "4: On Hit Cast Spell: Call Lightning";
                    break;
                case 4: // IP_CONST_ONHIT_CASTSPELL_CALL_LIGHTNING                     = 4:
                    sLast = "3: On Hit Cast Spell: Blindness/Deafness";
                    sSelected = "4: On Hit Cast Spell: Call Lightning";
                    sNext = "5: On Hit Cast Spell: Chain Lightning";
                    break;
                case 5: // IP_CONST_ONHIT_CASTSPELL_CHAIN_LIGHTNING                    = 5:
                    sLast = "4: On Hit Cast Spell: Call Lightning";
                    sSelected = "5: On Hit Cast Spell: Chain Lightning";
                    sNext = "6: On Hit Cast Spell: Cloudkill";
                    break;
                case 6: // IP_CONST_ONHIT_CASTSPELL_CLOUDKILL                          = 6:
                    sLast = "5: On Hit Cast Spell: Chain Lightning";
                    sSelected = "6: On Hit Cast Spell: Cloudkill";
                    sNext = "7: On Hit Cast Spell: Confusion";
                    break;
                case 7: // IP_CONST_ONHIT_CASTSPELL_CONFUSION                          = 7:
                    sLast = "6: On Hit Cast Spell: Cloudkill";
                    sSelected = "7: On Hit Cast Spell: Confusion";
                    sNext = "8: On Hit Cast Spell: Contagion";
                    break;
                case 8: // IP_CONST_ONHIT_CASTSPELL_CONTAGION                          = 8:
                    sLast = "7: On Hit Cast Spell: Confusion";
                    sSelected = "8: On Hit Cast Spell: Contagion";
                    sNext = "9: On Hit Cast Spell: Darkness";
                    break;
                case 9: // IP_CONST_ONHIT_CASTSPELL_DARKNESS                           = 9:
                    sLast = "8: On Hit Cast Spell: Contagion";
                    sSelected = "9: On Hit Cast Spell: Darkness";
                    sNext = "10: On Hit Cast Spell: Daze";
                    break;
                case 10: // IP_CONST_ONHIT_CASTSPELL_DAZE                               = 10:
                    sLast = "9: On Hit Cast Spell: Darkness";
                    sSelected = "10: On Hit Cast Spell: Daze";
                    sNext = "11: On Hit Cast Spell: Dealyed Fireball Blast";
                    break;
                case 11: // IP_CONST_ONHIT_CASTSPELL_DELAYED_BLAST_FIREBALL             = 11:
                    sLast = "10: On Hit Cast Spell: Daze";
                    sSelected = "11: On Hit Cast Spell: Dealyed Fireball Blast";
                    sNext = "12: On Hit Cast Spell: Dismissal";
                    break;
                case 12: // IP_CONST_ONHIT_CASTSPELL_DISMISSAL                          = 12:
                    sLast = "11: On Hit Cast Spell: Dealyed Fireball Blast";
                    sSelected = "12: On Hit Cast Spell: Dismissal";
                    sNext = "13: On Hit Cast Spell: Dispel Magic";
                    break;
                case 13: // IP_CONST_ONHIT_CASTSPELL_DISPEL_MAGIC                       = 13:
                    sLast = "12: On Hit Cast Spell: Dismissal";
                    sSelected = "13: On Hit Cast Spell: Dispel Magic";
                    sNext = "14: On Hit Cast Spell: Doom";
                    break;
                case 14: // IP_CONST_ONHIT_CASTSPELL_DOOM                               = 14:
                    sLast = "13: On Hit Cast Spell: Dispel Magic";
                    sSelected = "14: On Hit Cast Spell: Doom";
                    sNext = "15: On Hit Cast Spell: Energy Drain";
                    break;
                case 15: // IP_CONST_ONHIT_CASTSPELL_ENERGY_DRAIN                       = 15:
                    sLast = "14: On Hit Cast Spell: Doom";
                    sSelected = "15: On Hit Cast Spell: Energy Drain";
                    sNext = "16: On Hit Cast Spell: Enervation";
                    break;
                case 16: // IP_CONST_ONHIT_CASTSPELL_ENERVATION                         = 16:
                    sLast = "15: On Hit Cast Spell: Energy Drain";
                    sSelected = "16: On Hit Cast Spell: Enervation";
                    sNext = "17: On Hit Cast Spell: Entangle";
                    break;
                case 17: // IP_CONST_ONHIT_CASTSPELL_ENTANGLE                           = 17:
                    sLast = "16: On Hit Cast Spell: Enervation";
                    sSelected = "17: On Hit Cast Spell: Entangle";
                    sNext = "18: On Hit Cast Spell: Fear";
                    break;
                case 18: // IP_CONST_ONHIT_CASTSPELL_FEAR                               = 18:
                    sLast = "17: On Hit Cast Spell: Entangle";
                    sSelected = "18: On Hit Cast Spell: Fear";
                    sNext = "19: On Hit Cast Spell: Feeblemind";
                    break;
                case 19: // IP_CONST_ONHIT_CASTSPELL_FEEBLEMIND                         = 19:
                    sLast = "18: On Hit Cast Spell: Fear";
                    sSelected = "19: On Hit Cast Spell: Feeblemind";
                    sNext = "20: On Hit Cast Spell: Fire Storm";
                    break;
                case 20: // IP_CONST_ONHIT_CASTSPELL_FIRE_STORM                         = 20:
                    sLast = "19: On Hit Cast Spell: Feeblemind";
                    sSelected = "20: On Hit Cast Spell: Fire Storm";
                    sNext = "21: On Hit Cast Spell: Fireball";
                    break;
                case 21: // IP_CONST_ONHIT_CASTSPELL_FIREBALL                           = 21:
                    sLast = "20: On Hit Cast Spell: Fire Storm";
                    sSelected = "21: On Hit Cast Spell: Fireball";
                    sNext = "22: On Hit Cast Spell: Flame Lash";
                    break;
                case 22: // IP_CONST_ONHIT_CASTSPELL_FLAME_LASH                         = 22:
                    sLast = "21: On Hit Cast Spell: Fireball";
                    sSelected = "22: On Hit Cast Spell: Flame Lash";
                    sNext = "23: On Hit Cast Spell: Flame Strike";
                    break;
                case 23: // IP_CONST_ONHIT_CASTSPELL_FLAME_STRIKE                       = 23:
                    sLast = "22: On Hit Cast Spell: Flame Lash";
                    sSelected = "23: On Hit Cast Spell: Flame Strike";
                    sNext = "24: On Hit Cast Spell: Ghoul Touch";
                    break;
                case 24: // IP_CONST_ONHIT_CASTSPELL_GHOUL_TOUCH                        = 24:
                    sLast = "23: On Hit Cast Spell: Flame Strike";
                    sSelected = "24: On Hit Cast Spell: Ghoul Touch";
                    sNext = "25: On Hit Cast Spell: Grease";
                    break;
                case 25: // IP_CONST_ONHIT_CASTSPELL_GREASE                             = 25:
                    sLast = "24: On Hit Cast Spell: Ghoul Touch";
                    sSelected = "25: On Hit Cast Spell: Grease";
                    sNext = "26: On Hit Cast Spell: Greater Dispelling";
                    break;
                case 26: // IP_CONST_ONHIT_CASTSPELL_GREATER_DISPELLING                 = 26:
                    sLast = "25: On Hit Cast Spell: Grease";
                    sSelected = "26: On Hit Cast Spell: Greater Dispelling";
                    sNext = "27: On Hit Cast Spell: Greater Spell Breach";
                    break;
                case 27: // IP_CONST_ONHIT_CASTSPELL_GREATER_SPELL_BREACH               = 27:
                    sLast = "26: On Hit Cast Spell: Greater Dispelling";
                    sSelected = "27: On Hit Cast Spell: Greater Spell Breach";
                    sNext = "28: On Hit Cast Spell: Gust of Wind";
                    break;
                case 28: // IP_CONST_ONHIT_CASTSPELL_GUST_OF_WIND                       = 28:
                    sLast = "27: On Hit Cast Spell: Greater Spell Breach";
                    sSelected = "28: On Hit Cast Spell: Gust of Wind";
                    sNext = "29: On Hit Cast Spell: Hammer of the Gods";
                    break;
                case 29: // IP_CONST_ONHIT_CASTSPELL_HAMMER_OF_THE_GODS                 = 29:
                    sLast = "28: On Hit Cast Spell: Gust of Wind";
                    sSelected = "29: On Hit Cast Spell: Hammer of the Gods";
                    sNext = "30: On Hit Cast Spell: Harm";
                    break;
                case 30: // IP_CONST_ONHIT_CASTSPELL_HARM                               = 30:
                    sLast = "29: On Hit Cast Spell: Hammer of the Gods";
                    sSelected = "30: On Hit Cast Spell: Harm";
                    sNext = "31: On Hit Cast Spell: Hold Animal";
                    break;
                case 31: // IP_CONST_ONHIT_CASTSPELL_HOLD_ANIMAL                        = 31:
                    sLast = "30: On Hit Cast Spell: Harm";
                    sSelected = "31: On Hit Cast Spell: Hold Animal";
                    sNext = "32: On Hit Cast Spell: Hold Monster";
                    break;
                case 32: // IP_CONST_ONHIT_CASTSPELL_HOLD_MONSTER                       = 32:
                    sLast = "31: On Hit Cast Spell: Hold Animal";
                    sSelected = "32: On Hit Cast Spell: Hold Monster";
                    sNext = "33: On Hit Cast Spell: Hold Person";
                    break;
                case 33: // IP_CONST_ONHIT_CASTSPELL_HOLD_PERSON                        = 33:
                    sLast = "32: On Hit Cast Spell: Hold Monster";
                    sSelected = "33: On Hit Cast Spell: Hold Person";
                    sNext = "34: On Hit Cast Spell: Implosion";
                    break;
                case 34: // IP_CONST_ONHIT_CASTSPELL_IMPLOSION                          = 34:
                    sLast = "33: On Hit Cast Spell: Hold Person";
                    sSelected = "34: On Hit Cast Spell: Implosion";
                    sNext = "35: On Hit Cast Spell: Incendiary Cloud";
                    break;
                case 35: // IP_CONST_ONHIT_CASTSPELL_INCENDIARY_CLOUD                   = 35:
                    sLast = "34: On Hit Cast Spell: Implosion";
                    sSelected = "35: On Hit Cast Spell: Incendiary Cloud";
                    sNext = "36: On Hit Cast Spell: Lesser Dispel";
                    break;
                case 36: // IP_CONST_ONHIT_CASTSPELL_LESSER_DISPEL                      = 36:
                    sLast = "35: On Hit Cast Spell: Incendiary Cloud";
                    sSelected = "36: On Hit Cast Spell: Lesser Dispel";
                    sNext = "37: <No Spell>";
                    break;
                case 37:
                    sLast = "36: On Hit Cast Spell: Lesser Dispel";
                    sSelected = "37: <No Spell>";
                    sNext = "38: On Hit Cast Spell: Lesser Spell Breach";
                    break;
                case 38: // IP_CONST_ONHIT_CASTSPELL_LESSER_SPELL_BREACH                = 38:
                    sLast = "37: <No Spell>";
                    sSelected = "38: On Hit Cast Spell: Lesser Spell Breach";
                    sNext = "39: <No Spell>";
                    break;
                case 39:
                    sLast = "38: On Hit Cast Spell: Lesser Spell Breach";
                    sSelected = "39: <No Spell>";
                    sNext = "40: On Hit Cast Spell: Light";
                    break;
                case 40: // IP_CONST_ONHIT_CASTSPELL_LIGHT                              = 40:
                    sLast = "39: <No Spell>";
                    sSelected = "40: On Hit Cast Spell: Light";
                    sNext = "41: On Hit Cast Spell: Lightning Bolt";
                    break;
                case 41: // IP_CONST_ONHIT_CASTSPELL_LIGHTNING_BOLT                     = 41:
                    sLast = "40: On Hit Cast Spell: Light";
                    sSelected = "41: On Hit Cast Spell: Lightning Bolt";
                    sNext = "42: On Hit Cast Spell: Magic Missile";
                    break;
                case 42: // IP_CONST_ONHIT_CASTSPELL_MAGIC_MISSILE                      = 42:
                    sLast = "41: On Hit Cast Spell: Lightning Bolt";
                    sSelected = "42: On Hit Cast Spell: Magic Missile";
                    sNext = "43: On Hit Cast Spell: Mass Blindness/Deafness";
                    break;
                case 43: // IP_CONST_ONHIT_CASTSPELL_MASS_BLINDNESS_AND_DEAFNESS        = 43:
                    sLast = "42: On Hit Cast Spell: Magic Missile";
                    sSelected = "43: On Hit Cast Spell: Mass Blindness/Deafness";
                    sNext = "44: On Hit Cast Spell: Mass Charm";
                    break;
                case 44: // IP_CONST_ONHIT_CASTSPELL_MASS_CHARM                         = 44:
                    sLast = "43: On Hit Cast Spell: Mass Blindness/Deafness";
                    sSelected = "44: On Hit Cast Spell: Mass Charm";
                    sNext = "45: On Hit Cast Spell: Melfs Acid Arrow";
                    break;
                case 45: // IP_CONST_ONHIT_CASTSPELL_MELFS_ACID_ARROW                   = 45:
                    sLast = "44: On Hit Cast Spell: Mass Charm";
                    sSelected = "45: On Hit Cast Spell: Melfs Acid Arrow";
                    sNext = "46: On Hit Cast Spell: Meteor Swarm";
                    break;
                case 46: // IP_CONST_ONHIT_CASTSPELL_METEOR_SWARM                       = 46:
                    sLast = "45: On Hit Cast Spell: Melfs Acid Arrow";
                    sSelected = "46: On Hit Cast Spell: Meteor Swarm";
                    sNext = "47: On Hit Cast Spell: Mind Fog";
                    break;
                case 47: // IP_CONST_ONHIT_CASTSPELL_MIND_FOG                           = 47:
                    sLast = "46: On Hit Cast Spell: Meteor Swarm";
                    sSelected = "47: On Hit Cast Spell: Mind Fog";
                    sNext = "48: <No Spell>";
                    break;
                case 48:
                    sLast = "47: On Hit Cast Spell: Mind Fog";
                    sSelected = "48: <No Spell>";
                    sNext = "49: On Hit Cast Spell: Phantasmal Killer";
                    break;
                case 49: // IP_CONST_ONHIT_CASTSPELL_PHANTASMAL_KILLER                  = 49:
                    sLast = "48: <No Spell>";
                    sSelected = "49: On Hit Cast Spell: Phantasmal Killer";
                    sNext = "50: On Hit Cast Spell: Poison";
                    break;
                case 50: // IP_CONST_ONHIT_CASTSPELL_POISON                             = 50:
                    sLast = "49: On Hit Cast Spell: Phantasmal Killer";
                    sSelected = "50: On Hit Cast Spell: Poison";
                    sNext = "51: On Hit Cast Spell: Power Word Kill";
                    break;
                case 51: // IP_CONST_ONHIT_CASTSPELL_POWER_WORD_KILL                    = 51:
                    sLast = "50: On Hit Cast Spell: Poison";
                    sSelected = "51: On Hit Cast Spell: Power Word Kill";
                    sNext = "52: On Hit Cast Spell: Power Word Stun";
                    break;
                case 52: // IP_CONST_ONHIT_CASTSPELL_POWER_WORD_STUN                    = 52:
                    sLast = "51: On Hit Cast Spell: Power Word Kill";
                    sSelected = "52: On Hit Cast Spell: Power Word Stun";
                    sNext = "53: <No Spell>";
                    break;
                case 53:
                    sLast = "52: On Hit Cast Spell: Power Word Stun";
                    sSelected = "53: <No Spell>";
                    sNext = "54: On Hit Cast Spell: Scare";
                    break;
                case 54: // IP_CONST_ONHIT_CASTSPELL_SCARE                              = 54:
                    sLast = "53: <No Spell>";
                    sSelected = "54: On Hit Cast Spell: Scare";
                    sNext = "55: On Hit Cast Spell: Searing Light";
                    break;
                case 55: // IP_CONST_ONHIT_CASTSPELL_SEARING_LIGHT                      = 55:
                    sLast = "54: On Hit Cast Spell: Scare";
                    sSelected = "55: On Hit Cast Spell: Searing Light";
                    sNext = "56: On Hit Cast Spell: Silence";
                    break;
                case 56: // IP_CONST_ONHIT_CASTSPELL_SILENCE                            = 56:
                    sLast = "55: On Hit Cast Spell: Searing Light";
                    sSelected = "56: On Hit Cast Spell: Silence";
                    sNext = "57: On Hit Cast Spell: Slay Living";
                    break;
                case 57: // IP_CONST_ONHIT_CASTSPELL_SLAY_LIVING                        = 57:
                    sLast = "56: On Hit Cast Spell: Silence";
                    sSelected = "57: On Hit Cast Spell: Slay Living";
                    sNext = "58: On Hit Cast Spell: Sleep";
                    break;
                case 58: // IP_CONST_ONHIT_CASTSPELL_SLEEP                              = 58:
                    sLast = "57: On Hit Cast Spell: Slay Living";
                    sSelected = "58: On Hit Cast Spell: Sleep";
                    sNext = "59: On Hit Cast Spell: Slow";
                    break;
                case 59: // IP_CONST_ONHIT_CASTSPELL_SLOW                               = 59:
                    sLast = "58: On Hit Cast Spell: Sleep";
                    sSelected = "59: On Hit Cast Spell: Slow";
                    sNext = "60: On Hit Cast Spell: Sound Burst";
                    break;
                case 60: // IP_CONST_ONHIT_CASTSPELL_SOUND_BURST                        = 60:
                    sLast = "59: On Hit Cast Spell: Slow";
                    sSelected = "60: On Hit Cast Spell: Sound Burst";
                    sNext = "61: On Hit Cast Spell: Stinking Cloud";
                    break;
                case 61: // IP_CONST_ONHIT_CASTSPELL_STINKING_CLOUD                     = 61:
                    sLast = "60: On Hit Cast Spell: Sound Burst";
                    sSelected = "61: On Hit Cast Spell: Stinking Cloud";
                    sNext = "62: <No Spell>";
                    break;
                case 62:
                    sLast = "61: On Hit Cast Spell: Stinking Cloud";
                    sSelected = "62: <No Spell>";
                    sNext = "63: On Hit Cast Spell: Storm of Vengeance";
                    break;
                case 63: // IP_CONST_ONHIT_CASTSPELL_STORM_OF_VENGEANCE                 = 63:
                    sLast = "62: <No Spell>";
                    sSelected = "63: On Hit Cast Spell: Storm of Vengeance";
                    sNext = "64: On Hit Cast Spell: Sunbeam";
                    break;
                case 64: // IP_CONST_ONHIT_CASTSPELL_SUNBEAM                            = 64:
                    sLast = "63: On Hit Cast Spell: Storm of Vengeance";
                    sSelected = "64: On Hit Cast Spell: Sunbeam";
                    sNext = "65: On Hit Cast Spell: Vampiric Touch";
                    break;
                case 65: // IP_CONST_ONHIT_CASTSPELL_VAMPIRIC_TOUCH                     = 65:
                    sLast = "64: On Hit Cast Spell: Sunbeam";
                    sSelected = "65: On Hit Cast Spell: Vampiric Touch";
                    sNext = "66: On Hit Cast Spell: Wail of the Banshee";
                    break;
                case 66: // IP_CONST_ONHIT_CASTSPELL_WAIL_OF_THE_BANSHEE                = 66:
                    sLast = "65: On Hit Cast Spell: Vampiric Touch";
                    sSelected = "66: On Hit Cast Spell: Wail of the Banshee";
                    sNext = "67: On Hit Cast Spell: Wail of Fire";
                    break;
                case 67: // IP_CONST_ONHIT_CASTSPELL_WALL_OF_FIRE                       = 67:
                    sLast = "66: On Hit Cast Spell: Wail of the Banshee";
                    sSelected = "67: On Hit Cast Spell: Wail of Fire";
                    sNext = "68: On Hit Cast Spell: Web";
                    break;
                case 68: // IP_CONST_ONHIT_CASTSPELL_WEB                                = 68:
                    sLast = "67: On Hit Cast Spell: Wail of Fire";
                    sSelected = "68: On Hit Cast Spell: Web";
                    sNext = "69: On Hit Cast Spell: Weird";
                    break;
                case 69: // IP_CONST_ONHIT_CASTSPELL_WEIRD                              = 69:
                    sLast = "68: On Hit Cast Spell: Web";
                    sSelected = "69: On Hit Cast Spell: Weird";
                    sNext = "70: On Hit Cast Spell: Word of Faith";
                    break;
                case 70: // IP_CONST_ONHIT_CASTSPELL_WORD_OF_FAITH                      = 70:
                    sLast = "69: On Hit Cast Spell: Weird";
                    sSelected = "70: On Hit Cast Spell: Word of Faith";
                    sNext = "71: <No Spell>";
                    break;
                case 71:
                    sLast = "70: On Hit Cast Spell: Word of Faith";
                    sSelected = "71: <No Spell>";
                    sNext = "72: On Hit Cast Spell: Creeping Doom";
                    break;
                case 72: // IP_CONST_ONHIT_CASTSPELL_CREEPING_DOOM                      = 72:
                    sLast = "71: <No Spell>";
                    sSelected = "72: On Hit Cast Spell: Creeping Doom";
                    sNext = "73: On Hit Cast Spell: Destruction";
                    break;
                case 73: // IP_CONST_ONHIT_CASTSPELL_DESTRUCTION                        = 73:
                    sLast = "72: On Hit Cast Spell: Creeping Doom";
                    sSelected = "73: On Hit Cast Spell: Destruction";
                    sNext = "74: On Hit Cast Spell: Horrid Wilting";
                    break;
                case 74: // IP_CONST_ONHIT_CASTSPELL_HORRID_WILTING                     = 74:
                    sLast = "73: On Hit Cast Spell: Destruction";
                    sSelected = "74: On Hit Cast Spell: Horrid Wilting";
                    sNext = "75: On Hit Cast Spell: Ice Storm";
                    break;
                case 75: // IP_CONST_ONHIT_CASTSPELL_ICE_STORM                          = 75:
                    sLast = "74: On Hit Cast Spell: Horrid Wilting";
                    sSelected = "75: On Hit Cast Spell: Ice Storm";
                    sNext = "76: On Hit Cast Spell: Negative Energy Burst";
                    break;
                case 76: // IP_CONST_ONHIT_CASTSPELL_NEGATIVE_ENERGY_BURST              = 76:
                    sLast = "75: On Hit Cast Spell: Ice Storm";
                    sSelected = "76: On Hit Cast Spell: Negative Energy Burst";
                    sNext = "77: On Hit Cast Spell: Evards Black Tentacles";
                    break;
                case 77: // IP_CONST_ONHIT_CASTSPELL_EVARDS_BLACK_TENTACLES             = 77:
                    sLast = "76: On Hit Cast Spell: Negative Energy Burst";
                    sSelected = "77: On Hit Cast Spell: Evards Black Tentacles";
                    sNext = "78: On Hit Cast Spell: Activate Item [Custom Code]";
                    break;
                case 78: // IP_CONST_ONHIT_CASTSPELL_ACTIVATE_ITEM                      = 78:
                    sLast = "77: On Hit Cast Spell: Evards Black Tentacles";
                    sSelected = "78: On Hit Cast Spell: Activate Item [Custom Code]";
                    sNext = "79: On Hit Cast Spell: Flare";
                    break;
                case 79: // IP_CONST_ONHIT_CASTSPELL_FLARE                              = 79:
                    sLast = "78: On Hit Cast Spell: Activate Item [Custom Code]";
                    sSelected = "79: On Hit Cast Spell: Flare";
                    sNext = "80: On Hit Cast Spell: Bombardment";
                    break;
                case 80: // IP_CONST_ONHIT_CASTSPELL_BOMBARDMENT                        = 80:
                    sLast = "79: On Hit Cast Spell: Flare";
                    sSelected = "80: On Hit Cast Spell: Bombardment";
                    sNext = "81: On Hit Cast Spell: Acid Splash";
                    break;
                case 81: // IP_CONST_ONHIT_CASTSPELL_ACID_SPLASH                        = 81:
                    sLast = "80: On Hit Cast Spell: Bombardment";
                    sSelected = "81: On Hit Cast Spell: Acid Splash";
                    sNext = "82: On Hit Cast Spell: Quillfire";
                    break;
                case 82: // IP_CONST_ONHIT_CASTSPELL_QUILLFIRE                          = 82:
                    sLast = "81: On Hit Cast Spell: Acid Splash";
                    sSelected = "82: On Hit Cast Spell: Quillfire";
                    sNext = "83: On Hit Cast Spell: Earthquake";
                    break;
                case 83: // IP_CONST_ONHIT_CASTSPELL_EARTHQUAKE                         = 83:
                    sLast = "82: On Hit Cast Spell: Quillfire";
                    sSelected = "83: On Hit Cast Spell: Earthquake";
                    sNext = "84: On Hit Cast Spell: Sunburst";
                    break;
                case 84: // IP_CONST_ONHIT_CASTSPELL_SUNBURST                           = 84:
                    sLast = "83: On Hit Cast Spell: Earthquake";
                    sSelected = "84: On Hit Cast Spell: Sunburst";
                    sNext = "85: On Hit Cast Spell: Banishment";
                    break;
                case 85: // IP_CONST_ONHIT_CASTSPELL_BANISHMENT                         = 85:
                    sLast = "84: On Hit Cast Spell: Sunburst";
                    sSelected = "85: On Hit Cast Spell: Banishment";
                    sNext = "86: On Hit Cast Spell: Inflict Minor Wounds";
                    break;
                case 86: // IP_CONST_ONHIT_CASTSPELL_INFLICT_MINOR_WOUNDS               = 86:
                    sLast = "85: On Hit Cast Spell: Banishment";
                    sSelected = "86: On Hit Cast Spell: Inflict Minor Wounds";
                    sNext = "87: On Hit Cast Spell: Inflict Light Wounds";
                    break;
                case 87: // IP_CONST_ONHIT_CASTSPELL_INFLICT_LIGHT_WOUNDS               = 87:
                    sLast = "86: On Hit Cast Spell: Inflict Minor Wounds";
                    sSelected = "87: On Hit Cast Spell: Inflict Light Wounds";
                    sNext = "88: On Hit Cast Spell: Inflict Moderate Wounds";
                    break;
                case 88: // IP_CONST_ONHIT_CASTSPELL_INFLICT_MODERATE_WOUNDS            = 88:
                    sLast = "87: On Hit Cast Spell: Inflict Light Wounds";
                    sSelected = "88: On Hit Cast Spell: Inflict Moderate Wounds";
                    sNext = "89: On Hit Cast Spell: Inflict Serious Wounds";
                    break;
                case 89: // IP_CONST_ONHIT_CASTSPELL_INFLICT_SERIOUS_WOUNDS             = 89:
                    sLast = "88: On Hit Cast Spell: Inflict Moderate Wounds";
                    sSelected = "89: On Hit Cast Spell: Inflict Serious Wounds";
                    sNext = "90: On Hit Cast Spell: Inflict Critical Wounds";
                    break;
                case 90: // IP_CONST_ONHIT_CASTSPELL_INFLICT_CRITICAL_WOUNDS            = 90:
                    sLast = "89: On Hit Cast Spell: Inflict Serious Wounds";
                    sSelected = "90: On Hit Cast Spell: Inflict Critical Wounds";
                    sNext = "91: On Hit Cast Spell: Balagarns Iron Horn";
                    break;
                case 91: // IP_CONST_ONHIT_CASTSPELL_BALAGARNSIRONHORN                  = 91:
                    sLast = "90: On Hit Cast Spell: Inflict Critical Wounds";
                    sSelected = "91: On Hit Cast Spell: Balagarns Iron Horn";
                    sNext = "92: On Hit Cast Spell: Drown";
                    break;
                case 92: // IP_CONST_ONHIT_CASTSPELL_DROWN                              = 92:
                    sLast = "91: On Hit Cast Spell: Balagarns Iron Horn";
                    sSelected = "92: On Hit Cast Spell: Drown";
                    sNext = "93: On Hit Cast Spell: Electric Jolt";
                    break;
                case 93: // IP_CONST_ONHIT_CASTSPELL_ELECTRIC_JOLT                      = 93:
                    sLast = "92: On Hit Cast Spell: Drown";
                    sSelected = "93: On Hit Cast Spell: Electric Jolt";
                    sNext = "94: On Hit Cast Spell: Firebrand";
                    break;
                case 94: // IP_CONST_ONHIT_CASTSPELL_FIREBRAND                          = 94:
                    sLast = "93: On Hit Cast Spell: Electric Jolt";
                    sSelected = "94: On Hit Cast Spell: Firebrand";
                    sNext = "95: On Hit Cast Spell: Wounding Whispers";
                    break;
                case 95: // IP_CONST_ONHIT_CASTSPELL_WOUNDING_WHISPERS                  = 95:
                    sLast = "94: On Hit Cast Spell: Firebrand";
                    sSelected = "95: On Hit Cast Spell: Wounding Whispers";
                    sNext = "96: On Hit Cast Spell: Eternal Foe";
                    break;
                case 96: // IP_CONST_ONHIT_CASTSPELL_UNDEATHS_ETERNAL_FOE               = 96:
                    sLast = "95: On Hit Cast Spell: Wounding Whispers";
                    sSelected = "96: On Hit Cast Spell: Eternal Foe";
                    sNext = "97: On Hit Cast Spell: Inferno";
                    break;
                case 97: // IP_CONST_ONHIT_CASTSPELL_INFERNO                            = 97:
                    sLast = "96: On Hit Cast Spell: Eternal Foe";
                    sSelected = "97: On Hit Cast Spell: Inferno";
                    sNext = "98: On Hit Cast Spell: Isaacs Lesser Missile Storm";
                    break;
                case 98: // IP_CONST_ONHIT_CASTSPELL_ISAACS_LESSER_MISSILE_STORM        = 98:
                    sLast = "97: On Hit Cast Spell: Inferno";
                    sSelected = "98: On Hit Cast Spell: Isaacs Lesser Missile Storm";
                    sNext = "99: On Hit Cast Spell: Isaacs Greater Missile Storm";
                    break;
                case 99: // IP_CONST_ONHIT_CASTSPELL_ISAACS_GREATER_MISSILE_STORM       = 99:
                    sLast = "98: On Hit Cast Spell: Isaacs Lesser Missile Storm";
                    sSelected = "99: On Hit Cast Spell: Isaacs Greater Missile Storm";
                    sNext = "100: On Hit Cast Spell: Bane";
                    break;
                case 100: // IP_CONST_ONHIT_CASTSPELL_BANE                               = 100:
                    sLast = "99: On Hit Cast Spell: Isaacs Greater Missile Storm";
                    sSelected = "100: On Hit Cast Spell: Bane";
                    sNext = "101: On Hit Cast Spell: Spike Growth";
                    break;
                case 101: // IP_CONST_ONHIT_CASTSPELL_SPIKE_GROWTH                       = 101:
                    sLast = "100: On Hit Cast Spell: Bane";
                    sSelected = "101: On Hit Cast Spell: Spike Growth";
                    sNext = "102: On Hit Cast Spell: Tashas Hideous Laughter";
                    break;
                case 102: // IP_CONST_ONHIT_CASTSPELL_TASHAS_HIDEOUS_LAUGHTER            = 102:
                    sLast = "101: On Hit Cast Spell: Spike Growth";
                    sSelected = "102: On Hit Cast Spell: Tashas Hideous Laughter";
                    sNext = "103: On Hit Cast Spell: Bigbys Interposing Hand";
                    break;
                case 103: // IP_CONST_ONHIT_CASTSPELL_BIGBYS_INTERPOSING_HAND            = 103:
                    sLast = "102: On Hit Cast Spell: Tashas Hideous Laughter";
                    sSelected = "103: On Hit Cast Spell: Bigbys Interposing Hand";
                    sNext = "104: On Hit Cast Spell: Bigbys Forceful Hand";
                    break;
                case 104: // IP_CONST_ONHIT_CASTSPELL_BIGBYS_FORCEFUL_HAND               = 104:
                    sLast = "103: On Hit Cast Spell: Bigbys Interposing Hand";
                    sSelected = "104: On Hit Cast Spell: Bigbys Forceful Hand";
                    sNext = "105: On Hit Cast Spell: Bigbys Grasping Hand";
                    break;
                case 105: // IP_CONST_ONHIT_CASTSPELL_BIGBYS_GRASPING_HAND               = 105:
                    sLast = "104: On Hit Cast Spell: Bigbys Forceful Hand";
                    sSelected = "105: On Hit Cast Spell: Bigbys Grasping Hand";
                    sNext = "106: On Hit Cast Spell: Bigbys Clenched Fist";
                    break;
                case 106: // IP_CONST_ONHIT_CASTSPELL_BIGBYS_CLENCHED_FIST               = 106:
                    sLast = "105: On Hit Cast Spell: Bigbys Grasping Hand";
                    sSelected = "106: On Hit Cast Spell: Bigbys Clenched Fist";
                    sNext = "107: On Hit Cast Spell: Bigbys Crushing Hand";
                    break;
                case 107: // IP_CONST_ONHIT_CASTSPELL_BIGBYS_CRUSHING_HAND               = 107:
                    sLast = "106: On Hit Cast Spell: Bigbys Clenched Fist";
                    sSelected = "107: On Hit Cast Spell: Bigbys Crushing Hand";
                    sNext = "108: On Hit Cast Spell: Flesh To Stone";
                    break;
                case 108: // IP_CONST_ONHIT_CASTSPELL_FLESH_TO_STONE                     = 108:
                    sLast = "107: On Hit Cast Spell: Bigbys Crushing Hand";
                    sSelected = "108: On Hit Cast Spell: Flesh To Stone";
                    sNext = "109: On Hit Cast Spell: Stone To Flest";
                    break;
                case 109: // IP_CONST_ONHIT_CASTSPELL_STONE_TO_FLESH                     = 109:
                    sLast = "108: On Hit Cast Spell: Flesh To Stone";
                    sSelected = "109: On Hit Cast Spell: Stone To Flest";
                    sNext = "110: On Hit Cast Spell: Crumble";
                    break;
                case 110: // IP_CONST_ONHIT_CASTSPELL_CRUMBLE                            = 110:
                    sLast = "109: On Hit Cast Spell: Stone To Flest";
                    sSelected = "110: On Hit Cast Spell: Crumble";
                    sNext = "111: On Hit Cast Spell: Infestation of Maggots";
                    break;
                case 111: // IP_CONST_ONHIT_CASTSPELL_INFESTATION_OF_MAGGOTS             = 111:
                    sLast = "110: On Hit Cast Spell: Crumble";
                    sSelected = "111: On Hit Cast Spell: Infestation of Maggots";
                    sNext = "112: On Hit Cast Spell: Thunderclap";
                    break;
                case 112: // IP_CONST_ONHIT_CASTSPELL_GREAT_THUNDERCLAP                  = 112:
                    sLast = "111: On Hit Cast Spell: Infestation of Maggots";
                    sSelected = "112: On Hit Cast Spell: Thunderclap";
                    sNext = "113: On Hit Cast Spell: Ball Lightning";
                    break;
                case 113: // IP_CONST_ONHIT_CASTSPELL_BALL_LIGHTNING                     = 113:
                    sLast = "112: On Hit Cast Spell: Thunderclap";
                    sSelected = "113: On Hit Cast Spell: Ball Lightning";
                    sNext = "114: On Hit Cast Spell: Gedlees Electric Loop";
                    break;
                case 114: // IP_CONST_ONHIT_CASTSPELL_GEDLEES_ELECTRIC_LOOP              = 114:
                    sLast = "113: On Hit Cast Spell: Ball Lightning";
                    sSelected = "114: On Hit Cast Spell: Gedlees Electric Loop";
                    sNext = "115: On Hit Cast Spell: Horizikauls Boom";
                    break;
                case 115: // IP_CONST_ONHIT_CASTSPELL_HORIZIKAULS_BOOM                   = 115:
                    sLast = "114: On Hit Cast Spell: Gedlees Electric Loop";
                    sSelected = "115: On Hit Cast Spell: Horizikauls Boom";
                    sNext = "116: On Hit Cast Spell: Mestils Acid Breath";
                    break;
                case 116: // IP_CONST_ONHIT_CASTSPELL_MESTILS_ACID_BREATH                = 116:
                    sLast = "115: On Hit Cast Spell: Horizikauls Boom";
                    sSelected = "116: On Hit Cast Spell: Mestils Acid Breath";
                    sNext = "117: On Hit Cast Spell: Scintillating Sphere";
                    break;
                case 117: // IP_CONST_ONHIT_CASTSPELL_SCINTILLATING_SPHERE               = 117:
                    sLast = "116: On Hit Cast Spell: Mestils Acid Breath";
                    sSelected = "117: On Hit Cast Spell: Scintillating Sphere";
                    sNext = "118: On Hit Cast Spell: Undeath To Death";
                    break;
                case 118: // IP_CONST_ONHIT_CASTSPELL_UNDEATH_TO_DEATH                   = 118:
                    sLast = "117: On Hit Cast Spell: Scintillating Sphere";
                    sSelected = "118: On Hit Cast Spell: Undeath To Death";
                    sNext = "119: On Hit Cast Spell: Stonehold";
                    break;
                case 119: // IP_CONST_ONHIT_CASTSPELL_STONEHOLD                          = 119:
                    sLast = "118: On Hit Cast Spell: Undeath To Death";
                    sSelected = "119: On Hit Cast Spell: Stonehold";
                    sNext = "120: <No Spell>";
                    break;
                case 120:
                    sLast = "119: On Hit Cast Spell: Stonehold";
                    sSelected = "120: <No Spell>";
                    sNext = "121: On Hit Cast Spell: Evil Blight";
                    break;
                case 121: // IP_CONST_ONHIT_CASTSPELL_EVIL_BLIGHT                        = 121:
                    sLast = "120: <No Spell>";
                    sSelected = "121: On Hit Cast Spell: Evil Blight";
                    sNext = "122: On Hit Cast Spell: Teleport";
                    break;
                case 122: // IP_CONST_ONHIT_CASTSPELL_ONHIT_TELEPORT                     = 122:
                    sLast = "121: On Hit Cast Spell: Evil Blight";
                    sSelected = "122: On Hit Cast Spell: Teleport";
                    sNext = "123: On Hit Cast Spell: Slay Rakshasa";
                    break;
                case 123: // IP_CONST_ONHIT_CASTSPELL_ONHIT_SLAYRAKSHASA                 = 123:
                    sLast = "122: On Hit Cast Spell: Teleport";
                    sSelected = "123: On Hit Cast Spell: Slay Rakshasa";
                    sNext = "124: On Hit Cast Spell: Fire Damage";
                    break;
                case 124: // IP_CONST_ONHIT_CASTSPELL_ONHIT_FIREDAMAGE                   = 124:
                    sLast = "123: On Hit Cast Spell: Slay Rakshasa";
                    sSelected = "124: On Hit Cast Spell: Fire Damage";
                    sNext = "125: On Hit Cast Spell: Unique Power [Custom Code]";
                    break;
                case 125: // IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER                  = 125:
                    sLast = "124: On Hit Cast Spell: Fire Damage";
                    sSelected = "125: On Hit Cast Spell: Unique Power [Custom Code]";
                    sNext = "126: On Hit Cast Spell: Planar Rift";
                    break;
                case 126: // IP_CONST_ONHIT_CASTSPELL_ONHIT_PLANARRIFT                   = 126:
                    sLast = "125: On Hit Cast Spell: Unique Power [Custom Code]";
                    sSelected = "126: On Hit Cast Spell: Planar Rift";
                    sNext = "127: On Hit Cast Spell: Dark Fire";
                    break;
                case 127: // IP_CONST_ONHIT_CASTSPELL_ONHIT_DARKFIRE                     = 127:
                    sLast = "126: On Hit Cast Spell: Planar Rift";
                    sSelected = "127: On Hit Cast Spell: Dark Fire";
                    sNext = "128: On Hit Cast Spell: Extract Brain";
                    break;
                case 128: // IP_CONST_ONHIT_CASTSPELL_ONHIT_EXTRACTBRAIN                 = 128:
                    sLast = "127: On Hit Cast Spell: Dark Fire";
                    sSelected = "128: On Hit Cast Spell: Extract Brain";
                    sNext = "129: On Hit Cast Spell: Flaming Skin";
                    break;
                case 129: // IP_CONST_ONHIT_CASTSPELL_ONHITFLAMINGSKIN                   = 129:
                    sLast = "128: On Hit Cast Spell: Extract Brain";
                    sSelected = "129: On Hit Cast Spell: Flaming Skin";
                    sNext = "130: On Hit Cast Spell: Chaos Shield";
                    break;
                case 130: // IP_CONST_ONHIT_CASTSPELL_ONHIT_CHAOSSHIELD                  = 130:
                    sLast = "129: On Hit Cast Spell: Flaming Skin";
                    sSelected = "130: On Hit Cast Spell: Chaos Shield";
                    sNext = "131: On Hit Cast Spell: Contrict Weapon";
                    break;
                case 131: // IP_CONST_ONHIT_CASTSPELL_ONHIT_CONSTRICTWEAPON              = 131:
                    sLast = "130: On Hit Cast Spell: Chaos Shield";
                    sSelected = "131: On Hit Cast Spell: Contrict Weapon";
                    sNext = "132: On Hit Cast Spell: Ruin Armor Bebilith";
                    break;
                case 132: // IP_CONST_ONHIT_CASTSPELL_ONHITRUINARMORBEBILITH             = 132:
                    sLast = "131: On Hit Cast Spell: Contrict Weapon";
                    sSelected = "132: On Hit Cast Spell: Ruin Armor Bebilith";
                    sNext = "133: On Hit Cast Spell: Demi-Lich Touch";
                    break;
                case 133: // IP_CONST_ONHIT_CASTSPELL_ONHITDEMILICHTOUCH                 = 133:
                    sLast = "132: On Hit Cast Spell: Ruin Armor Bebilith";
                    sSelected = "133: On Hit Cast Spell: Demi-Lich Touch";
                    sNext = "134: On Hit Cast Spell: Draco-Lich Touch";
                    break;
                case 134: // IP_CONST_ONHIT_CASTSPELL_ONHITDRACOLICHTOUCH                = 134:
                    sLast = "133: On Hit Cast Spell: Demi-Lich Touch";
                    sSelected = "134: On Hit Cast Spell: Draco-Lich Touch";
                    sNext = "135: On Hit Cast Spell: Intelligent Weapon OnHit";
                    break;
                case 135: // IP_CONST_ONHIT_CASTSPELL_INTELLIGENT_WEAPON_ONHIT           = 135:
                    sLast = "134: On Hit Cast Spell: Draco-Lich Touch";
                    sSelected = "135: On Hit Cast Spell: Intelligent Weapon OnHit";
                    sNext = "136: On Hit Cast Spell: Paralyze [2]";
                    break;
                case 136: // IP_CONST_ONHIT_CASTSPELL_PARALYZE_2                         = 136:
                    sLast = "135: On Hit Cast Spell: Intelligent Weapon OnHit";
                    sSelected = "136: On Hit Cast Spell: Paralyze [2]";
                    sNext = "137: On Hit Cast Spell: Deafening Clang";
                    break;
                case 137: // IP_CONST_ONHIT_CASTSPELL_DEAFENING_CLNG                     = 137:
                    sLast = "136: On Hit Cast Spell: Paralyze [2]";
                    sSelected = "137: On Hit Cast Spell: Deafening Clang";
                    sNext = "138: On Hit Cast Spell: Knockdown";
                    break;
                case 138: // IP_CONST_ONHIT_CASTSPELL_KNOCKDOWN                          = 138:
                    sLast = "137: On Hit Cast Spell: Deafening Clang";
                    sSelected = "138: On Hit Cast Spell: Knockdown";
                    sNext = "139: On Hit Cast Spell: Freeze";
                    break;
                case 139: // IP_CONST_ONHIT_CASTSPELL_FREEZE                             = 139:
                    sLast = "138: On Hit Cast Spell: Knockdown";
                    sSelected = "139: On Hit Cast Spell: Freeze";
                    sNext = "140: On Hit Cast Spell: Combust";
                    break;
                case 140: // IP_CONST_ONHIT_CASTSPELL_COMBUST                            = 140:
                    sLast = "139: On Hit Cast Spell: Freeze";
                    sSelected = "140: On Hit Cast Spell: Combust";
                    sNext = "0: On Hit Cast Spell: Acid Fog";
                    break;
            }
            nSubPropertyMax = 140;
            break;
//        case 83: // ITEM_PROPERTY_VISUALEFFECT                             = 83;
//            break;
//        case 84: // ITEM_PROPERTY_ARCANE_SPELL_FAILURE                     = 84;
//            break;

    }

    if (nPropertyNumber == 17 || // ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP
        nPropertyNumber == 18 || // ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP
        nPropertyNumber == 19 || // ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT
        nPropertyNumber == 48) // ITEM_PROPERTY_ON_HIT_PROPERTIES
        nSubSubProperty = TRUE;

    SetCustomToken(60001, sLast);
    SetCustomToken(60002, sSelected);
    SetCustomToken(60003, sNext);
    SetCustomToken(60004, sNumber);
    SetCustomToken(60005, sItemProperty);

    SetLocalInt(oPC, "ITEM_SUB_PROPERTY_MAXIMUM", nSubPropertyMax);
    SetLocalInt(oPC, "ITEM_SUB_SUB_PROPERTY", nSubSubProperty);
    SetLocalString(oPC, "ITEM_SUB_PROPERTY_NAME", sSelected);

    return nResult;
}
