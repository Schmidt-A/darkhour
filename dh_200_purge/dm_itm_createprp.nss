//::///////////////////////////////////////////////
//::
//:: DM_Itm_CreatePrp
//::
//:: dm_itm_createprp.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This is the script that creates the item property
//:: It takes all the local variables previously
//:: set on the GetPCSpeaker() and applies it as
//:: the appropriate item property.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Nordavind
//::         On: June 4, 2004
//::
//:://////////////////////////////////////////////


void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetLocalObject(oPC, "TARGETED_ITEM");
    object oOwner = GetItemPossessor(oItem);
    itemproperty ipProperty;

    int nItemProperty = GetLocalInt(oPC, "ITEM_PROPERTY_SELECTED");
    int nItemSubProperty = GetLocalInt(oPC, "ITEM_SUB_PROPERTY_SELECTED");
    int nItemSubSubProperty = GetLocalInt(oPC, "ITEM_SUB_SUB_PROPERTY_SELECTED");
    int nItemPropertyModifier = GetLocalInt(oPC, "ITEM_PROPERTY_MODIFIER");
    float nItemPropertyDuration = GetLocalFloat(oPC, "ITEM_PROPERTY_DURATION");

    int nDuration = DURATION_TYPE_TEMPORARY;
    if(nItemPropertyDuration == 0.0)
        nDuration = DURATION_TYPE_PERMANENT;

    switch(nItemProperty)
    {
        case 0: // ITEM_PROPERTY_ABILITY_BONUS                            = 0 ;
            ipProperty = ItemPropertyAbilityBonus(nItemSubProperty, nItemPropertyModifier+1);
            break;
        case 1: // ITEM_PROPERTY_AC_BONUS                                 = 1 ;
            ipProperty = ItemPropertyACBonus(nItemPropertyModifier);
            break;
        case 2: // ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP              = 2 ;
            ItemPropertyACBonusVsAlign(nItemSubProperty, nItemPropertyModifier);
            break;
        case 3: // ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE                  = 3 ;
            ipProperty = ItemPropertyACBonusVsDmgType(nItemSubProperty, nItemPropertyModifier);
            break;
        case 4: // ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP                 = 4 ;
            ipProperty = ItemPropertyACBonusVsRace(nItemSubProperty, nItemPropertyModifier);
            break;
        case 5: // ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT           = 5 ;
            ipProperty = ItemPropertyACBonusVsSAlign(nItemSubProperty, nItemPropertyModifier);
            break;
        case 6: // ITEM_PROPERTY_ENHANCEMENT_BONUS = 6 ;
            ipProperty = ItemPropertyEnhancementBonus(nItemPropertyModifier);
            break;
        case 7: // ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP     = 7 ;
            ipProperty = ItemPropertyEnhancementBonusVsAlign(nItemSubProperty, nItemPropertyModifier);
            break;
        case 8: // ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP        = 8 ;
            ipProperty = ItemPropertyEnhancementBonusVsRace(nItemSubProperty, nItemPropertyModifier);
            break;
        case 9: // ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT = 9 ;
            ipProperty = ItemPropertyEnhancementBonusVsSAlign(nItemSubProperty, nItemPropertyModifier);
            break;
        case 10: // ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER           = 10 ;
            ipProperty = ItemPropertyEnhancementPenalty(nItemPropertyModifier);
            break;
        case 11: // ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION               = 11 ;
            ipProperty = ItemPropertyWeightReduction(nItemPropertyModifier);
            break;
        case 12: // ITEM_PROPERTY_BONUS_FEAT                               = 12 ;
            ipProperty = ItemPropertyBonusFeat(nItemPropertyModifier);
            break;
        case 13: // ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N              = 13 ;
            ipProperty = ItemPropertyBonusLevelSpell(nItemSubProperty, nItemPropertyModifier);
            break;
        case 14: //
            SendMessageToPC(oPC, "This property is not working");
            break;
        case 15: // ITEM_PROPERTY_CAST_SPELL                               = 15 ;
            ipProperty = ItemPropertyCastSpell(nItemSubProperty, nItemPropertyModifier);
            break;
        case 16: // ITEM_PROPERTY_DAMAGE_BONUS                             = 16 ;
            ipProperty = ItemPropertyDamageBonus(nItemSubProperty, nItemPropertyModifier);
            break;
        case 17: // ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP          = 17 ;
            ipProperty = ItemPropertyDamageBonusVsAlign(nItemSubProperty, nItemSubSubProperty, nItemPropertyModifier);
            break;
        case 18: // ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP             = 18 ;
            ipProperty = ItemPropertyDamageBonusVsRace(nItemSubProperty, nItemSubSubProperty, nItemPropertyModifier);
            break;
        case 19: // ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT       = 19 ;
            ipProperty = ItemPropertyDamageBonusVsSAlign(nItemSubProperty, nItemSubSubProperty, nItemPropertyModifier);
            break;
        case 20: // ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE                     = 20 ;
            ipProperty = ItemPropertyDamageImmunity(nItemSubProperty, nItemPropertyModifier);
            break;
        case 21: // ITEM_PROPERTY_DECREASED_DAMAGE                         = 21 ;
            ipProperty = ItemPropertyDamagePenalty(nItemPropertyModifier);
            break;
        case 22: // ITEM_PROPERTY_DAMAGE_REDUCTION                         = 22 ;
            ipProperty = ItemPropertyDamageReduction(nItemSubProperty, nItemPropertyModifier);
            break;
        case 23: // ITEM_PROPERTY_DAMAGE_RESISTANCE                        = 23 ;
            ipProperty = ItemPropertyDamageResistance(nItemSubProperty, nItemPropertyModifier);
            break;
        case 24: // ITEM_PROPERTY_DAMAGE_VULNERABILITY                     = 24 ;
            ipProperty = ItemPropertyDamageVulnerability(nItemSubProperty, nItemPropertyModifier);
            break;
        case 25: //
            SendMessageToPC(oPC, "This property is not working");
            break;
        case 26: // ITEM_PROPERTY_DARKVISION                               = 26 ;
            ipProperty = ItemPropertyDarkvision();
            break;
        case 27: // ITEM_PROPERTY_DECREASED_ABILITY_SCORE                  = 27 ;
            ipProperty = ItemPropertyDecreaseAbility(nItemSubProperty, nItemPropertyModifier);
            break;
        case 28: // ITEM_PROPERTY_DECREASED_AC                             = 28 ;
            ipProperty = ItemPropertyDecreaseAC(nItemSubProperty, nItemPropertyModifier);
            break;
        case 29: // ITEM_PROPERTY_DECREASED_SKILL_MODIFIER                 = 29 ;
            ipProperty = ItemPropertyDecreaseSkill(nItemSubProperty, nItemPropertyModifier);
            break;
        case 30: //
            SendMessageToPC(oPC, "This property is not working");
            break;
        case 31: //
            SendMessageToPC(oPC, "This property is not working");
            break;
        case 32: // ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT        = 32 ;
            ipProperty = ItemPropertyContainerReducedWeight(nItemPropertyModifier);
            break;
        case 33: // ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE                  = 33 ;
            ipProperty = ItemPropertyExtraMeleeDamageType(nItemSubProperty);
            break;
        case 34: // ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE                 = 34 ;
            ipProperty = ItemPropertyExtraMeleeDamageType(nItemSubProperty);
            break;
        case 35: // ITEM_PROPERTY_HASTE                                    = 35 ;
            ipProperty = ItemPropertyHaste();
            break;
        case 36: // ITEM_PROPERTY_HOLY_AVENGER                             = 36 ;
            ipProperty = ItemPropertyHolyAvenger();
            break;
        case 37: // ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS                   = 37 ;
            ipProperty = ItemPropertyImmunityMisc(nItemSubProperty);
            break;
        case 38: // ITEM_PROPERTY_IMPROVED_EVASION                         = 38 ;
            ipProperty = ItemPropertyImprovedEvasion();
            break;
        case 39: // ITEM_PROPERTY_SPELL_RESISTANCE                         = 39 ;
            ipProperty = ItemPropertyBonusSpellResistance(nItemPropertyModifier);
            break;
        case 40: // ITEM_PROPERTY_SAVING_THROW_BONUS                       = 40 ;
            ipProperty = ItemPropertyBonusSavingThrow(nItemSubProperty, nItemPropertyModifier);
            break;
        case 41: // ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC              = 41 ;
            ipProperty = ItemPropertyBonusSavingThrowVsX(nItemSubProperty, nItemPropertyModifier);
            break;
        case 42: //
            SendMessageToPC(oPC, "This property is not working");
            break;
        case 43: // ITEM_PROPERTY_KEEN                                     = 43 ;
            ipProperty = ItemPropertyKeen();
            break;
        case 44: // ITEM_PROPERTY_LIGHT                                    = 44 ;
            ipProperty = ItemPropertyLight(nItemSubProperty, nItemPropertyModifier);
            break;
        case 45: // ITEM_PROPERTY_MIGHTY                                   = 45 ;
            ipProperty = ItemPropertyMaxRangeStrengthMod(nItemPropertyModifier);
            break;
        case 46: // ITEM_PROPERTY_MIND_BLANK                               = 46 ;
            SendMessageToPC(oPC, "This property is not working");
// unable to apply this one
            break;
        case 47: // ITEM_PROPERTY_NO_DAMAGE                                = 47 ;
            ipProperty = ItemPropertyNoDamage();
            break;
        case 48: // ITEM_PROPERTY_ON_HIT_PROPERTIES                        = 48 ;
            ipProperty = ItemPropertyOnHitProps(nItemSubProperty, nItemSubSubProperty, nItemPropertyModifier);
            break;
        case 49: // ITEM_PROPERTY_DECREASED_SAVING_THROWS                  = 49 ;
            ipProperty = ItemPropertyReducedSavingThrow(nItemSubProperty, nItemPropertyModifier);
            break;
        case 50: // ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC         = 50 ;
            ipProperty = ItemPropertyReducedSavingThrowVsX(nItemSubProperty, nItemPropertyModifier);
            break;
        case 51: // ITEM_PROPERTY_REGENERATION                             = 51 ;
            ipProperty = ItemPropertyRegeneration(nItemPropertyModifier);
            break;
        case 52: // ITEM_PROPERTY_SKILL_BONUS                              = 52 ;
            ipProperty = ItemPropertySkillBonus(nItemSubProperty, nItemPropertyModifier);
            break;
        case 53: // ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL                  = 53 ;
            ipProperty = ItemPropertySpellImmunitySpecific(nItemSubProperty);
            break;
        case 54: // ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL                    = 54 ;
            ipProperty = ItemPropertySpellImmunitySchool(nItemSubProperty);
            break;
        case 55: // ITEM_PROPERTY_THIEVES_TOOLS                            = 55 ;
            ipProperty = ItemPropertyThievesTools(nItemPropertyModifier);
            break;
        case 56: // ITEM_PROPERTY_ATTACK_BONUS                             = 56 ;
            ipProperty = ItemPropertyAttackBonus(nItemPropertyModifier);
            break;
        case 57: // ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP          = 57 ;
            ipProperty = ItemPropertyAttackBonusVsAlign(nItemSubProperty, nItemPropertyModifier);
            break;
        case 58: // ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP             = 58 ;
            ipProperty = ItemPropertyAttackBonusVsRace(nItemSubProperty, nItemPropertyModifier);
            break;
        case 59: // ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT       = 59 ;
            ipProperty = ItemPropertyAttackBonusVsSAlign(nItemSubProperty, nItemPropertyModifier);
            break;
        case 60: // ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER                = 60 ;
            ipProperty = ItemPropertyAttackPenalty(nItemPropertyModifier);
            break;
        case 61: // ITEM_PROPERTY_UNLIMITED_AMMUNITION                     = 61 ;
            ipProperty = ItemPropertyUnlimitedAmmo(nItemPropertyModifier);
            break;
        case 62: // ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP           = 62 ;
            ipProperty = ItemPropertyLimitUseByAlign(nItemSubProperty);
            break;
        case 63: // ITEM_PROPERTY_USE_LIMITATION_CLASS                     = 63 ;
            ipProperty = ItemPropertyLimitUseByClass(nItemSubProperty);
            break;
        case 64: // ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE               = 64 ;
            ipProperty = ItemPropertyLimitUseByRace(nItemSubProperty);
            break;
        case 65: // ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT        = 65 ;
            ipProperty = ItemPropertyLimitUseBySAlign(nItemSubProperty);
            break;
        case 66: // ITEM_PROPERTY_USE_LIMITATION_TILESET                   = 66 ;
            SendMessageToPC(oPC, "This property is not working");
// unable to set this one
            break;
        case 67: // ITEM_PROPERTY_REGENERATION_VAMPIRIC                    = 67 ;
            ipProperty = ItemPropertyVampiricRegeneration(nItemPropertyModifier);
            break;
        case 68: //
            SendMessageToPC(oPC, "This property is not working");
            break;
        case 69: //
            SendMessageToPC(oPC, "This property is not working");
            break;
        case 70: // ITEM_PROPERTY_TRAP                                     = 70 ;
            ipProperty = ItemPropertyTrap(nItemSubProperty, nItemPropertyModifier);
            break;
        case 71: // ITEM_PROPERTY_TRUE_SEEING                              = 71 ;
            ipProperty = ItemPropertyTrueSeeing();
            break;
        case 72: // ITEM_PROPERTY_ON_MONSTER_HIT                           = 72 ;
            ipProperty = ItemPropertyOnMonsterHitProperties(nItemSubProperty, nItemPropertyModifier);
            break;
        case 73: // ITEM_PROPERTY_TURN_RESISTANCE                          = 73 ;
            ipProperty = ItemPropertyTurnResistance(nItemPropertyModifier);
            break;
        case 74: // ITEM_PROPERTY_MASSIVE_CRITICALS                        = 74 ;
            ipProperty = ItemPropertyMassiveCritical(nItemPropertyModifier);
            break;
        case 75: // ITEM_PROPERTY_FREEDOM_OF_MOVEMENT                      = 75 ;
// unable to set this one
            SendMessageToPC(oPC, "This property is not working");
            break;
        case 76: // ITEM_PROPERTY_POISON (not working)
            SendMessageToPC(oPC, "This property is not working");
// not working
            break;
        case 77: // ITEM_PROPERTY_MONSTER_DAMAGE                           = 77 ;
            ipProperty = ItemPropertyMonsterDamage(nItemPropertyModifier);
            break;
        case 78: // ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL                 = 78 ;
            ipProperty = ItemPropertyImmunityToSpellLevel(nItemPropertyModifier);
            break;
        case 79: // ITEM_PROPERTY_SPECIAL_WALK                             = 79;
            ipProperty = ItemPropertySpecialWalk();
            break;
        case 80: // ITEM_PROPERTY_HEALERS_KIT                              = 80;
            ipProperty = ItemPropertyHealersKit(nItemPropertyModifier);
            break;
        case 81: // ITEM_PROPERTY_WEIGHT_INCREASE                          = 81;
            ipProperty = ItemPropertyWeightIncrease(nItemPropertyModifier);
            break;
        case 82: // ITEM_PROPERTY_ONHITCASTSPELL                           = 82;
            ipProperty = ItemPropertyOnHitCastSpell(nItemSubProperty, nItemPropertyModifier);
            break;
        case 83: // ITEM_PROPERTY_VISUALEFFECT                             = 83;
            ipProperty = ItemPropertyVisualEffect(nItemPropertyModifier);
            break;
        case 84: // ITEM_PROPERTY_ARCANE_SPELL_FAILURE                     = 84;
            ipProperty = ItemPropertyArcaneSpellFailure(nItemPropertyModifier);
            break;
    }

    AddItemProperty(nDuration, ipProperty, oItem, nItemPropertyDuration);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_LOS_NORMAL_10), GetLocation(oOwner));
    if(GetIsObjectValid(oOwner) == FALSE)
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_LOS_NORMAL_10), GetLocation(oItem));
}
