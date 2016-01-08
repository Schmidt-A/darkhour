//::///////////////////////////////////////////////
//::
//:: DM_Itm_GetProprt
//::
//:: dm_itm_getproprt.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This is the first script in setting an item
//:: property. It gives the approperiate custom
//:: tokens to the conversation
//::
//:: <CUSTOM50001> The Last Item property
//:: <CUSTOM50002> The current Item property
//:: <CUSTOM50003> The next item property
//:: <CUSTOM50004> The item property number
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Nordavind
//::         On: June 4, 2004
//::
//:://////////////////////////////////////////////
#include "authorization"


int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nNumber = GetLocalInt(oPC, "ITEM_PROPERTY_SELECTED");
    int nResult = TRUE;

// uncomment the two lines below to restrict item property manipulation.
// Also see the script "dm_itm_rem_start" and "authorization" as you'll
// need to modify them to.
//    if(GetIsAdmin(oPC) != TRUE)
//        return FALSE;

    string sLast;
    string sSelected;
    string sNext;
    string sNumber = IntToString(nNumber);

    switch(nNumber)
    {
        case 0:
            sLast = "84: Arcane Spell Failure";
            sSelected = "0: Ability Bonus";
            sNext = "1: AC Bonus";
            break;
        case 1:
            sLast = "0: Ability Bonus";
            sSelected = "1: AC Bonus";
            sNext = "2: AC Bonus vs Alignment Group";
            break;
        case 2:
            sLast = "1: AC Bonus";
            sSelected = "2: AC Bonus vs Alignment Group";
            sNext = "3: AC Bonus vs Damage Type";
            break;
        case 3:
            sLast = "2: AC Bonus vs Alignment Group";
            sSelected = "3: AC Bonus vs Damage Type";
            sNext = "4: AC Bonus vs Racial Group";
            break;
        case 4:
            sLast = "3: AC Bonus vs Damage Type";
            sSelected = "4: AC Bonus vs Racial Group";
            sNext = "5: AC Bonus vs Specific Alignment";
            break;
        case 5:
            sLast = "4: AC Bonus vs Racial Group";
            sSelected = "5: AC Bonus vs Specific Alignment";
            sNext = "6: Enchantment Bonus";
            break;
        case 6:
            sLast = "5: AC Bonus vs Specific Alignment";
            sSelected = "6: Enchantment Bonus";
            sNext = "7: Enchantment Bonus vs Alignment Group";
            break;
        case 7:
            sLast = "6: Enchantment Bonus";
            sSelected = "7: Enchantment Bonus vs Alignment Group";
            sNext = "8: Enchantment Bonus vs Racial Group";
            break;
        case 8:
            sLast = "7: Enchantment Bonus vs Alignment Group";
            sSelected = "8: Enchantment Bonus vs Racial Group";
            sNext = "9: Enchantment Bonus vs Specific Alignment";
            break;
        case 9:
            sLast = "8: Enchantment Bonus vs Racial Group";
            sSelected = "9: Enchantment Bonus vs Specific Alignment";
            sNext = "10: Decrease Enchantment Modifier";
            break;
        case 10:
            sLast = "9: Enchantment Bonus vs Specific Alignment";
            sSelected = "10: Decrease Enchantment Modifier";
            sNext = "11: Base Item Weight Reduction";
            break;
        case 11:
            sLast = "10: Decrease Enchantment Modifier";
            sSelected = "11: Base Item Weight Reduction";
            sNext = "12: Bonus Feat";
            break;
        case 12:
            sLast = "11: Base Item Weight Reduction";
            sSelected = "12: Bonus Feat";
            sNext = "13: Bonus Spell Slot of Level N";
            break;
        case 13:
            sLast = "12: Bonus Feat";
            sSelected = "13: Bonus Spell Slot of Level N";
            sNext = "14 :: not valid ::";
            break;
        case 14:
            sLast = "13: Bonus Spell Slot of Level N";
            sSelected = "14 :: not valid ::";
            sNext = "15: Cast Spell";
            break;
        case 15:
            sLast = "14 :: not valid ::";
            sSelected = "15: Cast Spell";
            sNext = "16: Damage Bonus";
            break;
        case 16:
            sLast = "15: Cast Spell";
            sSelected = "16: Damage Bonus";
            sNext = "17: Damage Bonus vs Alignment Group";
            break;
        case 17:
            sLast = "16: Damage Bonus";
            sSelected = "17: Damage Bonus vs Alignment Group";
            sNext = "18: Damage Bonus vs Racial Group";
            break;
        case 18:
            sLast = "17: Damage Bonus vs Alignment Group";
            sSelected = "18: Damage Bonus vs Racial Group";
            sNext = "19: Damage Bonus vs Specific Alignment";
            break;
        case 19:
            sLast = "18: Damage Bonus vs Racial Group";
            sSelected = "19: Damage Bonus vs Specific Alignment";
            sNext = "20: Immunity vs Damage Type";
            break;
        case 20:
            sLast = "19: Damage Bonus vs Specific Alignment";
            sSelected = "20: Immunity vs Damage Type";
            sNext = "21: Decrease Damage";
            break;
        case 21:
            sLast = "20: Immunity vs Damage Type";
            sSelected = "21: Decrease Damage";
            sNext = "22: Damage Reduction";
            break;
        case 22:
            sLast = "21: Decrease Damage";
            sSelected = "22: Damage Reduction";
            sNext = "23: Damage Resistance";
            break;
        case 23:
            sLast = "22: Damage Reduction";
            sSelected = "23: Damage Resistance";
            sNext = "24: Damage Vulnerability";
            break;
        case 24:
            sLast = "23: Damage Resistance";
            sSelected = "24: Damage Vulnerability";
            sNext = "25 :: not valid ::";
            break;
        case 25:
            sLast = "24: Damage Vulnerability";
            sSelected = "25 :: not valid ::";
            sNext = "26: Darkvision";
            break;
        case 26:
            sLast = "25 :: not valid ::";
            sSelected = "26: Darkvision";
            sNext = "27: Decrease Ability Score";
            break;
        case 27:
            sLast = "26: Darkvision";
            sSelected = "27: Decrease Ability Score";
            sNext = "28: Decrease AC";
            break;
        case 28:
            sLast = "27: Decrease Ability Score";
            sSelected = "28: Decrease AC";
            sNext = "29: Decrease Skill Modifier";
            break;
        case 29:
            sLast = "28: Decrease AC";
            sSelected = "29: Decrease Skill Modifier";
            sNext = "30 :: not valid ::";
            break;
        case 30:
            sLast = "29: Decrease Skill Modifier";
            sSelected = "30 :: not valid ::";
            sNext = "31 :: not valid ::";
            break;
        case 31:
            sLast = "30 :: not valid ::";
            sSelected = "31 :: not valid ::";
            sNext = "32: Enhanced Container Reduced Weigth";
            break;
        case 32:
            sLast = "31 :: not valid ::";
            sSelected = "32: Enhanced Container Reduced Weigth";
            sNext = "33: Extra Melee Damage Type";
            break;
        case 33:
            sLast = "32: Enhanced Container Reduced Weigth";
            sSelected = "33: Extra Melee Damage Type";
            sNext = "34: Extra Ranged Damage Type";
            break;
        case 34:
            sLast = "33: Extra Melee Damage Type";
            sSelected = "34: Extra Ranged Damage Type";
            sNext = "35: Haste";
            break;
        case 35:
            sLast = "34: Extra Ranged Damage Type";
            sSelected = "35: Haste";
            sNext = "36: Holy Avenger";
            break;
        case 36:
            sLast = "35: Haste";
            sSelected = "36: Holy Avenger";
            sNext = "37: Immunity Micellaneous";
            break;
        case 37:
            sLast = "36: Holy Avenger";
            sSelected = "37: Immunity Micellaneous";
            sNext = "38: Improved Evasion";
            break;
        case 38:
            sLast = "37: Immunity Micellaneous";
            sSelected = "38: Improved Evasion";
            sNext = "39: Spell Resistance";
            break;
        case 39:
            sLast = "38: Improved Evasion";
            sSelected = "39: Spell Resistance";
            sNext = "40: Saving Throw Bonus";
            break;
        case 40:
            sLast = "39: Spell Resistance";
            sSelected = "40: Saving Throw Bonus";
            sNext = "41: Saving Throw Bonus Specific";
            break;
        case 41:
            sLast = "40: Saving Throw Bonus";
            sSelected = "41: Saving Throw Bonus Specific";
            sNext = "42 :: not valid ::";
            break;
        case 42:
            sLast = "41: Saving Throw Bonus Specific";
            sSelected = "42 :: not valid ::";
            sNext = "43: Keen";
            break;
        case 43:
            sLast = "42 :: not valid ::";
            sSelected = "43: Keen";
            sNext = "44: Light";
            break;
        case 44:
            sLast = "43: Keen";
            sSelected = "44: Light";
            sNext = "45: Mighty";
            break;
        case 45:
            sLast = "44: Light";
            sSelected = "45: Mighty";
            sNext = "46: Mind Blank";
            break;
        case 46:
            sLast = "45: Mighty";
            sSelected = "46: Mind Blank";
            sNext = "47: No Damage";
            break;
        case 47:
            sLast = "46: Mind Blank";
            sSelected = "47: No Damage";
            sNext = "48: On Hit Properties";
            break;
        case 48:
            sLast = "47: No Damage";
            sSelected = "48: On Hit Properties";
            sNext = "49: Decrease Saving Throws";
            break;
        case 49:
            sLast = "48: On Hit Properties";
            sSelected = "49: Decrease Saving Throws";
            sNext = "50: Decrease Saving Throws Specific";
            break;
        case 50:
            sLast = "49: Decrease Saving Throws";
            sSelected = "50: Decrease Saving Throws Specific";
            sNext = "51: Regeneration";
            break;
        case 51:
            sLast = "50: Decrease Saving Throws Specific";
            sSelected = "51: Regeneration";
            sNext = "52: Skill Bonus";
            break;
        case 52:
            sLast = "51: Regeneration";
            sSelected = "52: Skill Bonus";
            sNext = "53: Immunity Specific Spell";
            break;
        case 53:
            sLast = "52: Skill Bonus";
            sSelected = "53: Immunity Specific Spell";
            sNext = "54: Immunity Specific School";
            break;
        case 54:
            sLast = "53: Immunity Specific Spell";
            sSelected = "54: Immunity Specific School";
            sNext = "55: Thieves Tools";
            break;
        case 55:
            sLast = "54: Immunity Specific School";
            sSelected = "55: Thieves Tools";
            sNext = "56: Attack Bonus";
            break;
        case 56:
            sLast = "55: Thieves Tools";
            sSelected = "56: Attack Bonus";
            sNext = "57: Attack Bonus vs Alignment Group";
            break;
        case 57:
            sLast = "56:Attack Bonus";
            sSelected = "57: Attack Bonus vs Alignment Group";
            sNext = "58: Attack Bonus vs Racial Group";
            break;
        case 58:
            sLast = "57: Attack Bonus vs Alignment Group";
            sSelected = "58: Attack Bonus vs Racial Group";
            sNext = "59: Attack Bonus vs Specific Alignment";
            break;
        case 59:
            sLast = "58: Attack Bonus vs Racial Group";
            sSelected = "59: Attack Bonus vs Specific Alignment";
            sNext = "60: Decrease Attack Modifier";
            break;
        case 60:
            sLast = "59: Attack Bonus vs Specific Alignment";
            sSelected = "60: Decrease Attack Modifier";
            sNext = "61: Unlimited Ammo";
            break;
        case 61:
            sLast = "60: Decrease Attack Modifier";
            sSelected = "61: Unlimited Ammo";
            sNext = "62: Use Limitation: Alignment Group";
            break;
        case 62:
            sLast = "61: Unlimited Ammo";
            sSelected = "62: Use Limitation: Alignment Group";
            sNext = "63: Use Limitation: Class";
            break;
        case 63:
            sLast = "62: Use Limitation: Alignment Group";
            sSelected = "63: Use Limitation: Class";
            sNext = "64: Use Limitation: Racial Type";
            break;
        case 64:
            sLast = "63: Use Limitation: Class";
            sSelected = "64: Use Limitation: Racial Type";
            sNext = "65: Use Limitation: Specific Alignment";
            break;
        case 65:
            sLast = "64: Use Limitation: Racial Type";
            sSelected = "65: Use Limitation: Specific Alignment";
            sNext = "66: Use Limitation: Tileset";
            break;
        case 66:
            sLast = "65: Use Limitation: Specific Alignment";
            sSelected = "66: Use Limitation: Tileset";
            sNext = "67: Regeneration Vampyric";
            break;
        case 67:
            sLast = "66: Use Limitation: Tileset";
            sSelected = "67: Regeneration Vampyric";
            sNext = "68 :: not valid ::";
            break;
        case 68:
            sLast = "67: Regeneration Vampyric";
            sSelected = "68 :: not valid ::";
            sNext = "69 :: not valid ::";
            break;
        case 69:
            sLast = "68 :: not valid ::";
            sSelected = "69 :: not valid ::";
            sNext = "70: Trap";
            break;
        case 70:
            sLast = "69 :: not valid ::";
            sSelected = "70: Trap";
            sNext = "71: True Seeing";
            break;
        case 71:
            sLast = "70: Trap";
            sSelected = "71: True Seeing";
            sNext = "72: On Monster Hit";
            break;
        case 72:
            sLast = "71: True Seeing";
            sSelected = "72: On Monster Hit";
            sNext = "73: Turn Ressistance";
            break;
        case 73:
            sLast = "72: On Monster Hit";
            sSelected = "73: Turn Ressistance";
            sNext = "74: Massive Criticals";
            break;
        case 74:
            sLast = "73: Turn Ressistance";
            sSelected = "74: Massive Criticals";
            sNext = "75: Freedom of Movement";
            break;
        case 75:
            sLast = "74: Massive Criticals";
            sSelected = "75: Freedom of Movement";
            sNext = "76 :: not valid ::";
            break;
        case 76:
            sLast = "75: Freedom of Movement";
            sSelected = "76 :: not valid ::";
            sNext = "77: Monster Damage";
            break;
        case 77:
            sLast = "76 :: not valid ::";
            sSelected = "77: Monster Damage";
            sNext = "78: Immunity Against Spells by Level";
            break;
        case 78:
            sLast = "77: Monster Damage";
            sSelected = "78: Immunity Against Spells by Level";
            sNext = "79: Special Walk";
            break;
        case 79:
            sLast = "78: Immunity Against Spells by Level";
            sSelected = "79: Special Walk";
            sNext = "80: Healers Kit";
            break;
        case 80:
            sLast = "79: Special Walk";
            sSelected = "80: Healers Kit";
            sNext = "81: Weight Increase";
            break;
        case 81:
            sLast = "80: Healers Kit";
            sSelected = "81: Weight Increase";
            sNext = "82: On Hit Cast Spell";
            break;
        case 82:
            sLast = "81: Weight Increase";
            sSelected = "82: On Hit Cast Spell";
            sNext = "83: Visual Effect";
            break;
        case 83:
            sLast = "82: On Hit Cast Spell";
            sSelected = "83: Visual Effect";
            sNext = "84: Arcane Spell Failure";
            break;
        case 84:
            sLast = "83: Visual Effect";
            sSelected = "84: Arcane Spell Failure";
            sNext = "0: Ability Bonus";
            break;
    }

    SetLocalString(oPC, "ITEM_PROPERTY_NAME", sSelected);

    SetCustomToken(50001, sLast);
    SetCustomToken(50002, sSelected);
    SetCustomToken(50003, sNext);
    SetCustomToken(50004, sNumber);
    return nResult;
}
