//::///////////////////////////////////////////////
//::
//:: DM_Itm_GetSubSub
//::
//:: dm_itm_subsub.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is the forth script in setting
//:: the item property. It will return some custom
//:: conversation tokens.
//::
//:: <CUSTOM70001> The least sub-sub property
//:: <CUSTOM70002> The current sub-sub property
//:: <CUSTOM70003> The next sub-sub property
//:: <CUSTOM70004> The sub-sub property number
//:: <CUSTOM70005> The name of the item property
//:: <CUSTOM70006> The name of the Sub Property
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
    int nPropertyMaxModifier;

    int nSubSubProperty = GetLocalInt(oPC, "ITEM_SUB_SUB_PROPERTY");
    int nPropertyNumber = GetLocalInt(oPC, "ITEM_PROPERTY_SELECTED");
    int nSubSubPropertyNumber = GetLocalInt(oPC, "ITEM_SUB_SUB_PROPERTY_SELECTED");

    string sItemProperty = GetLocalString(oPC, "ITEM_PROPERTY_NAME");
    string sSubPropertyName = GetLocalString(oPC, "ITEM_SUB_PROPERTY_NAME");
    string sSubSubProperty = GetLocalString(oPC, "ITEM_SUB_SUB_PROPERTY_NAME");

    string sNumber = IntToString(nSubSubPropertyNumber);
    string sLast = "no sub-sub property";
    string sSelected = "no sub-sub property";
    string sNext = "no sub-sub property";

    // if the item property doesn't have a sub-sub property, abort
    if(nSubSubProperty != TRUE)
        return FALSE;


    switch(nPropertyNumber)
    {
        case 17: // ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP
        case 18: // ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP
        case 19: // ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT
            switch(nSubSubPropertyNumber)
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
            nPropertyMaxModifier = 13;
            break;
        case 48: // ITEM_PROPERTY_ON_HIT_PROPERTIES                        = 48 ;
            switch(nSubSubPropertyNumber)
            {
                case 0: // IP_CONST_ONHIT_SAVEDC_14                    = 0;
                    sLast = "6: Save DC 26";
                    sSelected = "0: Save DC 14";
                    sNext = "1: Save DC 16";
                    break;
                case 1: // IP_CONST_ONHIT_SAVEDC_16                    = 1;
                    sLast = "0: Save DC 14";
                    sSelected = "1: Save DC 16";
                    sNext = "2: Save DC 18";
                    break;
                case 2: // IP_CONST_ONHIT_SAVEDC_18                    = 2;
                    sLast = "1: Save DC 16";
                    sSelected = "2: Save DC 18";
                    sNext = "3: Save DC 20";
                    break;
                case 3: // IP_CONST_ONHIT_SAVEDC_20                    = 3;
                    sLast = "2: Save DC 18";
                    sSelected = "3: Save DC 20";
                    sNext = "4: Save DC 22";
                    break;
                case 4: // IP_CONST_ONHIT_SAVEDC_22                    = 4;
                    sLast = "3: Save DC 20";
                    sSelected = "4: Save DC 22";
                    sNext = "5: Save DC 24";
                    break;
                case 5: // IP_CONST_ONHIT_SAVEDC_24                    = 5;
                    sLast = "4: Save DC 22";
                    sSelected = "5: Save DC 24";
                    sNext = "6: Save DC 26";
                    break;
                case 6: // IP_CONST_ONHIT_SAVEDC_26                    = 6;
                    sLast = "5: Save DC 24";
                    sSelected = "6: Save DC 26";
                    sNext = "0: Save DC 14";
                    break;
            }
            nPropertyMaxModifier = 6;
            break;

    }


    SetLocalInt(oPC, "ITEM_SUB_SUB_PROPERTY_MAX", nPropertyMaxModifier);
    SetLocalString(oPC, "ITEM_SUB_SUB_PROPERTY_NAME", sSelected);

    SetCustomToken(70001, sLast);
    SetCustomToken(70002, sSelected);
    SetCustomToken(70003, sNext);
    SetCustomToken(70004, sNumber);
    SetCustomToken(70005, sItemProperty);
    SetCustomToken(70006, sSubPropertyName);
    return TRUE;
}
