//New Mighty Rage
//+4 Ab,Damage,Fort,Disc,Hp per Barb Lvl for limited duration.
//By Eva01goneBerserk
//x2_s2_mghtyrage


#include "x2_i0_spells"

void main()
{
    if(!GetHasFeatEffect(FEAT_MIGHTY_RAGE))

    {
        //Declare major variables
        //Battle Cry audio effect
        PlayVoiceChat(VOICE_CHAT_BATTLECRY1);
        //Duration of Mighty Rage
        int nLevel = GetLevelByClass(CLASS_TYPE_BARBARIAN);
        int nCon = 3 + GetAbilityModifier(ABILITY_CONSTITUTION) + 8;
        object nWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF);
        itemproperty eDam;
        int wepType = GetBaseItemType(nWep);
        object oOffhand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, OBJECT_SELF);
        int nOffhandType = GetBaseItemType(oOffhand);

        if( GetCreatureSize(OBJECT_SELF) == CREATURE_SIZE_SMALL)
        {
                                           switch (wepType)
            {
                case BASE_ITEM_LIGHTHAMMER:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_LIGHTFLAIL:eDam =  ItemPropertyDamageBonus( IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_6); break;
                case BASE_ITEM_SICKLE:eDam =      ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_CLUB:eDam =        ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_BASTARDSWORD:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_6); break;
                case BASE_ITEM_BATTLEAXE:eDam =   ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_6); break;
                case BASE_ITEM_LONGSWORD:eDam =   ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_6); break;
                case BASE_ITEM_MORNINGSTAR:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_6); break;
                case BASE_ITEM_WARHAMMER:eDam =   ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_6); break;
                case BASE_ITEM_DWARVENWARAXE:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_6); break;
                case BASE_ITEM_KATANA:eDam =      ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_6); break;
                case BASE_ITEM_SHORTSWORD: eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_LIGHTMACE:eDam =   ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_WHIP:eDam =        ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_DAGGER:eDam =      ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_HANDAXE:eDam =     ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_KAMA:eDam =        ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_RAPIER:eDam =      ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_6); break;
                case BASE_ITEM_SCIMITAR:eDam =    ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_6); break;
                case BASE_ITEM_KUKRI:eDam =       ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_SHORTBOW:eDam =    ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_LIGHTCROSSBOW:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_LONGBOW:eDam =     ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_HEAVYCROSSBOW:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_SLING:eDam =       ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_SHURIKEN:eDam =    ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_DART:eDam =        ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_THROWINGAXE:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_MAGICSTAFF:eDam =  ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_INVALID: {
                                                    //if not ranged wep, then must be monk gloves
                                                    nWep =  GetItemInSlot(INVENTORY_SLOT_ARMS, OBJECT_SELF);
                                                    eDam =  ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                                                   }
                default: eDam =                   ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
            }
        }
        else
        {
            switch (wepType)
            {
                case BASE_ITEM_LIGHTHAMMER:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_LIGHTFLAIL:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_SICKLE:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_CLUB:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_BASTARDSWORD:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_BATTLEAXE:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_LONGSWORD:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_MORNINGSTAR:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_WARHAMMER:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_DWARVENWARAXE:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_KATANA:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_SHORTSWORD: eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_LIGHTMACE:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_WHIP:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_DAGGER:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_HANDAXE:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_KAMA:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_RAPIER:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_SCIMITAR:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_KUKRI:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_SHORTBOW:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_LIGHTCROSSBOW:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_LONGBOW:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_HEAVYCROSSBOW:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_SLING:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_SHURIKEN:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_DART:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_THROWINGAXE:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_MAGICSTAFF:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_GREATAXE:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_6); break;
                case BASE_ITEM_GREATSWORD:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_6); break;
                case BASE_ITEM_DOUBLEAXE:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_HALBERD:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_6); break;
                case BASE_ITEM_QUARTERSTAFF:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_SCYTHE:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_6); break;
                case BASE_ITEM_TWOBLADEDSWORD:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_TRIDENT:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_6); break;
                case BASE_ITEM_DIREMACE:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                case BASE_ITEM_HEAVYFLAIL:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_6); break;
                case BASE_ITEM_SHORTSPEAR:eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL,IP_CONST_DAMAGEBONUS_6); break;
                case BASE_ITEM_INVALID:    {
                                                    //if not ranged wep, then must be monk gloves
                                                    nWep =  GetItemInSlot(INVENTORY_SLOT_ARMS, OBJECT_SELF);
                                                    eDam =  ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
                                                   }
             default: eDam = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_4); break;
            }
    }
        //So that the + 8 to Str and Con effectively stack
        effect eHP = EffectTemporaryHitpoints(nLevel*4);
        effect eAb = EffectAttackIncrease(4, ATTACK_BONUS_MISC);
        effect eDisc = EffectSkillIncrease(4, SKILL_DISCIPLINE);
        effect eFort = EffectSavingThrowIncrease(4, SAVING_THROW_FORT);
        effect eWill = EffectSavingThrowIncrease(4, SAVING_THROW_WILL);
        effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
        effect eLink2 = EffectLinkEffects(eDisc, eHP);
        effect eLink3 = EffectLinkEffects(eFort, eWill);
        //So we dont lose our Rage when target of dispelling.
        eAb = ExtraordinaryEffect(eAb);
        eLink2 = ExtraordinaryEffect(eLink2);
        eLink3 = ExtraordinaryEffect(eLink3);

        if(!GetHasFeatEffect(FEAT_BARBARIAN_RAGE) && !GetHasFeatEffect(FEAT_MIGHTY_RAGE))
        {
            CheckAndApplyEpicRageFeats(nCon);
        }
        //Signel Event
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nCon > 0)
        {
            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAb, OBJECT_SELF, RoundsToSeconds(nCon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, OBJECT_SELF, RoundsToSeconds(nCon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink3, OBJECT_SELF, RoundsToSeconds(nCon));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF) ;
            AddItemProperty(DURATION_TYPE_TEMPORARY, eDam, nWep, RoundsToSeconds(nCon));
            if ((nOffhandType != BASE_ITEM_SMALLSHIELD) && (nOffhandType != BASE_ITEM_LARGESHIELD) && (nOffhandType != BASE_ITEM_TOWERSHIELD) && (nOffhandType != BASE_ITEM_TORCH) && (nOffhandType != BASE_ITEM_INVALID))
            {
                AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, IP_CONST_DAMAGEBONUS_2), oOffhand, RoundsToSeconds(nCon));
            }
            //2003-07-08, Georg: Rage Epic Feat Handling
        }
    }
}

   /*

     //////////////// OLD

     //New Mighty Rage
//+4 Ab,Damage,Fort,Disc,Hp per Barb Lvl for limited duration.
//By Eva01goneBerserk


#include "x2_i0_spells"

void main()
{
    if(!GetHasFeatEffect(FEAT_MIGHTY_RAGE))

    {
        //Declare major variables
        //Battle Cry audio effect
        PlayVoiceChat(VOICE_CHAT_BATTLECRY1);
        //Duration of Mighty Rage
        int nLevel = GetLevelByClass(CLASS_TYPE_BARBARIAN);
        int nCon = 3 + GetAbilityModifier(ABILITY_CONSTITUTION) + 8;
        object nWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF);
        effect eDam;
        int wepType = GetBaseItemType(nWep);

        if( GetCreatureSize(OBJECT_SELF) == CREATURE_SIZE_SMALL)
        {
            switch (wepType)
            {
                case BASE_ITEM_LIGHTHAMMER:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_LIGHTFLAIL:eDam = EffectDamageIncrease(6, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_SICKLE:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_CLUB:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_BASTARDSWORD:eDam = EffectDamageIncrease(6, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_BATTLEAXE:eDam = EffectDamageIncrease(6, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_LONGSWORD:eDam = EffectDamageIncrease(6, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_MORNINGSTAR:eDam = EffectDamageIncrease(6, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_WARHAMMER:eDam = EffectDamageIncrease(6, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_DWARVENWARAXE:eDam = EffectDamageIncrease(6, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_KATANA:eDam = EffectDamageIncrease(6, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_SHORTSWORD: eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_LIGHTMACE:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_WHIP:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_DAGGER:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_HANDAXE:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_KAMA:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_RAPIER:eDam = EffectDamageIncrease(6, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_SCIMITAR:eDam = EffectDamageIncrease(6, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_KUKRI:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_SHORTBOW:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_LIGHTCROSSBOW:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_LONGBOW:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_HEAVYCROSSBOW:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_SLING:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_SHURIKEN:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_DART:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_THROWINGAXE:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_MAGICSTAFF:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_INVALID:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                default: eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
            }
        }
        else
        {
            switch (wepType)
            {
                case BASE_ITEM_LIGHTHAMMER:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_LIGHTFLAIL:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_SICKLE:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_CLUB:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_BASTARDSWORD:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_BATTLEAXE:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_LONGSWORD:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_MORNINGSTAR:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_WARHAMMER:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_DWARVENWARAXE:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_KATANA:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_SHORTSWORD: eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_LIGHTMACE:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_WHIP:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_DAGGER:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_HANDAXE:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_KAMA:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_RAPIER:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_SCIMITAR:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_KUKRI:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_SHORTBOW:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_LIGHTCROSSBOW:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_LONGBOW:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_HEAVYCROSSBOW:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_SLING:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_SHURIKEN:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_DART:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_THROWINGAXE:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_MAGICSTAFF:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_GREATAXE:eDam = EffectDamageIncrease(6, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_GREATSWORD:eDam = EffectDamageIncrease(6, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_DOUBLEAXE:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_HALBERD:eDam = EffectDamageIncrease(6, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_QUARTERSTAFF:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_SCYTHE:eDam = EffectDamageIncrease(6, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_TWOBLADEDSWORD:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_TRIDENT:eDam = EffectDamageIncrease(6, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_DIREMACE:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_HEAVYFLAIL:eDam = EffectDamageIncrease(6, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_SHORTSPEAR:eDam = EffectDamageIncrease(6, DAMAGE_TYPE_BASE_WEAPON);   break;
                case BASE_ITEM_INVALID:eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
                default: eDam = EffectDamageIncrease(4, DAMAGE_TYPE_BASE_WEAPON);   break;
            }
        }
        //So that the + 8 to Str and Con effectively stack
        effect eHP = EffectTemporaryHitpoints(nLevel*4);
        effect eAb = EffectAttackIncrease(4, ATTACK_BONUS_MISC);
        effect eDisc = EffectSkillIncrease(4, SKILL_DISCIPLINE);
        effect eFort = EffectSavingThrowIncrease(4, SAVING_THROW_FORT);
        effect eWill = EffectSavingThrowIncrease(4, SAVING_THROW_WILL);
        effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
        effect eLink = EffectLinkEffects(eAb, eDam);
        effect eLink2 = EffectLinkEffects(eDisc, eHP);
        effect eLink3 = EffectLinkEffects(eFort, eWill);
        //So we dont lose our Rage when target of dispelling.
        eLink = ExtraordinaryEffect(eLink);
        eLink2 = ExtraordinaryEffect(eLink2);
        eLink3 = ExtraordinaryEffect(eLink3);

        if(!GetHasFeatEffect(FEAT_BARBARIAN_RAGE) && !GetHasFeatEffect(FEAT_MIGHTY_RAGE))
        {
            CheckAndApplyEpicRageFeats(nCon);
        }
        //Signel Event
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        if (nCon > 0)
        {
            //Apply the VFX impact and effects
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF, RoundsToSeconds(nCon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink2, OBJECT_SELF, RoundsToSeconds(nCon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink3, OBJECT_SELF, RoundsToSeconds(nCon));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF) ;
            //2003-07-08, Georg: Rage Epic Feat Handling
        }
    }
}



     */

