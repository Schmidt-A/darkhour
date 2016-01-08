//::///////////////////////////////////////////////
//::
//:: DM_Itm_GetSubMod
//::
//:: dm_itm_getsubmod.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is used to get the item sub (sub)
//:: property modifier and is the third in line.
//:: It also sets the appropriate custom conversation
//:: tokens.
//::
//:: <CUSTOM70001> The last sub property modifier
//:: <CUSTOM70002> The current sub property modifier
//:: <CUSTOM70003> The next sub property modifier
//:: <CUSTOM70004> The sub property modifier number
//:: <CUSTOM70005> The name of the item property
//:: <CUSTOM70006> The sub property name
//:: <CUSTOM70007> The sub-sub property name
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
    int nResult = TRUE;

    int nPropertyNumber = GetLocalInt(oPC, "ITEM_PROPERTY_SELECTED");
    int nSubPropertyNumber = GetLocalInt(oPC, "ITEM_SUB_PROPERTY_SELECTED");
    int nPropertyModifier = GetLocalInt(oPC, "ITEM_PROPERTY_MODIFIER");
    int nPropertyMaxModifier = GetLocalInt(oPC, "ITEM_PROPERTY_MODIFIER_MAX");

    string sItemProperty = GetLocalString(oPC, "ITEM_PROPERTY_NAME");
    string sSubPropertyName = GetLocalString(oPC, "ITEM_SUB_PROPERTY_NAME");
    string sSubSubProperty = GetLocalString(oPC, "ITEM_SUB_SUB_PROPERTY_NAME");

    string sNumber = IntToString(nPropertyModifier);
    string sLast;
    string sSelected;
    string sNext;

    switch(nPropertyNumber)
    {
        case 0: // ITEM_PROPERTY_ABILITY_BONUS                            = 0 ;
        case 55: // ITEM_PROPERTY_THIEVES_TOOLS
        case 80: // ITEM_PROPERTY_HEALERS_KIT
            switch(nPropertyModifier)
            {
                case 0:
                    sLast = "12: Modifier 12";
                    sSelected = "0: Modifier 0";
                    sNext = "1: Modifier 1";
                    break;
                case 1:
                    sLast = "0: Modifier 0";
                    sSelected = "1: Modifier 1";
                    sNext = "2: Modifier 2";
                    break;
                case 2:
                    sLast = "1: Modifier 1";
                    sSelected = "2: Modifier 2";
                    sNext = "3: Modifier 3";
                    break;
                case 3:
                    sLast = "2: Modifier 2";
                    sSelected = "3: Modifier 3";
                    sNext = "4: Modifier 4";
                    break;
                case 4:
                    sLast = "3: Modifier 3";
                    sSelected = "4: Modifier 4";
                    sNext = "5: Modifier 5";
                    break;
                case 5:
                    sLast = "4: Modifier 4";
                    sSelected = "5: Modifier 5";
                    sNext = "6: Modifier 6";
                    break;
                case 6:
                    sLast = "5: Modifier 5";
                    sSelected = "6: Modifier 6";
                    sNext = "7: Modifier 7";
                    break;
                case 7:
                    sLast = "6: Modifier 6";
                    sSelected = "7: Modifier 7";
                    sNext = "8: Modifier 8";
                    break;
                case 8:
                    sLast = "7: Modifier 7";
                    sSelected = "8: Modifier 8";
                    sNext = "9: Modifier 9";
                    break;
                case 9:
                    sLast = "8: Modifier 8";
                    sSelected = "9: Modifier 9";
                    sNext = "10: Modifier 10";
                    break;
                case 10:
                    sLast = "9: Modifier 9";
                    sSelected = "10: Modifier 10";
                    sNext = "11: Modifier 11";
                    break;
                case 11:
                    sLast = "10: Modifier 10";
                    sSelected = "11: Modifier 11";
                    sNext = "12: Modifier 12";
                    break;
                case 12:
                    sLast = "11: Modifier 11";
                    sSelected = "12: Modifier 12";
                    sNext = "0: Modifier 1";
                    break;
            }
            nPropertyMaxModifier = 12;
            break;
        case 1: // ITEM_PROPERTY_AC_BONUS                                 = 1 ;
        case 2: // ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP
        case 3: // ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE
        case 4: // ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP
        case 5: // ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT
        case 6: // ITEM_PROPERTY_ENHANCEMENT_BONUS
        case 7: // ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP
        case 8: // ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP
        case 9: // ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT
        case 40: // ITEM_PROPERTY_SAVING_THROW_BONUS
        case 41: // ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC
        case 45: // ITEM_PROPERTY_MIGHTY
        case 49: // ITEM_PROPERTY_DECREASED_SAVING_THROWS
        case 50: // ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC
        case 51: // ITEM_PROPERTY_REGENERATION
        case 56: // ITEM_PROPERTY_ATTACK_BONUS
        case 57: // ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP
        case 58: // ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP
        case 59: // ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT
        case 67: // ITEM_PROPERTY_REGENERATION_VAMPIRIC
            switch(nPropertyModifier)
            {
                case 0:
                    sLast = "20: Modifier 20";
                    sSelected = "0: none";
                    sNext = "1: Modifier 1";
                    break;
                case 1:
                    sLast = "0: none";
                    sSelected = "1: Modifier 1";
                    sNext = "2: Modifier 2";
                    break;
                case 2:
                    sLast = "1: Modifier 1";
                    sSelected = "2: Modifier 2";
                    sNext = "3: Modifier 3";
                    break;
                case 3:
                    sLast = "2: Modifier 2";
                    sSelected = "3: Modifier 3";
                    sNext = "4: Modifier 4";
                    break;
                case 4:
                    sLast = "3: Modifier 3";
                    sSelected = "4: Modifier 4";
                    sNext = "5: Modifier 5";
                    break;
                case 5:
                    sLast = "4: Modifier 4";
                    sSelected = "5: Modifier 5";
                    sNext = "6: Modifier 6";
                    break;
                case 6:
                    sLast = "5: Modifier 5";
                    sSelected = "6: Modifier 6";
                    sNext = "7: Modifier 7";
                    break;
                case 7:
                    sLast = "6: Modifier 6";
                    sSelected = "7: Modifier 7";
                    sNext = "8: Modifier 8";
                    break;
                case 8:
                    sLast = "7: Modifier 7";
                    sSelected = "8: Modifier 8";
                    sNext = "9: Modifier 9";
                    break;
                case 9:
                    sLast = "8: Modifier 8";
                    sSelected = "9: Modifier 9";
                    sNext = "10: Modifier 10";
                    break;
                case 10:
                    sLast = "9: Modifier 9";
                    sSelected = "10: Modifier 10";
                    sNext = "11: Modifier 11";
                    break;
                case 11:
                    sLast = "10: Modifier 10";
                    sSelected = "11: Modifier 11";
                    sNext = "12: Modifier 12";
                    break;
                case 12:
                    sLast = "11: Modifier 11";
                    sSelected = "12: Modifier 12";
                    sNext = "13: Modifier 13";
                    break;
                case 13:
                    sLast = "12: Modifier 12";
                    sSelected = "13: Modifier 13";
                    sNext = "14: Modifier 14";
                    break;
                case 14:
                    sLast = "13: Modifier 13";
                    sSelected = "14: Modifier 14";
                    sNext = "15: Modifier 16";
                    break;
                case 15:
                    sLast = "14: Modifier 14";
                    sSelected = "15: Modifier 15";
                    sNext = "16: Modifier 16";
                    break;
                case 16:
                    sLast = "15: Modifier 15";
                    sSelected = "16: Modifier 16";
                    sNext = "17: Modifier 17";
                    break;
                case 17:
                    sLast = "16: Modifier 16";
                    sSelected = "17: Modifier 17";
                    sNext = "18: Modifier 18";
                    break;
                case 18:
                    sLast = "17: Modifier 17";
                    sSelected = "18: Modifier 18";
                    sNext = "19: Modifier 19";
                    break;
                case 19:
                    sLast = "18: Modifier 18";
                    sSelected = "19: Modifier 19";
                    sNext = "20: Modifier 20";
                    break;
                case 20:
                    sLast = "19: Modifier 19";
                    sSelected = "20: Modifier 20";
                    sNext = "0: none";
                    break;
            }
            nPropertyMaxModifier = 20;
            break;
        case 10: // ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER
        case 21: // ITEM_PROPERTY_DECREASED_DAMAGE
        case 28: // ITEM_PROPERTY_DECREASED_AC
        case 60: // ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER
            switch(nPropertyModifier)
            {
                case 0:
                    sLast = "4: Negative Modifier -5";
                    sSelected = "0: No modifier";
                    sNext = "1: Negative Modifier -1";
                    break;
                case 1:
                    sLast = "0: No modifier";
                    sSelected = "1: Negative Modifier -1";
                    sNext = "2: Negative Modifier -2";
                    break;
                case 2:
                    sLast = "1: Negative Modifier -1";
                    sSelected = "2: Negative Modifier -2";
                    sNext = "3: Negative Modifier -3";
                    break;
                case 3:
                    sLast = "2: Negative Modifier -2";
                    sSelected = "3: Negative Modifier -3";
                    sNext = "4: Negative Modifier -4";
                    break;
                case 4:
                    sLast = "3: Negative Modifier -3";
                    sSelected = "4: Negative Modifier -4";
                    sNext = "5: Negative Modifier -5";
                    break;
                case 5:
                    sLast = "4: Negative Modifier -4";
                    sSelected = "5: Negative Modifier -5";
                    sNext = "0: No modifier";
                    break;
            }
            nPropertyMaxModifier = 5;
            break;
        case 11: // ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION
            switch(nPropertyModifier)
            {
                case 0: //nothing...
                    sLast = "5: 10% weight reduction";
                    sSelected = "0: No value";
                    sNext = "1: 80% weight reduction";
                    break;
                case 1: // IP_CONST_REDUCEDWEIGHT_80_PERCENT                   = 1;
                    sLast = "0: No value";
                    sSelected = "1: 80% weight reduction";
                    sNext = "2: 60% weight reduction";
                    break;
                case 2: // IP_CONST_REDUCEDWEIGHT_60_PERCENT                   = 2;
                    sLast = "1: 80% weight reduction";
                    sSelected = "2: 60% weight reduction";
                    sNext = "3: 40% weight reduction";
                    break;
                case 3: // IP_CONST_REDUCEDWEIGHT_40_PERCENT                   = 3;
                    sLast = "2: 60% weight reduction";
                    sSelected = "3: 40% weight reduction";
                    sNext = "4: 20% weight reduction";
                    break;
                case 4: // IP_CONST_REDUCEDWEIGHT_20_PERCENT                   = 4;
                    sLast = "3: 40% weight reduction";
                    sSelected = "4: 20% weight reduction";
                    sNext = "5: 10% weight reduction";
                    break;
                case 5: // IP_CONST_REDUCEDWEIGHT_10_PERCENT                   = 5;
                    sLast = "4: 20% weight reduction";
                    sSelected = "5: 10% weight reduction";
                    sNext = "0: No value";
                    break;
            }
            nPropertyMaxModifier = 5;
            break;
        case 12: // ITEM_PROPERTY_BONUS_FEAT
            switch(nPropertyModifier)
            {
                case 0: // IP_CONST_FEAT_ALERTNESS
                    sLast = "26: Armor Profiency: Medium";
                    sSelected = "0: Alertness";
                    sNext = "1: Ambidextrous";
                    break;
                case 1: // IP_CONST_FEAT_AMBIDEXTROUS
                    sLast = "0: Alertness";
                    sSelected = "1: Ambidextrous";
                    sNext = "2: Cleave";
                    break;
                case 2: // IP_CONST_FEAT_CLEAVE
                    sLast = "1: Ambidextrous";
                    sSelected = "2: Cleave";
                    sNext = "3: Combat Casting";
                    break;
                case 3: // IP_CONST_FEAT_COMBAT_CASTING
                    sLast = "2: Cleave";
                    sSelected = "3: Combat Casting";
                    sNext = "4: Dodge";
                    break;
                case 4: // IP_CONST_FEAT_DODGE
                    sLast = "3: Combat Casting";
                    sSelected = "4: Dodge";
                    sNext = "5: Extra Turning";
                    break;
                case 5: // IP_CONST_FEAT_EXTRA_TURNING
                    sLast = "4: Dodge";
                    sSelected = "5: Extra Turning";
                    sNext = "6: Knockdown";
                    break;
                case 6: // IP_CONST_FEAT_KNOCKDOWN
                    sLast = "5: Extra Turning";
                    sSelected = "6: Knockdown";
                    sNext = "7: Point Blank Shot";
                    break;
                case 7: // IP_CONST_FEAT_POINTBLANK
                    sLast = "6: Knockdown";
                    sSelected = "7: Point Blank Shot";
                    sNext = "8: Spell Focus: Abjuration";
                    break;
                case 8: // IP_CONST_FEAT_SPELLFOCUSABJ
                    sLast = "7: Point Blank Shot";
                    sSelected = "8: Spell Focus: Abjuration";
                    sNext = "9: Spell Focus: Conjuration";
                    break;
                case 9: // IP_CONST_FEAT_SPELLFOCUSCON
                    sLast = "8: Spell Focus: Abjuration";
                    sSelected = "9: Spell Focus: Conjuration";
                    sNext = "10: Spell Focus: Divination";
                    break;
                case 10: // IP_CONST_FEAT_SPELLFOCUSDIV
                    sLast = "9: Spell Focus: Conjuration";
                    sSelected = "10: Spell Focus: Divination";
                    sNext = "11: Spell Focus: Enchantment";
                    break;
                case 11: // IP_CONST_FEAT_SPELLFOCUSENC
                    sLast = "10: Spell Focus: Divination";
                    sSelected = "11: Spell Focus: Enchantment";
                    sNext = "12: Spell Focus: Evocation";
                    break;
                case 12: // IP_CONST_FEAT_SPELLFOCUSEVO
                    sLast = "11: Spell Focus: Enchantment";
                    sSelected = "12: Spell Focus: Evocation";
                    sNext = "13: Spell Focus: Illusion";
                    break;
                case 13: // IP_CONST_FEAT_SPELLFOCUSILL
                    sLast = "12: Spell Focus: Evocation";
                    sSelected = "13: Spell Focus: Illusion";
                    sNext = "14: Spell Focus: Necromancy";
                    break;
                case 14: // IP_CONST_FEAT_SPELLFOCUSNEC
                    sLast = "13: Spell Focus: Illusion";
                    sSelected = "14: Spell Focus: Necromancy";
                    sNext = "15: Spell Penetration";
                    break;
                case 15: // IP_CONST_FEAT_SPELLPENETRATION
                    sLast = "14: Spell Focus: Necromancy";
                    sSelected = "15: Spell Penetration";
                    sNext = "16: Power Attack";
                    break;
                case 16: // IP_CONST_FEAT_POWERATTACK
                    sLast = "15: Spell Penetration";
                    sSelected = "16: Power Attack";
                    sNext = "17: Two Weapon Fighting";
                    break;
                case 17: // IP_CONST_FEAT_TWO_WEAPON_FIGHTING
                    sLast = "16: Power Attack";
                    sSelected = "17: Two Weapon Fighting";
                    sNext = "18: Weapon Specialization: Unarmed";
                    break;
                case 18: // IP_CONST_FEAT_WEAPSPEUNARM
                    sLast = "17: Two Weapon Fighting";
                    sSelected = "18: Weapon Specialization: Unarmed";
                    sNext = "19: Weapon Finesse";
                    break;
                case 19: // IP_CONST_FEAT_WEAPFINESSE
                    sLast = "18: Weapon Specialization: Unarmed";
                    sSelected = "19: Weapon Finesse";
                    sNext = "20: Improved Critical: Unarmed";
                    break;
                case 20: // IP_CONST_FEAT_IMPCRITUNARM
                    sLast = "19: Weapon Finesse";
                    sSelected = "20: Improved Critical: Unarmed";
                    sNext = "21: Weapon Profiency: Exotic";
                    break;
                case 21: // IP_CONST_FEAT_WEAPON_PROF_EXOTIC
                    sLast = "20: Improved Critical: Unarmed";
                    sSelected = "21: Weapon Profiency: Exotic";
                    sNext = "22: Weapon Profiency: Martial";
                    break;
                case 22: // IP_CONST_FEAT_WEAPON_PROF_MARTIAL
                    sLast = "21: Weapon Profiency: Exotic";
                    sSelected = "22: Weapon Profiency: Martial";
                    sNext = "23: Weapon Profiency: Simple";
                    break;
                case 23: // IP_CONST_FEAT_WEAPON_PROF_SIMPLE
                    sLast = "22: Weapon Profiency: Martial";
                    sSelected = "23: Weapon Profiency: Simple";
                    sNext = "24: Armor Profiency: Heavy";
                    break;
                case 24: // IP_CONST_FEAT_ARMOR_PROF_HEAVY
                    sLast = "23: Weapon Profiency: Simple";
                    sSelected = "24: Armor Profiency: Heavy";
                    sNext = "25: Armor Profiency: Light";
                    break;
                case 25: // IP_CONST_FEAT_ARMOR_PROF_LIGHT
                    sLast = "24: Armor Profiency: Heavy";
                    sSelected = "25: Armor Profiency: Light";
                    sNext = "26: Armor Profiency: Medium";
                    break;
                case 26: // IP_CONST_FEAT_ARMOR_PROF_MEDIUM
                    sLast = "25: Armor Profiency: Light";
                    sSelected = "26: Armor Profiency: Medium";
                    sNext = "0: Alertness";
                    break;
            }

            nPropertyMaxModifier = 26;
            break;

        case 13: // ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N
            switch(nPropertyModifier)
            {
                case 0:
                    sLast = "9: Level 9";
                    sSelected = "0: Level 0";
                    sNext = "1: Level 1";
                    break;
                case 1:
                    sLast = "0: Level 0";
                    sSelected = "1: Level 1";
                    sNext = "2: Level 2";
                    break;
                case 2:
                    sLast = "1: Level 1";
                    sSelected = "2: Level 2";
                    sNext = "3: Level 3";
                    break;
                case 3:
                    sLast = "2: Level 2";
                    sSelected = "3: Level 3";
                    sNext = "4: Level 4";
                    break;
                case 4:
                    sLast = "3: Level 3";
                    sSelected = "4: Level 4";
                    sNext = "5: Level 5";
                    break;
                case 5:
                    sLast = "4: Level 4";
                    sSelected = "5: Level 5";
                    sNext = "6: Level 6";
                    break;
                case 6:
                    sLast = "5: Level 5";
                    sSelected = "6: Level 6";
                    sNext = "7: Level 7";
                    break;
                case 7:
                    sLast = "6: Level 6";
                    sSelected = "7: Level 7";
                    sNext = "8: Level 8";
                    break;
                case 8:
                    sLast = "7: Level 7";
                    sSelected = "8: Level 8";
                    sNext = "9: Level 9";
                    break;
                case 9:
                    sLast = "8: Level 8";
                    sSelected = "9: Level 9";
                    sNext = "0: Level 0";
                    break;
            }
            nPropertyMaxModifier = 9;
            break;
case 14: //
        case 15: // ITEM_PROPERTY_CAST_SPELL
            switch(nPropertyModifier)
            {
                case 0:
                    sLast = "13: Unlimited Use";
                    sSelected = "0: Nothing";
                    sNext = "1: Single Use";
                    break;
                case 1: // IP_CONST_CASTSPELL_NUMUSES_SINGLE_USE
                    sLast = "0: Nothing";
                    sSelected = "1: Single Use";
                    sNext = "2: 5 Charges per Use";
                    break;
                case 2: // IP_CONST_CASTSPELL_NUMUSES_5_CHARGES_PER_USE
                    sLast = "1: Single Use";
                    sSelected = "2: 5 Charges per Use";
                    sNext = "3: 4 Charges per Use";
                    break;
                case 3: // IP_CONST_CASTSPELL_NUMUSES_4_CHARGES_PER_USE
                    sLast = "2: 5 Charges per Use";
                    sSelected = "3: 4 Charges per Use";
                    sNext = "4: 3 Charges per Use";
                    break;
                case 4: // IP_CONST_CASTSPELL_NUMUSES_3_CHARGES_PER_USE
                    sLast = "3: 4 Charges per Use";
                    sSelected = "4: 3 Charges per Use";
                    sNext = "5: 2 Charges per Use";
                    break;
                case 5: // IP_CONST_CASTSPELL_NUMUSES_2_CHARGES_PER_USE
                    sLast = "4: 3 Charges per Use";
                    sSelected = "5: 2 Charges per Use";
                    sNext = "6: 1 Charge per Use";
                    break;
                case 6: // IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE
                    sLast = "5: 2 Charges per Use";
                    sSelected = "6: 1 Charge per Use";
                    sNext = "7: 0 Charges per Use";
                    break;
                case 7: // IP_CONST_CASTSPELL_NUMUSES_0_CHARGES_PER_USE
                    sLast = "6: 1 Charge per Use";
                    sSelected = "7: 0 Charges per Use";
                    sNext = "8: 1 Use per Day";
                    break;
                case 8: // IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY
                    sLast = "7: 0 Charges per Use";
                    sSelected = "8: 1 Use per Day";
                    sNext = "9: 2 Uses per Day";
                    break;
                case 9: // IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY
                    sLast = "7: 1 Use per Day";
                    sSelected = "9: 2 Uses per Day";
                    sNext = "10: 3 Uses per Day";
                    break;
                case 10: // IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY
                    sLast = "9: 2 Uses per Day";
                    sSelected = "10: 3 Uses per Day";
                    sNext = "11: 4 Uses per Day";
                    break;
                case 11: // IP_CONST_CASTSPELL_NUMUSES_4_USES_PER_DAY
                    sLast = "10: 3 Uses per Day";
                    sSelected = "11: 4 Uses per Day";
                    sNext = "12: 5 Uses per Day";
                    break;
                case 12: // IP_CONST_CASTSPELL_NUMUSES_5_USES_PER_DAY
                    sLast = "11: 4 Uses per Day";
                    sSelected = "12: 5 Uses per Day";
                    sNext = "13: Unlimited Use";
                    break;
                case 13: // IP_CONST_CASTSPELL_NUMUSES_UNLIMITED_USE
                    sLast = "12: 5 Uses per Day";
                    sSelected = "13: Unlimited Use";
                    sNext = "0: Nothing";
                    break;
            }
            nPropertyMaxModifier = 13;
            break;
        case 16: // ITEM_PROPERTY_DAMAGE_BONUS
        case 17: // ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP
        case 18: // ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP
        case 19: // ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT
        case 74: // ITEM_PROPERTY_MASSIVE_CRITICALS
            switch(nPropertyModifier)
            {
                case 0:
                    sLast = "20: Damage Bonus 10";
                    sSelected = "0: none";
                    sNext = "1: Damage Bonus 1";
                    break;
                case 1: // IP_CONST_DAMAGEBONUS_1
                    sLast = "0: none";
                    sSelected = "1: Damage Bonus 1";
                    sNext = "2: Damage Bonus 2";
                    break;
                case 2: // IP_CONST_DAMAGEBONUS_2
                    sLast = "1: Damage Bonus 1";
                    sSelected = "2: Damage Bonus 2";
                    sNext = "3: Damage Bonus 3";
                    break;
                case 3: // IP_CONST_DAMAGEBONUS_3
                    sLast = "2: Damage Bonus 2";
                    sSelected = "3: Damage Bonus 3";
                    sNext = "4: Damage Bonus 4";
                    break;
                case 4: // IP_CONST_DAMAGEBONUS_4
                    sLast = "3: Damage Bonus 3";
                    sSelected = "4: Damage Bonus 4";
                    sNext = "5: Damage Bonus 5";
                    break;
                case 5: // IP_CONST_DAMAGEBONUS_5
                    sLast = "4: Damage Bonus 4";
                    sSelected = "5: Damage Bonus 5";
                    sNext = "6: Damage Bonus 1d4";
                    break;
                case 6: // IP_CONST_DAMAGEBONUS_1d4
                    sLast = "5: Damage Bonus 5";
                    sSelected = "6: Damage Bonus 1d4";
                    sNext = "7: Damage Bonus 1d6";
                    break;
                case 7: // IP_CONST_DAMAGEBONUS_1d6
                    sLast = "6: Damage Bonus 1d4";
                    sSelected = "7: Damage Bonus 1d6";
                    sNext = "8: Damage Bonus 1d8";
                    break;
                case 8: // IP_CONST_DAMAGEBONUS_1d8
                    sLast = "7: Damage Bonus 1d6";
                    sSelected = "8: Damage Bonus 1d8";
                    sNext = "9: Damage Bonus 1d10";
                    break;
                case 9: // IP_CONST_DAMAGEBONUS_1d10
                    sLast = "8: Damage Bonus 1d8";
                    sSelected = "9: Damage Bonus 1d10";
                    sNext = "10: Damage Bonus 2d6";
                    break;
                case 10: // IP_CONST_DAMAGEBONUS_2d6
                    sLast = "9: Damage Bonus 1d10";
                    sSelected = "10: Damage Bonus 2d6";
                    sNext = "11: Damage Bonus 2d8";
                    break;
                case 11: // IP_CONST_DAMAGEBONUS_2d8
                    sLast = "10: Damage Bonus 2d6";
                    sSelected = "11: Damage Bonus 2d8";
                    sNext = "12: Damage Bonus 2d4";
                    break;
                case 12: // IP_CONST_DAMAGEBONUS_2d4
                    sLast = "11: Damage Bonus 2d8";
                    sSelected = "12: Damage Bonus 2d4";
                    sNext = "13: Damage Bonus 2d10";
                    break;
                case 13: // IP_CONST_DAMAGEBONUS_2d10
                    sLast = "12: Damage Bonus 2d4";
                    sSelected = "13: Damage Bonus 2d10";
                    sNext = "14: Damage Bonus 1d12";
                    break;
                case 14: // IP_CONST_DAMAGEBONUS_1d12
                    sLast = "13: Damage Bonus 2d10";
                    sSelected = "14: Damage Bonus 1d12";
                    sNext = "15: Damage Bonus 2d12";
                    break;
                case 15: // IP_CONST_DAMAGEBONUS_2d12
                    sLast = "14: Damage Bonus 1d12";
                    sSelected = "15: Damage Bonus 2d12";
                    sNext = "16: Damage Bonus 6";
                    break;
                case 16: // IP_CONST_DAMAGEBONUS_6
                    sLast = "15: Damage Bonus 2d12";
                    sSelected = "16: Damage Bonus 6";
                    sNext = "17: Damage Bonus 7";
                    break;
                case 17: // IP_CONST_DAMAGEBONUS_7
                    sLast = "16: Damage Bonus 6";
                    sSelected = "17: Damage Bonus 7";
                    sNext = "18: Damage Bonus 8";
                    break;
                case 18: // IP_CONST_DAMAGEBONUS_8
                    sLast = "17: Damage Bonus 7";
                    sSelected = "18: Damage Bonus 8";
                    sNext = "19: Damage Bonus 9";
                    break;
                case 19: // IP_CONST_DAMAGEBONUS_9
                    sLast = "18: Damage Bonus 8";
                    sSelected = "19: Damage Bonus 9";
                    sNext = "20: Damage Bonus 10";
                    break;
                case 20: // IP_CONST_DAMAGEBONUS_10
                    sLast = "19: Damage Bonus 9";
                    sSelected = "20: Damage Bonus 10";
                    sNext = "0: none";
                    break;
            }
            nPropertyMaxModifier = 20;
            break;
        case 20: // ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE
        case 24: // ITEM_PROPERTY_DAMAGE_VULNERABILITY
            switch(nPropertyModifier)
            {
                case 0:
                    sLast = "7: 100%";
                    sSelected = "0: none";
                    sNext = "1: 5%";
                    break;
                case 1: // IP_CONST_DAMAGEIMMUNITY_5_PERCENT
                    sLast = "0: none";
                    sSelected = "1: 5%";
                    sNext = "2: 10%";
                    break;
                case 2: // IP_CONST_DAMAGEIMMUNITY_10_PERCENT
                    sLast = "1: 5%";
                    sSelected = "2: 10%";
                    sNext = "3: 25%";
                    break;
                case 3: // IP_CONST_DAMAGEIMMUNITY_25_PERCENT
                    sLast = "2: 10%";
                    sSelected = "3: 25%";
                    sNext = "4: 50%";
                    break;
                case 4: // IP_CONST_DAMAGEIMMUNITY_50_PERCENT
                    sLast = "3: 25%";
                    sSelected = "4: 50%";
                    sNext = "5: 75%";
                    break;
                case 5: // IP_CONST_DAMAGEIMMUNITY_75_PERCENT
                    sLast = "4: 50%";
                    sSelected = "5: 75%";
                    sNext = "6: 90%";
                    break;
                case 6: // IP_CONST_DAMAGEIMMUNITY_90_PERCENT
                    sLast = "5: 75%";
                    sSelected = "6: 90%";
                    sNext = "7: 100%";
                    break;
                case 7: // IP_CONST_DAMAGEIMMUNITY_100_PERCENT
                    sLast = "6: 90%";
                    sSelected = "7: 100%";
                    sNext = "0: none";
                    break;
            }
            nPropertyMaxModifier = 7;
            break;
//case 21: // ITEM_PROPERTY_DECREASED_DAMAGE
        case 22: // ITEM_PROPERTY_DAMAGE_REDUCTION
            switch(nPropertyModifier)
            {
                case 0:
                    sLast = "10: Soak 50 HPs";
                    sSelected = "0: none";
                    sNext = "1: Soak 5 HPs";
                    break;
                case 1: // IP_CONST_DAMAGESOAK_5_HP
                    sLast = "0: none";
                    sSelected = "1: Soak 5 HPs";
                    sNext = "2: Soak 10 HPs";
                    break;
                case 2: // IP_CONST_DAMAGESOAK_10_HP
                    sLast = "1: Soak 5 HPs";
                    sSelected = "2: Soak 10 HPs";
                    sNext = "3: Soak 15 HPs";
                    break;
                case 3: // IP_CONST_DAMAGESOAK_15_HP
                    sLast = "2: Soak 10 HPs";
                    sSelected = "3: Soak 15 HPs";
                    sNext = "4: Soak 20 HPs";
                    break;
                case 4: // IP_CONST_DAMAGESOAK_20_HP
                    sLast = "3: Soak 15 HPs";
                    sSelected = "4: Soak 20 HPs";
                    sNext = "5: Soak 25 HPs";
                    break;
                case 5: // IP_CONST_DAMAGESOAK_25_HP
                    sLast = "4: Soak 20 HPs";
                    sSelected = "5: Soak 25 HPs";
                    sNext = "6: Soak 30 HPs";
                    break;
                case 6: // IP_CONST_DAMAGESOAK_30_HP
                    sLast = "5: Soak 25 HPs";
                    sSelected = "6: Soak 30 HPs";
                    sNext = "7: Soak 35 HPs";
                    break;
                case 7: // IP_CONST_DAMAGESOAK_35_HP
                    sLast = "6: Soak 30 HPs";
                    sSelected = "7: Soak 35 HPs";
                    sNext = "8: Soak 40 HPs";
                    break;
                case 8: // IP_CONST_DAMAGESOAK_40_HP
                    sLast = "7: Soak 35 HPs";
                    sSelected = "8: Soak 40 HPs";
                    sNext = "9: Soak 45 HPs";
                    break;
                case 9: // IP_CONST_DAMAGESOAK_45_HP
                    sLast = "8: Soak 40 HPs";
                    sSelected = "9: Soak 45 HPs";
                    sNext = "10: Soak 50 HPs";
                    break;
                case 10: // IP_CONST_DAMAGESOAK_50_HP
                    sLast = "9: Soak 45 HPs";
                    sSelected = "10: Soak 50 HPs";
                    sNext = "0: none";
                    break;
            }
            nPropertyMaxModifier = 10;
            break;
case 23: // ITEM_PROPERTY_DAMAGE_RESISTANCE
            switch(nPropertyModifier)
            {
                case 0:
                    sLast = "10: Damage Resist 50";
                    sSelected = "0: none";
                    sNext = "1: Damage Resist 5";
                    break;
                case 1: // IP_CONST_DAMAGERESIST_5
                    sLast = "0: none";
                    sSelected = "1: Damage Resist 5";
                    sNext = "2: Damage Resist 10";
                    break;
                case 2: // IP_CONST_DAMAGERESIST_10
                    sLast = "1: Damage Resist 5";
                    sSelected = "2: Damage Resist 10";
                    sNext = "3: Damage Resist 15";
                    break;
                case 3: // IP_CONST_DAMAGERESIST_15
                    sLast = "2: Damage Resist 10";
                    sSelected = "3: Damage Resist 15";
                    sNext = "4: Damage Resist 20";
                    break;
                case 4: // IP_CONST_DAMAGERESIST_20
                    sLast = "3: Damage Resist 15";
                    sSelected = "4: Damage Resist 20";
                    sNext = "5: Damage Resist 25";
                    break;
                case 5: // IP_CONST_DAMAGERESIST_25
                    sLast = "4: Damage Resist 20";
                    sSelected = "5: Damage Resist 25";
                    sNext = "6: Damage Resist 30";
                    break;
                case 6: // IP_CONST_DAMAGERESIST_30
                    sLast = "5: Damage Resist 25";
                    sSelected = "6: Damage Resist 30";
                    sNext = "7: Damage Resist 35";
                    break;
                case 7: // IP_CONST_DAMAGERESIST_35
                    sLast = "6: Damage Resist 30";
                    sSelected = "7: Damage Resist 35";
                    sNext = "8: Damage Resist 40";
                    break;
                case 8: // IP_CONST_DAMAGERESIST_40
                    sLast = "7: Damage Resist 35";
                    sSelected = "8: Damage Resist 40";
                    sNext = "9: Damage Resist 45";
                    break;
                case 9: // IP_CONST_DAMAGERESIST_45
                    sLast = "8: Damage Resist 40";
                    sSelected = "9: Damage Resist 45";
                    sNext = "10: Damage Resist 50";
                    break;
                case 10: // IP_CONST_DAMAGERESIST_50
                    sLast = "9: Damage Resist 45";
                    sSelected = "10: Damage Resist 50";
                    sNext = "0: none";
                    break;
            }
            nPropertyMaxModifier = 5;
            break;
//case 24: // ITEM_PROPERTY_DAMAGE_VULNERABILITY
case 25: //
case 26: // ITEM_PROPERTY_DARKVISION only 1 property

        case 27: // ITEM_PROPERTY_DECREASED_ABILITY_SCORE
        case 29: // ITEM_PROPERTY_DECREASED_SKILL_MODIFIER
            switch(nPropertyModifier)
            {
                case 0:
                    sLast = "10: Negative Modifier -10";
                    sSelected = "0: No modifier";
                    sNext = "1: Negative Modifier -1";
                    break;
                case 1:
                    sLast = "0: No modifier";
                    sSelected = "1: Negative Modifier -1";
                    sNext = "2: Negative Modifier -2";
                    break;
                case 2:
                    sLast = "1: Negative Modifier -1";
                    sSelected = "2: Negative Modifier -2";
                    sNext = "3: Negative Modifier -3";
                    break;
                case 3:
                    sLast = "2: Negative Modifier -2";
                    sSelected = "3: Negative Modifier -3";
                    sNext = "4: Negative Modifier -4";
                    break;
                case 4:
                    sLast = "3: Negative Modifier -3";
                    sSelected = "4: Negative Modifier -4";
                    sNext = "5: Negative Modifier -5";
                    break;
                case 5:
                    sLast = "4: Negative Modifier -4";
                    sSelected = "5: Negative Modifier -5";
                    sNext = "6: Negative Modifier -6";
                    break;
                case 6:
                    sLast = "5: Negative Modifier -5";
                    sSelected = "6: Negative Modifier -6";
                    sNext = "7: Negative Modifier -7";
                    break;
                case 7:
                    sLast = "6: Negative Modifier -6";
                    sSelected = "7: Negative Modifier -7";
                    sNext = "8: Negative Modifier -8";
                    break;
                case 8:
                    sLast = "7: Negative Modifier -7";
                    sSelected = "8: Negative Modifier -8";
                    sNext = "9: Negative Modifier -9";
                    break;
                case 9:
                    sLast = "8: Negative Modifier -8";
                    sSelected = "9: Negative Modifier -9";
                    sNext = "10: Negative Modifier -10";
                    break;
                case 10:
                    sLast = "9: Negative Modifier -9";
                    sSelected = "10: Negative Modifier -10";
                    sNext = "0: No modifier";
                    break;
            }
            nPropertyMaxModifier = 10;
            break;
//case 28: // ITEM_PROPERTY_DECREASED_AC
//case 29: // ITEM_PROPERTY_DECREASED_SKILL_MODIFIER
case 30: //
case 31: //
            switch(nPropertyModifier)
            {

                case 0:
                    sLast = "";
                    sSelected = "";
                    sNext = "";
                    break;
            }
            nPropertyMaxModifier = 5;
            break;
        case 32: // ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT
            switch(nPropertyModifier)
            {
                case 0:
                    sLast = "5: 100%";
                    sSelected = "0: none";
                    sNext = "1: 20%";
                    break;
                case 1: // IP_CONST_CONTAINERWEIGHTRED_20_PERCENT
                    sLast = "0: none";
                    sSelected = "1: 20%";
                    sNext = "2: 40%";
                    break;
                case 2: // IP_CONST_CONTAINERWEIGHTRED_40_PERCENT
                    sLast = "1: 20%";
                    sSelected = "2: 40%";
                    sNext = "3: 60%";
                    break;
                case 3: // IP_CONST_CONTAINERWEIGHTRED_60_PERCENT
                    sLast = "2: 40%";
                    sSelected = "3: 60%";
                    sNext = "4: 80%";
                    break;
                case 4: // IP_CONST_CONTAINERWEIGHTRED_80_PERCENT
                    sLast = "3: 60%";
                    sSelected = "4: 80%";
                    sNext = "5: 100%";
                    break;
                case 5: // IP_CONST_CONTAINERWEIGHTRED_100_PERCENT
                    sLast = "4: 80%";
                    sSelected = "5: 100%";
                    sNext = "0: none";
                    break;
            }
            nPropertyMaxModifier = 5;
            break;
case 33: // ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE  no extra subs
case 34: // ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE no extra subs
case 35: // ITEM_PROPERTY_HASTE no extra subs
case 36: // ITEM_PROPERTY_HOLY_AVENGER no extra subs
case 37: // ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS no extra subs
case 38: // ITEM_PROPERTY_IMPROVED_EVASION no extra subs

        case 39: // ITEM_PROPERTY_SPELL_RESISTANCE
            switch(nPropertyModifier)
            {
                case 0: // IP_CONST_SPELLRESISTANCEBONUS_10
                    sLast = "11: SR 32";
                    sSelected = "0: SR 10";
                    sNext = "1: SR 12";
                    break;
                case 1: // IP_CONST_SPELLRESISTANCEBONUS_12
                    sLast = "0: SR 10";
                    sSelected = "1: SR 12";
                    sNext = "2: SR 14";
                    break;
                case 2: // IP_CONST_SPELLRESISTANCEBONUS_14
                    sLast = "1: SR 12";
                    sSelected = "2: SR 14";
                    sNext = "3: SR 16";
                    break;
                case 3: // IP_CONST_SPELLRESISTANCEBONUS_16
                    sLast = "2: SR 14";
                    sSelected = "3: SR 16";
                    sNext = "4: SR 18";
                    break;
                case 4: // IP_CONST_SPELLRESISTANCEBONUS_18
                    sLast = "3: SR 16";
                    sSelected = "4: SR 18";
                    sNext = "5: SR 20";
                    break;
                case 5: // IP_CONST_SPELLRESISTANCEBONUS_20
                    sLast = "4: SR 18";
                    sSelected = "5: SR 20";
                    sNext = "6: SR 22";
                    break;
                case 6: // IP_CONST_SPELLRESISTANCEBONUS_22
                    sLast = "5: SR 20";
                    sSelected = "6: SR 22";
                    sNext = "7: SR 24";
                    break;
                case 7: // IP_CONST_SPELLRESISTANCEBONUS_24
                    sLast = "6: SR 22";
                    sSelected = "7: SR 24";
                    sNext = "8: SR 26";
                    break;
                case 8: // IP_CONST_SPELLRESISTANCEBONUS_26
                    sLast = "7: SR 24";
                    sSelected = "8: SR 26";
                    sNext = "9: SR 28";
                    break;
                case 9: // IP_CONST_SPELLRESISTANCEBONUS_28
                    sLast = "8: SR 26";
                    sSelected = "9: SR 28";
                    sNext = "10: SR 30";
                    break;
                case 10: // IP_CONST_SPELLRESISTANCEBONUS_30
                    sLast = "9: SR 28";
                    sSelected = "10: SR 30";
                    sNext = "11: SR 32";
                    break;
                case 11: // IP_CONST_SPELLRESISTANCEBONUS_32
                    sLast = "10: SR 30";
                    sSelected = "11: SR 32";
                    sNext = "0: SR 10";
                    break;
            }
            nPropertyMaxModifier = 11;
            break;
//case 40: // ITEM_PROPERTY_SAVING_THROW_BONUS
//case 41: // ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC
case 42: //

case 43: // ITEM_PROPERTY_KEEN   no subs

case 44: // ITEM_PROPERTY_LIGHT
            switch(nPropertyModifier)
            {
                case 0: // IP_CONST_LIGHTCOLOR_BLUE
                    sLast = "6: White";
                    sSelected = "0: Blue";
                    sNext = "1: Yellow";
                    break;
                case 1: // IP_CONST_LIGHTCOLOR_YELLOW
                    sLast = "0: Blue";
                    sSelected = "1: Yellow";
                    sNext = "2: Purple";
                    break;
                case 2: // IP_CONST_LIGHTCOLOR_PURPLE
                    sLast = "1: Yellow";
                    sSelected = "2: Purple";
                    sNext = "3: Red";
                    break;
                case 3: // IP_CONST_LIGHTCOLOR_RED
                    sLast = "2: Purple";
                    sSelected = "3: Red";
                    sNext = "4: Green";
                    break;
                case 4: // IP_CONST_LIGHTCOLOR_GREEN
                    sLast = "3: Red";
                    sSelected = "4: Green";
                    sNext = "5: Orange";
                    break;
                case 5: // IP_CONST_LIGHTCOLOR_ORANGE
                    sLast = "4: Green";
                    sSelected = "5: Orange";
                    sNext = "6: White";
                    break;
                case 6: // IP_CONST_LIGHTCOLOR_WHITE
                    sLast = "5: Orange";
                    sSelected = "6: White";
                    sNext = "0: Blue";
                    break;
            }
            nPropertyMaxModifier = 6;
            break;
//case 45: // ITEM_PROPERTY_MIGHTY
case 46: // ITEM_PROPERTY_MIND_BLANK  not able to apply this one
case 47: // ITEM_PROPERTY_NO_DAMAGE no subs

        case 48: // ITEM_PROPERTY_ON_HIT_PROPERTIES
            sLast = "no further modifiers";
            sSelected = "no further modifiers";
            sNext = "no further modifiers";
            switch(nSubPropertyNumber)
            {
                case 0: // IP_CONST_ONHIT_SLEEP
                case 1: // IP_CONST_ONHIT_STUN                         = 1;
                case 2: // IP_CONST_ONHIT_HOLD                         = 2;
                case 3: // IP_CONST_ONHIT_CONFUSION                    = 3;
                case 4: // IP_CONST_ONHIT_DAZE                         = 5;
                case 5: // IP_CONST_ONHIT_DOOM                         = 6;
                case 6: // IP_CONST_ONHIT_FEAR                         = 7;
                case 8: // IP_CONST_ONHIT_SLOW                         = 9;
                case 13: // IP_CONST_ONHIT_SILENCE                      = 14;
                case 14: // IP_CONST_ONHIT_DEAFNESS                     = 15;
                case 15: // IP_CONST_ONHIT_BLINDNESS                    = 16;
                    switch(nPropertyModifier)
                    {
                            case 0: // IP_CONST_ONHIT_DURATION_5_PERCENT_5_ROUNDS
                                sLast = "4: Chance 75%, 1 Round Duration";
                                sSelected = "0: Chance 5%, 5 Rounds Duration";
                                sNext = "1: Chance 10%, 4 Rounds Duration";
                                break;
                            case 1: // IP_CONST_ONHIT_DURATION_10_PERCENT_4_ROUNDS
                                sLast = "0: Chance 5%, 5 Rounds Duration";
                                sSelected = "1: Chance 10%, 4 Rounds Duration";
                                sNext = "2: Chance 25%, 3 Rounds Duration";
                                break;
                            case 2: // IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS
                                sLast = "1: Chance 10%, 4 Rounds Duration";
                                sSelected = "2: Chance 25%, 3 Rounds Duration";
                                sNext = "3: Chance 50%, 2 Rounds Duration";
                                break;
                            case 3: // IP_CONST_ONHIT_DURATION_50_PERCENT_2_ROUNDS
                                sLast = "2: Chance 25%, 3 Rounds Duration";
                                sSelected = "3: Chance 50%, 2 Rounds Duration";
                                sNext = "4: Chance 75%, 1 Round Duration";
                                break;
                            case 4: // IP_CONST_ONHIT_DURATION_75_PERCENT_1_ROUND
                                sLast = "3: Chance 50%, 2 Rounds Duration";
                                sSelected = "4: Chance 75%, 1 Round Duration";
                                sNext = "0: Chance 5%, 5 Rounds Duration";
                                break;
                    }
                    nPropertyMaxModifier = 4;
                    break;
                case 17: // IP_CONST_ONHIT_ABILITYDRAIN                 = 18;
                    switch(nPropertyModifier)
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
                    nPropertyMaxModifier = 5;
                    break;
                case 18: // IP_CONST_ONHIT_ITEMPOISON                   = 19;
                    switch(nPropertyModifier)
                    {
                        case 0: // IP_CONST_POISON_1D2_STRDAMAGE
                            sLast = "5: 1d2 CHA Damage";
                            sSelected = "0: 1d2 STR Damage";
                            sNext = "1: 1d2 DEX Damage";
                            break;
                        case 1: // IP_CONST_POISON_1D2_DEXDAMAGE
                            sLast = "0: 1d2 STR Damage";
                            sSelected = "1: 1d2 DEX Damage";
                            sNext = "2: 1d2 CON Damage";
                            break;
                        case 2: // IP_CONST_POISON_1D2_CONDAMAGE
                            sLast = "1: 1d2 DEX Damage";
                            sSelected = "2: 1d2 CON Damage";
                            sNext = "3: 1d2 INT Damage";
                            break;
                        case 3: // IP_CONST_POISON_1D2_INTDAMAGE
                            sLast = "2: 1d2 CON Damage";
                            sSelected = "3: 1d2 INT Damage";
                            sNext = "4: 1d2 WIS Damage";
                            break;
                        case 4: // IP_CONST_POISON_1D2_WISDAMAGE
                            sLast = "3: 1d2 INT Damage";
                            sSelected = "4: 1d2 WIS Damage";
                            sNext = "5: 1d2 CHA Damage";
                            break;
                        case 5: // IP_CONST_POISON_1D2_CHADAMAGE
                            sLast = "4: 1d2 WIS Damage";
                            sSelected = "5: 1d2 CHA Damage";
                            sNext = "0: 1d2 STR Damage";
                            break;
                    }
                    nPropertyMaxModifier = 5;
                    break;
                case 19: // IP_CONST_ONHIT_DISEASE                      = 20;
                    switch(nPropertyModifier)
                    {
                        case 0: // DISEASE_BLINDING_SICKNESS
                            sLast = "16: Vermin Madness";
                            sSelected = "0: Blinding Sickness";
                            sNext = "1: Cackle Fever";
                            break;
                        case 1: // DISEASE_CACKLE_FEVER
                            sLast = "0: Blinding Sickness";
                            sSelected = "1: Cackle Fever";
                            sNext = "2: Devil Chills";
                            break;
                        case 2: // DISEASE_DEVIL_CHILLS
                            sLast = "1: Cackle Fever";
                            sSelected = "2: Devil Chills";
                            sNext = "3: Demon Fever";
                            break;
                        case 3: // DISEASE_DEMON_FEVER
                            sLast = "2: Devil Chills";
                            sSelected = "3: Demon Fever";
                            sNext = "4: Filth Fever";
                            break;
                        case 4: // DISEASE_FILTH_FEVER
                            sLast = "3: Demon Fever";
                            sSelected = "4: Filth Fever";
                            sNext = "5: Mindfire";
                            break;
                        case 5: // DISEASE_MINDFIRE
                            sLast = "4: Filth Fever";
                            sSelected = "5: Mindfire";
                            sNext = "6: Mummy Rot";
                            break;
                        case 6: // DISEASE_MUMMY_ROT
                            sLast = "5: Mindfire";
                            sSelected = "6: Mummy Rot";
                            sNext = "7: Red Ache";
                            break;
                        case 7: // DISEASE_RED_ACHE
                            sLast = "6: Mummy Rot";
                            sSelected = "7: Red Ache";
                            sNext = "8: Shakes";
                            break;
                        case 8: // DISEASE_SHAKES
                            sLast = "7: Red Ache";
                            sSelected = "8: Shakes";
                            sNext = "9: Slimy Doom";
                            break;
                        case 9: // DISEASE_SLIMY_DOOM
                            sLast = "8: Shakes";
                            sSelected = "9: Slimy Doom";
                            sNext = "10: Red Slaad Eggs";
                            break;
                        case 10: // DISEASE_RED_SLAAD_EGGS
                            sLast = "9: Slimy Doom";
                            sSelected = "10: Red Slaad Eggs";
                            sNext = "11: Ghoul Rot";
                            break;
                        case 11: // DISEASE_GHOUL_ROT
                            sLast = "10: Red Slaad Eggs";
                            sSelected = "11: Ghoul Rot";
                            sNext = "12: Zombie Creep";
                            break;
                        case 12: // DISEASE_ZOMBIE_CREEP
                            sLast = "11: Ghoul Rot";
                            sSelected = "12: Zombie Creep";
                            sNext = "13: Dread Blisters";
                            break;
                        case 13: // DISEASE_DREAD_BLISTERS
                            sLast = "12: Zombie Creep";
                            sSelected = "13: Dread Blisters";
                            sNext = "14: Burrow Maggots";
                            break;
                        case 14: // DISEASE_BURROW_MAGGOTS
                            sLast = "13: Dread Blisters";
                            sSelected = "14: Burrow Maggots";
                            sNext = "15: Soldier Shakes";
                            break;
                        case 15: // DISEASE_SOLDIER_SHAKES
                            sLast = "14: Burrow Maggots";
                            sSelected = "15: Soldier Shakes";
                            sNext = "16: Vermin Madness";
                            break;
                        case 16: // DISEASE_VERMIN_MADNESS
                            sLast = "15: Soldier Shakes";
                            sSelected = "16: Vermin Madness";
                            sNext = "0: Blinding Sickness";
                            break;
                    }
                    nPropertyMaxModifier = 16;
                    break;
                case 21: // IP_CONST_ONHIT_SLAYALIGNMENTGROUP           = 22;
                    switch(nPropertyModifier)
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
                    nPropertyMaxModifier = 5;
                    break;
                case 22: // IP_CONST_ONHIT_SLAYALIGNMENT                = 23;
                    switch(nPropertyModifier)
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
                    nPropertyMaxModifier = 8;
                    break;
            }
            break;

//case 49: // ITEM_PROPERTY_DECREASED_SAVING_THROWS
//case 50: // ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC
//case 51: // ITEM_PROPERTY_REGENERATION

        case 52: // ITEM_PROPERTY_SKILL_BONUS
        case 73: // ITEM_PROPERTY_TURN_RESISTANCE
            sLast = IntToString(nPropertyModifier-1)+": Modifier "+IntToString(nPropertyModifier-1);
            sSelected = IntToString(nPropertyModifier)+": Modifier "+IntToString(nPropertyModifier);
            sNext = IntToString(nPropertyModifier+1)+": Modifier "+IntToString(nPropertyModifier+1);

            if(nPropertyModifier == 0)
            {
                sLast = "50: Modifier 50";
                sSelected = "0: none";
            }
            if(nPropertyModifier == 1)
                sLast = "0: none";
            if(nPropertyModifier == 50)
                sNext = "0: none";

            nPropertyMaxModifier = 50;
            break;
case 53: // ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL no subs
case 54: // ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL no subs
//case 55: // ITEM_PROPERTY_THIEVES_TOOLS
//case 56: // ITEM_PROPERTY_ATTACK_BONUS
//case 57: // ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP
//case 58: // ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP
//case 59: // ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT
//case 60: // ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER
case 61: // ITEM_PROPERTY_UNLIMITED_AMMUNITION
            switch(nPropertyModifier)
            {
                case 0:
                    sLast = "15: Enchantment +5";
                    sSelected = "0: none";
                    sNext = "1: basic";
                    break;
                case 1: // IP_CONST_UNLIMITEDAMMO_BASIC
                    sLast = "0: none";
                    sSelected = "1: basic";
                    sNext = "2: Fire 1d6";
                    break;
                case 2: // IP_CONST_UNLIMITEDAMMO_1D6FIRE
                    sLast = "1: basic";
                    sSelected = "2: Fire 1d6";
                    sNext = "3: Cold 1d6";
                    break;
                case 3: // IP_CONST_UNLIMITEDAMMO_1D6COLD
                    sLast = "2: Fire 1d6";
                    sSelected = "3: Cold 1d6";
                    sNext = "4: Lightning 1d6";
                    break;
                case 4: // IP_CONST_UNLIMITEDAMMO_1D6LIGHT
                    sLast = "3: Cold 1d6";
                    sSelected = "4: Lightning 1d6";
                    sNext = "5: next at 11";
                    break;
                case 5:
                    sLast = "4: Lightning 1d6";
                    sSelected = "5: none";
                    sNext = "6: next at 11";
                    break;
                case 6: case 7: case 8: case 9:
                    sLast = IntToString(nPropertyModifier-1)+": last at 4";
                    sSelected = IntToString(nPropertyModifier)+": none";
                    sNext = IntToString(nPropertyModifier+1)+": next at 11";
                    break;
                case 10:
                    sLast = "9: last at 4";
                    sSelected = "10: none";
                    sNext = "11: Enchantment +1";
                    break;
                case 11: // IP_CONST_UNLIMITEDAMMO_PLUS1
                    sLast = "10: last at 4";
                    sSelected = "11: Enchantment +1";
                    sNext = "12: Enchantment +2";
                    break;
                case 12: // IP_CONST_UNLIMITEDAMMO_PLUS2
                    sLast = "11: Enchantment +1";
                    sSelected = "12: Enchantment +2";
                    sNext = "13: Enchantment +3";
                    break;
                case 13: // IP_CONST_UNLIMITEDAMMO_PLUS3
                    sLast = "12: Enchantment +2";
                    sSelected = "13: Enchantment +3";
                    sNext = "14: Enchantment +4";
                    break;
                case 14: // IP_CONST_UNLIMITEDAMMO_PLUS4
                    sLast = "13: Enchantment +3";
                    sSelected = "14: Enchantment +4";
                    sNext = "15: Enchantment +5";
                    break;
                case 15: // IP_CONST_UNLIMITEDAMMO_PLUS5
                    sLast = "14: Enchantment +4";
                    sSelected = "15: Enchantment +5";
                    sNext = "0: none";
                    break;
            }
            nPropertyMaxModifier = 15;
            break;

case 62: // ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP  no subs
case 63: // ITEM_PROPERTY_USE_LIMITATION_CLASS no subs
case 64: // ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE no subs
case 65: // ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT no subs
case 66: // ITEM_PROPERTY_USE_LIMITATION_TILESET not able to get it to work
//case 67: // ITEM_PROPERTY_REGENERATION_VAMPIRIC
case 68: //
case 69: //
case 70: // ITEM_PROPERTY_TRAP
            switch(nPropertyModifier)
            {
                case 0:
                    sLast = "11: Negative";
                    sSelected = "0: none";
                    sNext = "1: Spike";
                    break;
                case 1: // IP_CONST_TRAPTYPE_SPIKE
                    sLast = "0: none";
                    sSelected = "1: Spike";
                    sNext = "2: Holy";
                    break;
                case 2: // IP_CONST_TRAPTYPE_HOLY
                    sLast = "1: Spike";
                    sSelected = "2: Holy";
                    sNext = "3: Tangle";
                    break;
                case 3: // IP_CONST_TRAPTYPE_TANGLE
                    sLast = "2: Holy";
                    sSelected = "3: Tangle";
                    sNext = "4: Blob of Acid";
                    break;
                case 4: // IP_CONST_TRAPTYPE_BLOBOFACID
                    sLast = "3: Tangle";
                    sSelected = "4: Blob of Acid";
                    sNext = "5: Fire";
                    break;
                case 5: // IP_CONST_TRAPTYPE_FIRE
                    sLast = "4: Blob of Acid";
                    sSelected = "5: Fire";
                    sNext = "6: Electrical";
                    break;
                case 6: // IP_CONST_TRAPTYPE_ELECTRICAL
                    sLast = "5: Fire";
                    sSelected = "6: Electrical";
                    sNext = "7: Gas";
                    break;
                case 7: // IP_CONST_TRAPTYPE_GAS
                    sLast = "6: Electrical";
                    sSelected = "7: Gas";
                    sNext = "8: Frost";
                    break;
                case 8: // IP_CONST_TRAPTYPE_FROST
                    sLast = "7: Gas";
                    sSelected = "8: Frost";
                    sNext = "9: Acid Splash";
                    break;
                case 9: // IP_CONST_TRAPTYPE_ACID_SPLASH
                    sLast = "8: Frost";
                    sSelected = "9: Acid Splash";
                    sNext = "10: Sonic";
                    break;
                case 10: // IP_CONST_TRAPTYPE_SONIC
                    sLast = "9: Acid Splash";
                    sSelected = "10: Sonic";
                    sNext = "11: Negative";
                    break;
                case 11: // IP_CONST_TRAPTYPE_NEGATIVE
                    sLast = "10: Sonic";
                    sSelected = "11: Negative";
                    sNext = "0: none";
                    break;
            }
            nPropertyMaxModifier = 11;
            break;


case 71: // ITEM_PROPERTY_TRUE_SEEING  no subs

        case 72: // ITEM_PROPERTY_ON_MONSTER_HIT
            sLast = "no further modifiers";
            sSelected = "no further modifiers";
            sNext = "no further modifiers";
            switch(nSubPropertyNumber)
            {
                case 16: // IP_CONST_ONHIT_LEVELDRAIN                   = 17;
                case 24: // IP_CONST_ONHIT_WOUNDING                     = 25;
                    switch(nPropertyModifier)
                    {
                        case 0:
                            sLast = "5: Modifier 5";
                            sSelected = "0: none";
                            sNext = "1: Modifer 1";
                            break;
                        case 1:
                            sLast = "0: none";
                            sSelected = "1: Modifer 1";
                            sNext = "2: Modifier 2";
                            break;
                        case 2:
                            sLast = "1: Modifer 1";
                            sSelected = "2: Modifier 2";
                            sNext = "3: Modifier 3";
                            break;
                        case 3:
                            sLast = "2: Modifier 2";
                            sSelected = "3: Modifier 3";
                            sNext = "4: Modifier 4";
                            break;
                        case 4:
                            sLast = "3: Modifier 3";
                            sSelected = "4: Modifier 4";
                            sNext = "5: Modifier 5";
                            break;
                        case 5:
                            sLast = "4: Modifier 4";
                            sSelected = "5: Modifier 5";
                            sNext = "0: none";
                            break;
                    }
                    nPropertyMaxModifier = 5;
                    break;
                case 17: // IP_CONST_ONHIT_ABILITYDRAIN                 = 18;
                    switch(nPropertyModifier)
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
                    nPropertyMaxModifier = 5;
                    break;
                case 18: // IP_CONST_ONHIT_ITEMPOISON                   = 19;
                    switch(nPropertyModifier)
                    {
                        case 0: // IP_CONST_POISON_1D2_STRDAMAGE
                            sLast = "5: 1d2 CHA Damage";
                            sSelected = "0: 1d2 STR Damage";
                            sNext = "1: 1d2 DEX Damage";
                            break;
                        case 1: // IP_CONST_POISON_1D2_DEXDAMAGE
                            sLast = "0: 1d2 STR Damage";
                            sSelected = "1: 1d2 DEX Damage";
                            sNext = "2: 1d2 CON Damage";
                            break;
                        case 2: // IP_CONST_POISON_1D2_CONDAMAGE
                            sLast = "1: 1d2 DEX Damage";
                            sSelected = "2: 1d2 CON Damage";
                            sNext = "3: 1d2 INT Damage";
                            break;
                        case 3: // IP_CONST_POISON_1D2_INTDAMAGE
                            sLast = "2: 1d2 CON Damage";
                            sSelected = "3: 1d2 INT Damage";
                            sNext = "4: 1d2 WIS Damage";
                            break;
                        case 4: // IP_CONST_POISON_1D2_WISDAMAGE
                            sLast = "3: 1d2 INT Damage";
                            sSelected = "4: 1d2 WIS Damage";
                            sNext = "5: 1d2 CHA Damage";
                            break;
                        case 5: // IP_CONST_POISON_1D2_CHADAMAGE
                            sLast = "4: 1d2 WIS Damage";
                            sSelected = "5: 1d2 CHA Damage";
                            sNext = "0: 1d2 STR Damage";
                            break;
                    }
                    nPropertyMaxModifier = 5;
                    break;
                case 19: // IP_CONST_ONHIT_DISEASE                      = 20;
                    switch(nPropertyModifier)
                    {
                        case 0: // DISEASE_BLINDING_SICKNESS
                            sLast = "16: Vermin Madness";
                            sSelected = "0: Blinding Sickness";
                            sNext = "1: Cackle Fever";
                            break;
                        case 1: // DISEASE_CACKLE_FEVER
                            sLast = "0: Blinding Sickness";
                            sSelected = "1: Cackle Fever";
                            sNext = "2: Devil Chills";
                            break;
                        case 2: // DISEASE_DEVIL_CHILLS
                            sLast = "1: Cackle Fever";
                            sSelected = "2: Devil Chills";
                            sNext = "3: Demon Fever";
                            break;
                        case 3: // DISEASE_DEMON_FEVER
                            sLast = "2: Devil Chills";
                            sSelected = "3: Demon Fever";
                            sNext = "4: Filth Fever";
                            break;
                        case 4: // DISEASE_FILTH_FEVER
                            sLast = "3: Demon Fever";
                            sSelected = "4: Filth Fever";
                            sNext = "5: Mindfire";
                            break;
                        case 5: // DISEASE_MINDFIRE
                            sLast = "4: Filth Fever";
                            sSelected = "5: Mindfire";
                            sNext = "6: Mummy Rot";
                            break;
                        case 6: // DISEASE_MUMMY_ROT
                            sLast = "5: Mindfire";
                            sSelected = "6: Mummy Rot";
                            sNext = "7: Red Ache";
                            break;
                        case 7: // DISEASE_RED_ACHE
                            sLast = "6: Mummy Rot";
                            sSelected = "7: Red Ache";
                            sNext = "8: Shakes";
                            break;
                        case 8: // DISEASE_SHAKES
                            sLast = "7: Red Ache";
                            sSelected = "8: Shakes";
                            sNext = "9: Slimy Doom";
                            break;
                        case 9: // DISEASE_SLIMY_DOOM
                            sLast = "8: Shakes";
                            sSelected = "9: Slimy Doom";
                            sNext = "10: Red Slaad Eggs";
                            break;
                        case 10: // DISEASE_RED_SLAAD_EGGS
                            sLast = "9: Slimy Doom";
                            sSelected = "10: Red Slaad Eggs";
                            sNext = "11: Ghoul Rot";
                            break;
                        case 11: // DISEASE_GHOUL_ROT
                            sLast = "10: Red Slaad Eggs";
                            sSelected = "11: Ghoul Rot";
                            sNext = "12: Zombie Creep";
                            break;
                        case 12: // DISEASE_ZOMBIE_CREEP
                            sLast = "11: Ghoul Rot";
                            sSelected = "12: Zombie Creep";
                            sNext = "13: Dread Blisters";
                            break;
                        case 13: // DISEASE_DREAD_BLISTERS
                            sLast = "12: Zombie Creep";
                            sSelected = "13: Dread Blisters";
                            sNext = "14: Burrow Maggots";
                            break;
                        case 14: // DISEASE_BURROW_MAGGOTS
                            sLast = "13: Dread Blisters";
                            sSelected = "14: Burrow Maggots";
                            sNext = "15: Soldier Shakes";
                            break;
                        case 15: // DISEASE_SOLDIER_SHAKES
                            sLast = "14: Burrow Maggots";
                            sSelected = "15: Soldier Shakes";
                            sNext = "16: Vermin Madness";
                            break;
                        case 16: // DISEASE_VERMIN_MADNESS
                            sLast = "15: Soldier Shakes";
                            sSelected = "16: Vermin Madness";
                            sNext = "0: Blinding Sickness";
                            break;
                    }
                    nPropertyMaxModifier = 16;
                    break;
            }
            break;
//case 73: // ITEM_PROPERTY_TURN_RESISTANCE
//case 74: // ITEM_PROPERTY_MASSIVE_CRITICALS
case 75: // ITEM_PROPERTY_FREEDOM_OF_MOVEMENT  not able to get this one to work

// no longer working, poison is now a on_hit subtype
case 76: // ITEM_PROPERTY_POISON

case 77: // ITEM_PROPERTY_MONSTER_DAMAGE
            switch(nPropertyModifier)
            {
                case 0:
                    sLast = "57: Monster damage 10d20";
                    sSelected = "0: none";
                    sNext = "1: Monster damage 1d2";
                    break;
                case 1: // IP_CONST_MONSTERDAMAGE_1d2
                    sLast = "0: none";
                    sSelected = "1: Monster damage 1d2";
                    sNext = "2: Monster damage 1d3";
                    break;
                case 2: // IP_CONST_MONSTERDAMAGE_1d3
                    sLast = "1: Monster damage 1d2";
                    sSelected = "2: Monster damage 1d3";
                    sNext = "3: Monster damage 1d4";
                    break;
                case 3: // IP_CONST_MONSTERDAMAGE_1d4
                    sLast = "2: Monster damage 1d3";
                    sSelected = "3: Monster damage 1d4";
                    sNext = "4: Monster damage 2d4";
                    break;
                case 4: // IP_CONST_MONSTERDAMAGE_2d4
                    sLast = "3: Monster damage 1d4";
                    sSelected = "4: Monster damage 2d4";
                    sNext = "5: Monster damage 3d4";
                    break;
                case 5: // IP_CONST_MONSTERDAMAGE_3d4
                    sLast = "4: Monster damage 2d4";
                    sSelected = "5: Monster damage 3d4";
                    sNext = "6: Monster damage 4d4";
                    break;
                case 6: // IP_CONST_MONSTERDAMAGE_4d4
                    sLast = "5: Monster damage 3d4";
                    sSelected = "6: Monster damage 4d4";
                    sNext = "7: Monster damage 5d4";
                    break;
                case 7: // IP_CONST_MONSTERDAMAGE_5d4
                    sLast = "6: Monster damage 4d4";
                    sSelected = "7: Monster damage 5d4";
                    sNext = "8: Monster damage 1d6";
                    break;
                case 8: // IP_CONST_MONSTERDAMAGE_1d6
                    sLast = "7: Monster damage 5d4";
                    sSelected = "8: Monster damage 1d6";
                    sNext = "9: Monster damage 2d6";
                    break;
                case 9: // IP_CONST_MONSTERDAMAGE_2d6
                    sLast = "8: Monster damage 1d6";
                    sSelected = "9: Monster damage 2d6";
                    sNext = "10: Monster damage 3d6";
                    break;
                case 10: // IP_CONST_MONSTERDAMAGE_3d6
                    sLast = "9: Monster damage 2d6";
                    sSelected = "10: Monster damage 3d6";
                    sNext = "11: Monster damage 4d6";
                    break;
                case 11: // IP_CONST_MONSTERDAMAGE_4d6
                    sLast = "10: Monster damage 3d6";
                    sSelected = "11: Monster damage 4d6";
                    sNext = "12: Monster damage 5d6";
                    break;
                case 12: // IP_CONST_MONSTERDAMAGE_5d6
                    sLast = "11: Monster damage 4d6";
                    sSelected = "12: Monster damage 5d6";
                    sNext = "13: Monster damage 6d6";
                    break;
                case 13: // IP_CONST_MONSTERDAMAGE_6d6
                    sLast = "12: Monster damage 5d6";
                    sSelected = "13: Monster damage 6d6";
                    sNext = "14: Monster damage 7d6";
                    break;
                case 14: // IP_CONST_MONSTERDAMAGE_7d6
                    sLast = "13: Monster damage 6d6";
                    sSelected = "14: Monster damage 7d6";
                    sNext = "15: Monster damage 8d6";
                    break;
                case 15: // IP_CONST_MONSTERDAMAGE_8d6
                    sLast = "14: Monster damage 7d6";
                    sSelected = "15: Monster damage 8d6";
                    sNext = "16: Monster damage 9d6";
                    break;
                case 16: // IP_CONST_MONSTERDAMAGE_9d6
                    sLast = "15: Monster damage 8d6";
                    sSelected = "16: Monster damage 9d6";
                    sNext = "17: Monster damage 10d6";
                    break;
                case 17: // IP_CONST_MONSTERDAMAGE_10d6
                    sLast = "16: Monster damage 9d6";
                    sSelected = "17: Monster damage 10d6";
                    sNext = "18: Monster damage 1d8";
                    break;
                case 18: // IP_CONST_MONSTERDAMAGE_1d8
                    sLast = "17: Monster damage 10d6";
                    sSelected = "18: Monster damage 1d8";
                    sNext = "19: Monster damage 2d8";
                    break;
                case 19: // IP_CONST_MONSTERDAMAGE_2d8
                    sLast = "18: Monster damage 1d8";
                    sSelected = "19: Monster damage 2d8";
                    sNext = "20: Monster damage 3d8";
                    break;
                case 20: // IP_CONST_MONSTERDAMAGE_3d8
                    sLast = "19: Monster damage 2d8";
                    sSelected = "20: Monster damage 3d8";
                    sNext = "21: Monster damage 4d8";
                    break;
                case 21: // IP_CONST_MONSTERDAMAGE_4d8
                    sLast = "20: Monster damage 3d8";
                    sSelected = "21: Monster damage 4d8";
                    sNext = "22: Monster damage 5d8";
                    break;
                case 22: // IP_CONST_MONSTERDAMAGE_5d8
                    sLast = "21: Monster damage 4d8";
                    sSelected = "22: Monster damage 5d8";
                    sNext = "23: Monster damage 6d8";
                    break;
                case 23: // IP_CONST_MONSTERDAMAGE_6d8
                    sLast = "22: Monster damage 5d8";
                    sSelected = "23: Monster damage 6d8";
                    sNext = "24: Monster damage 7d8";
                    break;
                case 24: // IP_CONST_MONSTERDAMAGE_7d8
                    sLast = "23: Monster damage 6d8";
                    sSelected = "24: Monster damage 7d8";
                    sNext = "25: Monster damage 8d8";
                    break;
                case 25: // IP_CONST_MONSTERDAMAGE_8d8
                    sLast = "24: Monster damage 7d8";
                    sSelected = "25: Monster damage 8d8";
                    sNext = "26: Monster damage 9d8";
                    break;
                case 26: // IP_CONST_MONSTERDAMAGE_9d8
                    sLast = "25: Monster damage 8d8";
                    sSelected = "26: Monster damage 9d8";
                    sNext = "27: Monster damage 10d8";
                    break;
                case 27: // IP_CONST_MONSTERDAMAGE_10d8
                    sLast = "26: Monster damage 9d8";
                    sSelected = "27: Monster damage 10d8";
                    sNext = "28: Monster damage 1d10";
                    break;
                case 28: // IP_CONST_MONSTERDAMAGE_1d10
                    sLast = "27: Monster damage 10d8";
                    sSelected = "28: Monster damage 1d10";
                    sNext = "29: Monster damage 2d10";
                    break;
                case 29: // IP_CONST_MONSTERDAMAGE_2d10
                    sLast = "28: Monster damage 1d10";
                    sSelected = "29: Monster damage 2d10";
                    sNext = "30: Monster damage 3d10";
                    break;
                case 30: // IP_CONST_MONSTERDAMAGE_3d10
                    sLast = "29: Monster damage 2d10";
                    sSelected = "30: Monster damage 3d10";
                    sNext = "31: Monster damage 4d10";
                    break;
                case 31: // IP_CONST_MONSTERDAMAGE_4d10
                    sLast = "30: Monster damage 3d10";
                    sSelected = "31: Monster damage 4d10";
                    sNext = "32: Monster damage 5d10";
                    break;
                case 32: // IP_CONST_MONSTERDAMAGE_5d10
                    sLast = "31: Monster damage 4d10";
                    sSelected = "32: Monster damage 5d10";
                    sNext = "33: Monster damage 6d10";
                    break;
                case 33: // IP_CONST_MONSTERDAMAGE_6d10
                    sLast = "32: Monster damage 5d10";
                    sSelected = "33: Monster damage 6d10";
                    sNext = "34: Monster damage 7d10";
                    break;
                case 34: // IP_CONST_MONSTERDAMAGE_7d10
                    sLast = "33: Monster damage 6d10";
                    sSelected = "34: Monster damage 7d10";
                    sNext = "35: Monster damage 8d10";
                    break;
                case 35: // IP_CONST_MONSTERDAMAGE_8d10
                    sLast = "34: Monster damage 7d10";
                    sSelected = "35: Monster damage 8d10";
                    sNext = "36: Monster damage 9d10";
                    break;
                case 36: // IP_CONST_MONSTERDAMAGE_9d10
                    sLast = "35: Monster damage 8d10";
                    sSelected = "36: Monster damage 9d10";
                    sNext = "37: Monster damage 10d10";
                    break;
                case 37: // IP_CONST_MONSTERDAMAGE_10d10
                    sLast = "36: Monster damage 9d10";
                    sSelected = "37: Monster damage 10d10";
                    sNext = "38: Monster damage 1d12";
                    break;
                case 38: // IP_CONST_MONSTERDAMAGE_1d12
                    sLast = "37: Monster damage 10d10";
                    sSelected = "38: Monster damage 1d12";
                    sNext = "39: Monster damage 2d12";
                    break;
                case 39: // IP_CONST_MONSTERDAMAGE_2d12
                    sLast = "38: Monster damage 1d12";
                    sSelected = "39: Monster damage 2d12";
                    sNext = "40: Monster damage 3d12";
                    break;
                case 40: // IP_CONST_MONSTERDAMAGE_3d12
                    sLast = "39: Monster damage 2d12";
                    sSelected = "40: Monster damage 3d12";
                    sNext = "41: Monster damage 4d12";
                    break;
                case 41: // IP_CONST_MONSTERDAMAGE_4d12
                    sLast = "40: Monster damage 3d12";
                    sSelected = "41: Monster damage 4d12";
                    sNext = "42: Monster damage 5d12";
                    break;
                case 42: // IP_CONST_MONSTERDAMAGE_5d12
                    sLast = "41: Monster damage 4d12";
                    sSelected = "42: Monster damage 5d12";
                    sNext = "43: Monster damage 6d12";
                    break;
                case 43: // IP_CONST_MONSTERDAMAGE_6d12
                    sLast = "42: Monster damage 5d12";
                    sSelected = "43: Monster damage 6d12";
                    sNext = "44: Monster damage 7d12";
                    break;
                case 44: // IP_CONST_MONSTERDAMAGE_7d12
                    sLast = "43: Monster damage 6d12";
                    sSelected = "44: Monster damage 7d12";
                    sNext = "45: Monster damage 8d12";
                    break;
                case 45: // IP_CONST_MONSTERDAMAGE_8d12
                    sLast = "44: Monster damage 7d12";
                    sSelected = "45: Monster damage 8d12";
                    sNext = "46: Monster damage 9d12";
                    break;
                case 46: // IP_CONST_MONSTERDAMAGE_9d12
                    sLast = "45: Monster damage 8d12";
                    sSelected = "46: Monster damage 9d12";
                    sNext = "47: Monster damage 10d12";
                    break;
                case 47: // IP_CONST_MONSTERDAMAGE_10d12
                    sLast = "46: Monster damage 9d12";
                    sSelected = "47: Monster damage 10d12";
                    sNext = "48: Monster damage 1d20";
                    break;
                case 48: // IP_CONST_MONSTERDAMAGE_1d20
                    sLast = "47: Monster damage 10d12";
                    sSelected = "48: Monster damage 1d20";
                    sNext = "49: Monster damage 2d20";
                    break;
                case 49: // IP_CONST_MONSTERDAMAGE_2d20
                    sLast = "48: Monster damage 1d20";
                    sSelected = "49: Monster damage 2d20";
                    sNext = "50: Monster damage 3d20";
                    break;
                case 50: // IP_CONST_MONSTERDAMAGE_3d20
                    sLast = "49: Monster damage 2d20";
                    sSelected = "50: Monster damage 3d20";
                    sNext = "51: Monster damage 4d20";
                    break;
                case 51: // IP_CONST_MONSTERDAMAGE_4d20
                    sLast = "50: Monster damage 3d20";
                    sSelected = "51: Monster damage 4d20";
                    sNext = "52: Monster damage 5d20";
                    break;
                case 52: // IP_CONST_MONSTERDAMAGE_5d20
                    sLast = "51: Monster damage 4d20";
                    sSelected = "52: Monster damage 5d20";
                    sNext = "53: Monster damage 6d20";
                    break;
                case 53: // IP_CONST_MONSTERDAMAGE_6d20
                    sLast = "52: Monster damage 5d20";
                    sSelected = "53: Monster damage 6d20";
                    sNext = "54: Monster damage 7d20";
                    break;
                case 54: // IP_CONST_MONSTERDAMAGE_7d20
                    sLast = "53: Monster damage 6d20";
                    sSelected = "54: Monster damage 7d20";
                    sNext = "55: Monster damage 8d20";
                    break;
                case 55: // IP_CONST_MONSTERDAMAGE_8d20
                    sLast = "54: Monster damage 7d20";
                    sSelected = "55: Monster damage 8d20";
                    sNext = "56: Monster damage 9d20";
                    break;
                case 56: // IP_CONST_MONSTERDAMAGE_9d20
                    sLast = "55: Monster damage 8d20";
                    sSelected = "56: Monster damage 9d20";
                    sNext = "57: Monster damage 10d20";
                    break;
                case 57: // IP_CONST_MONSTERDAMAGE_10d20
                    sLast = "56: Monster damage 9d20";
                    sSelected = "57: Monster damage 10d20";
                    sNext = "0: none";
                    break;
            }
            nPropertyMaxModifier = 57;
            break;

        case 78: // ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL
        case 82: // ITEM_PROPERTY_ONHITCASTSPELL
            switch(nPropertyModifier)
            {
                case 0:
                    sLast = "9: Level 9";
                    sSelected = "0: none";
                    sNext = "1: Level 1";
                    break;
                case 1:
                    sLast = "0: none";
                    sSelected = "1: Level 1";
                    sNext = "2: Level 2";
                    break;
                case 2:
                    sLast = "1: Level 1";
                    sSelected = "2: Level 2";
                    sNext = "3: Level 3";
                    break;
                case 3:
                    sLast = "2: Level 2";
                    sSelected = "3: Level 3";
                    sNext = "4: Level 4";
                    break;
                case 4:
                    sLast = "3: Level 3";
                    sSelected = "4: Level 4";
                    sNext = "5: Level 5";
                    break;
                case 5:
                    sLast = "4: Level 4";
                    sSelected = "5: Level 5";
                    sNext = "6: Level 6";
                    break;
                case 6:
                    sLast = "5: Level 5";
                    sSelected = "6: Level 6";
                    sNext = "7: Level 7";
                    break;
                case 7:
                    sLast = "6: Level 6";
                    sSelected = "7: Level 7";
                    sNext = "8: Level 8";
                    break;
                case 8:
                    sLast = "7: Level 7";
                    sSelected = "8: Level 8";
                    sNext = "9: Level 9";
                    break;
                case 9:
                    sLast = "8: Level 8";
                    sSelected = "9: Level 9";
                    sNext = "0: none";
                    break;
            }
            nPropertyMaxModifier = 9;
            break;
case 79: // ITEM_PROPERTY_SPECIAL_WALK
//case 80: // ITEM_PROPERTY_HEALERS_KIT
        case 81: // ITEM_PROPERTY_WEIGHT_INCREASE
            switch(nPropertyModifier)
            {
                case 0: // IP_CONST_WEIGHTINCREASE_5_LBS
                    sLast = "5: 100 lbs.";
                    sSelected = "0: 5 lbs.";
                    sNext = "1: 10 lbs.";
                    break;
                case 1: // IP_CONST_WEIGHTINCREASE_10_LBS
                    sLast = "0: 5 lbs.";
                    sSelected = "1: 10 lbs.";
                    sNext = "2: 15 lbs.";
                    break;
                case 2: // IP_CONST_WEIGHTINCREASE_15_LBS
                    sLast = "1: 10 lbs.";
                    sSelected = "2: 15 lbs.";
                    sNext = "3: 30 lbs.";
                    break;
                case 3: // IP_CONST_WEIGHTINCREASE_30_LBS
                    sLast = "2: 15 lbs.";
                    sSelected = "3: 30 lbs.";
                    sNext = "4: 50 lbs.";
                    break;
                case 4: // IP_CONST_WEIGHTINCREASE_50_LBS
                    sLast = "3: 30 lbs.";
                    sSelected = "4: 50 lbs.";
                    sNext = "5: 100 lbs.";
                    break;
                case 5: // IP_CONST_WEIGHTINCREASE_100_LBS
                    sLast = "4: 50 lbs.";
                    sSelected = "5: 100 lbs.";
                    sNext = "0: 5 lbs.";
                    break;
            }
            nPropertyMaxModifier = 5;
            break;
//case 82: // ITEM_PROPERTY_ONHITCASTSPELL
case 83: // ITEM_PROPERTY_VISUALEFFECT
            switch(nPropertyModifier)
            {
                case 0: // ITEM_VISUAL_ACID
                    sLast = "6: Evil";
                    sSelected = "0: Acid";
                    sNext = "1: Cold";
                    break;
                case 1: // ITEM_VISUAL_COLD
                    sLast = "0: Acid";
                    sSelected = "1: Cold";
                    sNext = "2: Electrical";
                    break;
                case 2: // ITEM_VISUAL_ELECTRICAL
                    sLast = "1: Cold";
                    sSelected = "2: Electrical";
                    sNext = "3: Fire";
                    break;
                case 3: // ITEM_VISUAL_FIRE
                    sLast = "2: Electrical";
                    sSelected = "3: Fire";
                    sNext = "4: Sonic";
                    break;
                case 4: // ITEM_VISUAL_SONIC
                    sLast = "3: Fire";
                    sSelected = "4: Sonic";
                    sNext = "5: Holy";
                    break;
                case 5: // ITEM_VISUAL_HOLY
                    sLast = "4: Sonic";
                    sSelected = "5: Holy";
                    sNext = "6: Evil";
                    break;
                case 6: // ITEM_VISUAL_EVIL
                    sLast = "5: Holy";
                    sSelected = "6: Evil";
                    sNext = "0: Acid";
                    break;
            }
            nPropertyMaxModifier = 6;
            break;
        case 84: // ITEM_PROPERTY_ARCANE_SPELL_FAILURE
            sLast = IntToString(nPropertyModifier-1)+": unable to figure out the integer";
            sSelected = IntToString(nPropertyModifier)+": unable to figure out the integer";
            sNext = IntToString(nPropertyModifier+1)+": unable to figure out the integer";
            nPropertyMaxModifier = 20;
            break;

    }

    SetLocalInt(oPC, "ITEM_PROPERTY_MODIFIER_MAX", nPropertyMaxModifier);
    SetLocalString(oPC, "ITEM_PROPERTY_MODIFIER_NAME", sSelected);

    SetCustomToken(70001, sLast);
    SetCustomToken(70002, sSelected);
    SetCustomToken(70003, sNext);
    SetCustomToken(70004, sNumber);
    SetCustomToken(70005, sItemProperty);
    SetCustomToken(70006, sSubPropertyName);
    SetCustomToken(70007, sSubSubProperty);

    return nResult;
}
