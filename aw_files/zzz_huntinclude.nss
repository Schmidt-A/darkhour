#include "aw_include"
#include "inc_bs_module"
void DoFeats(object oPC);
void DoFeats(object oPC)
{
int x;
if(GetHasFeat(FEAT_ANIMAL_COMPANION,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_ANIMAL_COMPANION);
    }

if(GetHasFeat(FEAT_SUMMON_GREATER_UNDEAD,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_SUMMON_GREATER_UNDEAD);
    }

if(GetHasFeat(FEAT_SUMMON_UNDEAD,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_SUMMON_UNDEAD);
    }
if(GetHasFeat(FEAT_SUMMON_SHADOW,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_SUMMON_SHADOW);
    }


if(GetHasFeat(FEAT_BARBARIAN_RAGE,oPC))
    {
    x = (GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC)/4)+1;
    while (x != 0)
        {
        x = x - 1;
        DecrementRemainingFeatUses(oPC, FEAT_BARBARIAN_RAGE);
        }
    }

if(GetHasFeat(FEAT_BARD_SONGS,oPC))
    {
    x = GetLevelByClass(CLASS_TYPE_BARD, oPC);
    if(GetHasFeat(FEAT_EXTRA_MUSIC,oPC))
        {
        x = x + 4;
        }
    while (x != 0)
        {
        x = x - 1;
        DecrementRemainingFeatUses(oPC, FEAT_BARD_SONGS);
        }
    }

if(GetHasFeat(FEAT_BULLS_STRENGTH,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_BULLS_STRENGTH);
    }

if(GetHasFeat(FEAT_CONTAGION,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_CONTAGION);
    }

if(GetHasFeat(FEAT_CRAFT_HARPER_ITEM,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_CRAFT_HARPER_ITEM);
    }

if(GetHasFeat(FEAT_DIVINE_WRATH,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_DIVINE_WRATH);
    }

if(GetHasFeat(FEAT_EMPTY_BODY,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_EMPTY_BODY);
    DecrementRemainingFeatUses(oPC, FEAT_EMPTY_BODY);
    }

if(GetHasFeat(FEAT_EPIC_EPIC_FIEND,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_EPIC_EPIC_FIEND);
    }

if(GetHasFeat(FEAT_EPIC_EPIC_SHADOWLORD,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_EPIC_EPIC_SHADOWLORD);
    }

if(GetHasFeat(FEAT_EPIC_SPELL_RUIN,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_EPIC_SPELL_RUIN);
    }

if(GetHasFeat(FEAT_EPIC_SPELL_HELLBALL,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_EPIC_SPELL_HELLBALL);
    }

if(GetHasFeat(FEAT_EPIC_SPELL_MAGE_ARMOUR,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_EPIC_SPELL_MAGE_ARMOUR);
    }

if(GetHasFeat(FEAT_EPIC_SPELL_MUMMY_DUST,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_EPIC_SPELL_MUMMY_DUST);
    }

if(GetHasFeat(FEAT_HARPER_CATS_GRACE,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_HARPER_CATS_GRACE);
    }

if(GetHasFeat(FEAT_HARPER_EAGLES_SPLENDOR,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_HARPER_EAGLES_SPLENDOR);
    DecrementRemainingFeatUses(oPC, FEAT_HARPER_EAGLES_SPLENDOR);
    }

if(GetHasFeat(FEAT_HARPER_INVISIBILITY,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_HARPER_INVISIBILITY);
    DecrementRemainingFeatUses(oPC, FEAT_HARPER_INVISIBILITY);
    }

if(GetHasFeat(FEAT_HARPER_SLEEP,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_HARPER_SLEEP);
    }

if(GetHasFeat(FEAT_INFLICT_CRITICAL_WOUNDS,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_INFLICT_CRITICAL_WOUNDS);
    }

if(GetHasFeat(FEAT_INFLICT_LIGHT_WOUNDS,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_INFLICT_LIGHT_WOUNDS);
    }

if(GetHasFeat(FEAT_INFLICT_MODERATE_WOUNDS,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_INFLICT_MODERATE_WOUNDS);
    }

if(GetHasFeat(FEAT_INFLICT_SERIOUS_WOUNDS,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_INFLICT_SERIOUS_WOUNDS);
    }

if(GetHasFeat(FEAT_LAY_ON_HANDS,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_LAY_ON_HANDS);
    }

if(GetHasFeat(FEAT_PDK_FEAR,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_PDK_FEAR);
    }

if(GetHasFeat(FEAT_PDK_INSPIRE_1,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_PDK_INSPIRE_1);
    }

if(GetHasFeat(FEAT_PDK_INSPIRE_2,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_PDK_INSPIRE_2);
    DecrementRemainingFeatUses(oPC, FEAT_PDK_INSPIRE_2);
    }

if(GetHasFeat(FEAT_PDK_INSPIRE_2,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_PDK_INSPIRE_2);
    DecrementRemainingFeatUses(oPC, FEAT_PDK_INSPIRE_2);
    }

if(GetHasFeat(FEAT_PDK_STAND,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_PDK_STAND);
    }

if(GetHasFeat(FEAT_PDK_RALLY,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_PDK_RALLY);
    DecrementRemainingFeatUses(oPC, FEAT_PDK_RALLY);
    DecrementRemainingFeatUses(oPC, FEAT_PDK_RALLY);
    }

if(GetHasFeat(FEAT_PDK_WRATH,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_PDK_WRATH);
    }

if(GetHasFeat(FEAT_PRESTIGE_INVISIBILITY_1,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_PRESTIGE_INVISIBILITY_1);
    }

if(GetHasFeat(FEAT_PRESTIGE_INVISIBILITY_2,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_PRESTIGE_INVISIBILITY_2);
    }

if(GetHasFeat(FEAT_PRESTIGE_HAIL_OF_ARROWS,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_PRESTIGE_HAIL_OF_ARROWS);
    }

if(GetHasFeat(FEAT_PRESTIGE_SEEKER_ARROW_1,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_PRESTIGE_SEEKER_ARROW_1);
    }

if(GetHasFeat(FEAT_PRESTIGE_SEEKER_ARROW_2,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_PRESTIGE_SEEKER_ARROW_2);
    DecrementRemainingFeatUses(oPC, FEAT_PRESTIGE_SEEKER_ARROW_2);
    }

if(GetHasFeat(FEAT_PRESTIGE_IMBUE_ARROW,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_PRESTIGE_IMBUE_ARROW);
    DecrementRemainingFeatUses(oPC, FEAT_PRESTIGE_IMBUE_ARROW);
    DecrementRemainingFeatUses(oPC, FEAT_PRESTIGE_IMBUE_ARROW);
    }

if(GetHasFeat(FEAT_PRESTIGE_SPELL_GHOSTLY_VISAGE,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_PRESTIGE_SPELL_GHOSTLY_VISAGE);
    }

if(GetHasFeat(FEAT_SHADOW_DAZE,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_SHADOW_DAZE);
    }

if(GetHasFeat(FEAT_SHADOW_EVADE,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_SHADOW_EVADE);
    DecrementRemainingFeatUses(oPC, FEAT_SHADOW_EVADE);
    DecrementRemainingFeatUses(oPC, FEAT_SHADOW_EVADE);
    }

if(GetHasFeat(FEAT_SHADOW_DAZE,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_SHADOW_DAZE);
    }

if(GetHasFeat(FEAT_SMITE_EVIL,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_SMITE_EVIL);
    DecrementRemainingFeatUses(oPC, FEAT_SMITE_EVIL);
    DecrementRemainingFeatUses(oPC, FEAT_SMITE_EVIL);
    }

if(GetHasFeat(FEAT_SMITE_GOOD,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_SMITE_GOOD);
    DecrementRemainingFeatUses(oPC, FEAT_SMITE_GOOD);
    DecrementRemainingFeatUses(oPC, FEAT_SMITE_GOOD);
    }

if(GetHasFeat(FEAT_SUMMON_FAMILIAR,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_SUMMON_FAMILIAR);
    }

if(GetHasFeat(FEAT_SUMMON_GREATER_UNDEAD,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_SUMMON_GREATER_UNDEAD);
    }

if(GetHasFeat(FEAT_SUMMON_SHADOW,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_SUMMON_SHADOW);
    }

if(GetHasFeat(FEAT_SUMMON_UNDEAD,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_SUMMON_UNDEAD);
    }

if(GetHasFeat(FEAT_TRICKERY_DOMAIN_POWER,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_TRICKERY_DOMAIN_POWER);
    }

if(GetHasFeat(FEAT_TURN_UNDEAD,oPC))
    {
    x = 3 + GetAbilityModifier(ABILITY_CHARISMA,oPC);
    while (x != 0)
        {
        x = x - 1;
        DecrementRemainingFeatUses(oPC, FEAT_TURN_UNDEAD);
        }
    }

if(GetHasFeat(FEAT_UNDEAD_GRAFT_1,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_UNDEAD_GRAFT_1);
    }

if(GetHasFeat(FEAT_UNDEAD_GRAFT_2,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_UNDEAD_GRAFT_2);
    DecrementRemainingFeatUses(oPC, FEAT_UNDEAD_GRAFT_2);
    }

if(GetHasFeat(FEAT_UNDEAD_GRAFT_1,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_UNDEAD_GRAFT_1);
    }

if(GetHasFeat(FEAT_DRAGON_DIS_BREATH,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_DRAGON_DIS_BREATH);
    }

if(GetHasFeat(FEAT_WHOLENESS_OF_BODY,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_WHOLENESS_OF_BODY);
    }


if(GetHasFeat(FEAT_PRESTIGE_ARROW_OF_DEATH,oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_PRESTIGE_ARROW_OF_DEATH);
    }

if(GetHasFeat(FEAT_TYMORAS_SMILE,oPC))
    {
    DecrementRemainingFeatUses(oPC,FEAT_TYMORAS_SMILE);
    }
if(GetHasFeat(FEAT_WILD_SHAPE,oPC))
    {
    DecrementRemainingFeatUses(oPC,FEAT_WILD_SHAPE);
    DecrementRemainingFeatUses(oPC,FEAT_WILD_SHAPE);
    DecrementRemainingFeatUses(oPC,FEAT_WILD_SHAPE);
    DecrementRemainingFeatUses(oPC,FEAT_WILD_SHAPE);
    DecrementRemainingFeatUses(oPC,FEAT_WILD_SHAPE);
    DecrementRemainingFeatUses(oPC,FEAT_WILD_SHAPE);
    }
if(GetHasFeat(FEAT_EPIC_WILD_SHAPE_DRAGON,oPC))
    {
    DecrementRemainingFeatUses(oPC,FEAT_EPIC_WILD_SHAPE_DRAGON);
    DecrementRemainingFeatUses(oPC,FEAT_EPIC_WILD_SHAPE_DRAGON);
    DecrementRemainingFeatUses(oPC,FEAT_EPIC_WILD_SHAPE_DRAGON);
    }
if(GetHasFeat(FEAT_GREATER_WILDSHAPE_1,oPC))
    {
    DecrementRemainingFeatUses(oPC,FEAT_GREATER_WILDSHAPE_1);
    DecrementRemainingFeatUses(oPC,FEAT_GREATER_WILDSHAPE_1);
    DecrementRemainingFeatUses(oPC,FEAT_GREATER_WILDSHAPE_1);
    }
if(GetHasFeat(FEAT_GREATER_WILDSHAPE_2,oPC))
    {
    DecrementRemainingFeatUses(oPC,FEAT_GREATER_WILDSHAPE_2);
    DecrementRemainingFeatUses(oPC,FEAT_GREATER_WILDSHAPE_2);
    DecrementRemainingFeatUses(oPC,FEAT_GREATER_WILDSHAPE_2);
    }
if(GetHasFeat(FEAT_GREATER_WILDSHAPE_3,oPC))
    {
    DecrementRemainingFeatUses(oPC,FEAT_GREATER_WILDSHAPE_3);
    DecrementRemainingFeatUses(oPC,FEAT_GREATER_WILDSHAPE_3);
    DecrementRemainingFeatUses(oPC,FEAT_GREATER_WILDSHAPE_3);
    }
if(GetHasFeat(FEAT_GREATER_WILDSHAPE_4,oPC))
    {
    DecrementRemainingFeatUses(oPC,FEAT_GREATER_WILDSHAPE_4);
    DecrementRemainingFeatUses(oPC,FEAT_GREATER_WILDSHAPE_4);
    DecrementRemainingFeatUses(oPC,FEAT_GREATER_WILDSHAPE_4);
    }
if(GetHasFeat(FEAT_EPIC_WILD_SHAPE_UNDEAD,oPC))
    {
    DecrementRemainingFeatUses(oPC,FEAT_EPIC_WILD_SHAPE_UNDEAD);
    DecrementRemainingFeatUses(oPC,FEAT_EPIC_WILD_SHAPE_UNDEAD);
    DecrementRemainingFeatUses(oPC,FEAT_EPIC_WILD_SHAPE_UNDEAD);
    }
if(GetHasFeat(FEAT_WAR_DOMAIN_POWER, oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_WAR_DOMAIN_POWER);
    }

if(GetHasFeat(FEAT_STRENGTH_DOMAIN_POWER, oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_STRENGTH_DOMAIN_POWER);
    }

if(GetHasFeat(FEAT_DEATH_DOMAIN_POWER, oPC))
    {
    DecrementRemainingFeatUses(oPC,FEAT_DEATH_DOMAIN_POWER);
    }

if(GetHasFeat(FEAT_PROTECTION_DOMAIN_POWER, oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_PROTECTION_DOMAIN_POWER);
    }

if(GetHasFeat(FEAT_WHOLENESS_OF_BODY, oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_WHOLENESS_OF_BODY);
    }
if(GetHasFeat(FEAT_EPIC_OUTSIDER_SHAPE,oPC))
    {
    DecrementRemainingFeatUses(oPC,FEAT_EPIC_OUTSIDER_SHAPE);
    DecrementRemainingFeatUses(oPC,FEAT_EPIC_OUTSIDER_SHAPE);
    DecrementRemainingFeatUses(oPC,FEAT_EPIC_OUTSIDER_SHAPE);
    }

if((GetHasFeat(FEAT_UNDEAD_GRAFT_1, oPC)) ||
    (GetHasFeat(FEAT_UNDEAD_GRAFT_2, oPC)))
    {
    DecrementRemainingFeatUses(oPC, FEAT_UNDEAD_GRAFT_1);
    DecrementRemainingFeatUses(oPC, FEAT_UNDEAD_GRAFT_1);
    DecrementRemainingFeatUses(oPC, FEAT_UNDEAD_GRAFT_1);
    DecrementRemainingFeatUses(oPC, FEAT_UNDEAD_GRAFT_2);
    DecrementRemainingFeatUses(oPC, FEAT_UNDEAD_GRAFT_2);
    DecrementRemainingFeatUses(oPC, FEAT_UNDEAD_GRAFT_2);
    }

if(GetHasFeat(FEAT_MIGHTY_RAGE, oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_MIGHTY_RAGE);
    DecrementRemainingFeatUses(oPC, FEAT_MIGHTY_RAGE);
    DecrementRemainingFeatUses(oPC, FEAT_MIGHTY_RAGE);
    }

if(GetHasFeat(FEAT_PRESTIGE_DARKNESS, oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_PRESTIGE_DARKNESS);
    }

if(GetHasFeat(FEAT_DRAGON_DIS_BREATH, oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_DRAGON_DIS_BREATH);
    }

if(GetHasFeat(FEAT_ANIMATE_DEAD, oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_ANIMATE_DEAD);
    }

if(GetHasFeat(FEAT_SUMMON_UNDEAD, oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_SUMMON_UNDEAD);
    }

if(GetHasFeat(FEAT_SUMMON_GREATER_UNDEAD, oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_SUMMON_GREATER_UNDEAD);
    }

if(GetHasFeat(FEAT_DEATHLESS_MASTER_TOUCH, oPC))
    {
    DecrementRemainingFeatUses(oPC, FEAT_DEATHLESS_MASTER_TOUCH);
    DecrementRemainingFeatUses(oPC, FEAT_DEATHLESS_MASTER_TOUCH);
    DecrementRemainingFeatUses(oPC, FEAT_DEATHLESS_MASTER_TOUCH);
    }
}

void DoAB(object oPC, int nSwitch);
void DoAB(object oPC, int nSwitch)
//nSwitch = 1 for monster, 0 for archer, 2 for beserker, 3 for legend
{
int nAAadjust;
int nAA;
int nWF;
int nEP;
int nEWF;
int nWS;
int nEWS;
int nWM;
int nWMlvl = (GetLevelByClass(CLASS_TYPE_WEAPON_MASTER, oPC) - 10);
if (nSwitch == 0)
    {
    nAA = GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER, oPC);
    nAAadjust = (nAA + 1)/2;
    nWS = (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SHORTBOW, oPC));
    nWF = (GetHasFeat(FEAT_WEAPON_FOCUS_SHORTBOW, oPC));
    nEP = (1 * GetHasFeat(FEAT_EPIC_PROWESS, oPC));
    nEWF = (2 * GetHasFeat(FEAT_EPIC_WEAPON_SPECIALIZATION_SHORTBOW, oPC));
    }
else if (nSwitch == 1)
    {
    nAAadjust = 0;
    nWF = (GetHasFeat(FEAT_WEAPON_FOCUS_CLUB, oPC));
    nWS = (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_CLUB, oPC));
    nEP = (1 * GetHasFeat(FEAT_EPIC_PROWESS, oPC));
    nEWF = (2 * GetHasFeat(FEAT_EPIC_WEAPON_FOCUS_CLUB, oPC));
    nEWS = (2 * GetHasFeat(FEAT_EPIC_WEAPON_SPECIALIZATION_CLUB, oPC));
    if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_CLUB, oPC))
    {
        nWM = ( GetHasFeat(FEAT_SUPERIOR_WEAPON_FOCUS, oPC) + ( GetHasFeat(FEAT_EPIC_SUPERIOR_WEAPON_FOCUS, oPC) * (nWMlvl/3) ) );
    }
    }
if (nSwitch == 2)
    {
    nAAadjust = 0;
    nWF = (GetHasFeat(FEAT_WEAPON_FOCUS_SPEAR, oPC));
    nWS = (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SPEAR, oPC));
    nEP = (1 * GetHasFeat(FEAT_EPIC_PROWESS, oPC));
    nEWF = (2 * GetHasFeat(FEAT_EPIC_WEAPON_FOCUS_SHORTSPEAR, oPC));
    nEWS = (2 * GetHasFeat(FEAT_EPIC_WEAPON_SPECIALIZATION_SHORTSPEAR, oPC));
    if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_SHORTSPEAR, oPC))
    {
        nWM = ( GetHasFeat(FEAT_SUPERIOR_WEAPON_FOCUS, oPC) + ( GetHasFeat(FEAT_EPIC_SUPERIOR_WEAPON_FOCUS, oPC) * (nWMlvl/3) ) );
    }
    }
if (nSwitch == 3)
    {
    nAAadjust = 0;
    nWF = (GetHasFeat(FEAT_WEAPON_FOCUS_GREAT_SWORD, oPC));
    nWS = (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_GREAT_SWORD, oPC));
    nEP = (1 * GetHasFeat(FEAT_EPIC_PROWESS, oPC));
    nEWF = (2 * GetHasFeat(FEAT_EPIC_WEAPON_FOCUS_GREATSWORD, oPC));
    nEWS = (2 * GetHasFeat(FEAT_EPIC_WEAPON_SPECIALIZATION_GREATSWORD, oPC));
    if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_GREATSWORD, oPC))
    {
        nWM = ( GetHasFeat(FEAT_SUPERIOR_WEAPON_FOCUS, oPC) + ( GetHasFeat(FEAT_EPIC_SUPERIOR_WEAPON_FOCUS, oPC) * (nWMlvl/3) ) );
    }
    }
if (nSwitch == 4)
    {
    nAAadjust = 0;
    nWF = (GetHasFeat(FEAT_WEAPON_FOCUS_SLING, oPC));
    nWS = (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_SLING, oPC));
    nEP = (1 * GetHasFeat(FEAT_EPIC_PROWESS, oPC));
    nEWF = (2 * GetHasFeat(FEAT_EPIC_WEAPON_FOCUS_SLING, oPC));
    nEWS = (2 * GetHasFeat(FEAT_EPIC_WEAPON_SPECIALIZATION_SLING, oPC));
    }
if (nSwitch == 5)
    {
    nAAadjust = 0;
    nWF = (GetHasFeat(FEAT_WEAPON_FOCUS_STAFF, oPC));
    nWS = (GetHasFeat(FEAT_WEAPON_SPECIALIZATION_STAFF, oPC));
    nEP = (1 * GetHasFeat(FEAT_EPIC_PROWESS, oPC));
    nEWF = (2 * GetHasFeat(FEAT_EPIC_WEAPON_FOCUS_QUARTERSTAFF, oPC));
    nEWS = (2 * GetHasFeat(FEAT_EPIC_WEAPON_SPECIALIZATION_QUARTERSTAFF, oPC));
    if (GetHasFeat(FEAT_WEAPON_OF_CHOICE_QUARTERSTAFF, oPC))
    {
        nWM = ( GetHasFeat(FEAT_SUPERIOR_WEAPON_FOCUS, oPC) + ( GetHasFeat(FEAT_EPIC_SUPERIOR_WEAPON_FOCUS, oPC) * (nWMlvl/3) ) );
    }
    }

nAA = GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER, oPC);
if (nAA < 1)
{
    nAAadjust = 0;
}

int nDmg = (nAAadjust + nWS + nEWS);
int nABadj = (nAAadjust - nWF - nEP - nEWF - nWM);
int nAB = 30 - GetBaseAttackBonus(oPC);
nAB = nAB - nABadj;
if (nAB > 20)
    {
    if ((nSwitch >= 1) && (nSwitch != 4))
        {
        int nExtra = (nAB - 20)*2;
        effect  eExtra = EffectAbilityIncrease(ABILITY_STRENGTH, nExtra);
        effect eAB = EffectAttackIncrease(19);
        int nBalance = nExtra/2;
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, oPC, HoursToSeconds(24));
        effect eBalance = EffectDamageDecrease(nBalance, DAMAGE_TYPE_BLUDGEONING);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBalance, oPC, HoursToSeconds(24));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExtra, oPC, HoursToSeconds(24));
        }
    else
        {
        int nExtra = (nAB - 20)*2;
        effect  eExtra = EffectAbilityIncrease(ABILITY_DEXTERITY, nExtra);
        int nBalance = nExtra/2;
        effect eBalance = EffectACDecrease(nBalance);
        effect eHide = EffectSkillDecrease(SKILL_HIDE, nBalance);
        effect eMS = EffectSkillDecrease(SKILL_MOVE_SILENTLY, nBalance);
        eBalance = EffectLinkEffects(eBalance, eMS);
        eBalance = EffectLinkEffects(eBalance, eHide);
        effect eAB = EffectAttackIncrease(19);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, oPC, HoursToSeconds(24));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eExtra, oPC, HoursToSeconds(24));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBalance, oPC, HoursToSeconds(24));
        }
    }
    else
    {
        nAB = nAB - 1;
        effect eAB = EffectAttackIncrease( nAB);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, oPC, HoursToSeconds(24));
    }

effect eDmg;
if (nSwitch = 1)
{
 eDmg = EffectDamageDecrease(nDmg, DAMAGE_TYPE_BLUDGEONING);
}
else
{
 eDmg = EffectDamageDecrease(nDmg, DAMAGE_TYPE_PIERCING);
}

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDmg, oPC, HoursToSeconds(24));

}

void DoAttacks(object oPC);
void DoAttacks(object oPC)
{
int nLvl = GetHitDice(oPC);
int nAttacks = 0;
int nAdjlvl = 0;
if (nLvl > 20)
{
    nAdjlvl = ( (nLvl - 19)/2 );
}
    int nBase = (GetBaseAttackBonus(oPC) - nAdjlvl - 1);
    int nAttackMod = (nBase/5);
    nAttacks = (3 - nAttackMod);
    if (nAttacks < 0)
    {
        nAttacks = 0;
    }
nAttacks = (nAttacks + 2);
if (GetHasFeat(FEAT_MONK_ENDURANCE, oPC) == TRUE) // monk endurance = monk speed, weird bioware naming system
{
    nAttacks = (nAttacks + 1);
}
if (nAttacks > 5) // ModifyAttacks breaks if more than 5 are applied
{
    nAttacks = 5;
}
effect eAttacks = EffectModifyAttacks(nAttacks);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttacks, oPC, HoursToSeconds(24));
}


void DoDR (object oPC, int nPercent, int nSwitch);
void DoDR (object oPC, int nPercent, int nSwitch)
//nSwitch as 1 for monster, 0 for hunter
{
effect eDD;
int nDDadj =( ( ( ( (GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER, oPC) - 6 )/4)*3) + 3*GetHasFeat(FEAT_EPIC_DAMAGE_REDUCTION_3, oPC) + 3*GetHasFeat(FEAT_EPIC_DAMAGE_REDUCTION_6, oPC) + 3*GetHasFeat(FEAT_EPIC_DAMAGE_REDUCTION_9, oPC) + ( (GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC)-8)/3 ) * nPercent ));
if (nSwitch == 1)
{
eDD = EffectDamageImmunityDecrease(DAMAGE_TYPE_PIERCING, nDDadj);
effect ePierce = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING, 25);
effect ePos = EffectDamageImmunityIncrease(DAMAGE_TYPE_MAGICAL, 25);
eDD = EffectLinkEffects(eDD, ePierce);
eDD = EffectLinkEffects(eDD, ePos);
}
else
{
eDD = EffectDamageImmunityDecrease(DAMAGE_TYPE_BLUDGEONING, nDDadj);
effect ePierce = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 50);
effect ePos = EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE, 50);
eDD = EffectLinkEffects(eDD, ePierce);
eDD = EffectLinkEffects(eDD, ePos);
}
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDD, oPC, HoursToSeconds(24));
}

void DoAC(object oPC, int nAmount);
void DoAC(object oPC, int nAmount)
{
int nAC;
nAC = GetAC(oPC);
nAC = nAC + (GetHasFeat(FEAT_EPIC_DODGE, oPC)*5) + (GetHasFeat(FEAT_EPIC_SELF_CONCEALMENT_10, oPC)*2) + (GetHasFeat(FEAT_EPIC_SELF_CONCEALMENT_20, oPC)*2) + (GetHasFeat(FEAT_EPIC_SELF_CONCEALMENT_30, oPC)*2) + (GetHasFeat(FEAT_EPIC_SELF_CONCEALMENT_40, oPC)*2) + (GetHasFeat(FEAT_EPIC_SELF_CONCEALMENT_50, oPC)*2);
if (nAC < nAmount)
    {
        nAC = nAmount - nAC;
        if (nAC > 20)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACIncrease(20, AC_DEFLECTION_BONUS),oPC, HoursToSeconds(24));
            nAC = nAC - 20;
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACIncrease(nAC, AC_NATURAL_BONUS),oPC,HoursToSeconds(24));
        }
        else
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACIncrease(nAC, AC_NATURAL_BONUS),oPC, HoursToSeconds(24));
        }
    }
else if (nAC > nAmount)
    {
        nAC = nAC - nAmount;
        if (nAC > 20)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACDecrease(20, AC_DEFLECTION_BONUS),oPC,HoursToSeconds(24));
            nAC = nAC - 20;
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACDecrease(nAC, AC_NATURAL_BONUS),oPC,HoursToSeconds(24));
        }
        else
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACDecrease(nAC, AC_NATURAL_BONUS),oPC,HoursToSeconds(24));
        }
    }
}

void DoRemoveBuffs(object oPC);
void DoRemoveBuffs(object oPC)
{
    effect eLook = GetFirstEffect(oPC); //STRIP BUFFS!
    while(GetIsEffectValid(eLook))
    {
        if( GetEffectType(eLook) != EFFECT_TYPE_HASTE &&
            GetEffectType(eLook) != EFFECT_TYPE_AC_DECREASE &&
            GetEffectType(eLook) != EFFECT_TYPE_ABILITY_DECREASE &&
            GetEffectType(eLook) != EFFECT_TYPE_MOVEMENT_SPEED_DECREASE &&
            GetEffectType(eLook) != EFFECT_TYPE_SLOW)
        {
            RemoveEffect(oPC, eLook);
        }
        eLook = GetNextEffect(oPC);
    }
}

void DoSkills(object oPC, int nSwitch);
void DoSkills(object oPC, int nSwitch)
{
int nHide;
int nMS;
int nSpot;
int nListen;
int nDisc = 50;
if (nSwitch == 2)
{
nSpot = (50 - GetSkillRank(SKILL_SPOT, oPC, TRUE) - (((GetAbilityScore(oPC, ABILITY_WISDOM, TRUE)-10)/2)) - (10 * GetHasFeat(FEAT_EPIC_SKILL_FOCUS_SPOT, oPC)) - (3 * GetHasFeat(FEAT_SKILL_FOCUS_SPOT, oPC)) - (2 * GetHasFeat(FEAT_ALERTNESS, oPC)) - (2 * GetHasFeat(FEAT_SKILL_AFFINITY_SPOT, oPC)));
nListen = (50 - GetSkillRank(SKILL_LISTEN, oPC, TRUE) - (((GetAbilityScore(oPC, ABILITY_WISDOM, TRUE)-10)/2)) - (10 * GetHasFeat(FEAT_EPIC_SKILL_FOCUS_LISTEN, oPC))  - (3 * GetHasFeat(FEAT_SKILL_FOCUS_LISTEN, oPC)) - (2 * GetHasFeat(FEAT_ALERTNESS, oPC)) - (2 * GetHasFeat(FEAT_SKILL_AFFINITY_LISTEN, oPC)));
}
else
{
nSpot = (40 - GetSkillRank(SKILL_SPOT, oPC, TRUE) - (((GetAbilityScore(oPC, ABILITY_WISDOM, TRUE)-10)/2)) - (10 * GetHasFeat(FEAT_EPIC_SKILL_FOCUS_SPOT, oPC)) - (3 * GetHasFeat(FEAT_SKILL_FOCUS_SPOT, oPC)) - (2 * GetHasFeat(FEAT_ALERTNESS, oPC)) - (2 * GetHasFeat(FEAT_SKILL_AFFINITY_SPOT, oPC)));
nListen = (40 - GetSkillRank(SKILL_LISTEN, oPC, TRUE) - (((GetAbilityScore(oPC, ABILITY_WISDOM, TRUE)-10)/2)) - (10 * GetHasFeat(FEAT_EPIC_SKILL_FOCUS_LISTEN, oPC))  - (3 * GetHasFeat(FEAT_SKILL_FOCUS_LISTEN, oPC)) - (2 * GetHasFeat(FEAT_ALERTNESS, oPC)) - (2 * GetHasFeat(FEAT_SKILL_AFFINITY_LISTEN, oPC)));
}
if (nSwitch >= 1)
{
nHide = (40 - GetSkillRank(SKILL_HIDE, oPC, TRUE) - (10 * GetHasFeat(FEAT_EPIC_SKILL_FOCUS_HIDE, oPC))  - (3 * GetHasFeat(FEAT_SKILL_FOCUS_HIDE, oPC)) - (2 * GetHasFeat(FEAT_STEALTHY, oPC)));
nMS = (40 - GetSkillRank(SKILL_MOVE_SILENTLY, oPC, TRUE) - (10 * GetHasFeat(FEAT_EPIC_SKILL_FOCUS_MOVESILENTLY, oPC))  - (3 * GetHasFeat(FEAT_SKILL_FOCUS_MOVE_SILENTLY, oPC)) - (2 * GetHasFeat(FEAT_STEALTHY, oPC)) - (2 * GetHasFeat(FEAT_SKILL_AFFINITY_MOVE_SILENTLY, oPC)) );
}
else
{
nHide = (30 - GetSkillRank(SKILL_HIDE, oPC, TRUE) - (20 * GetHasFeat(FEAT_HIDE_IN_PLAIN_SIGHT, oPC)) - (10 * GetHasFeat(FEAT_EPIC_SKILL_FOCUS_HIDE, oPC))  - (3 * GetHasFeat(FEAT_SKILL_FOCUS_HIDE, oPC)) - (2 * GetHasFeat(FEAT_STEALTHY, oPC)));
nMS = (30 - GetSkillRank(SKILL_MOVE_SILENTLY, oPC, TRUE) - (20 * GetHasFeat(FEAT_HIDE_IN_PLAIN_SIGHT, oPC))- (10 * GetHasFeat(FEAT_EPIC_SKILL_FOCUS_MOVESILENTLY, oPC))  - (3 * GetHasFeat(FEAT_SKILL_FOCUS_MOVE_SILENTLY, oPC)) - (2 * GetHasFeat(FEAT_STEALTHY, oPC)) - (2 * GetHasFeat(FEAT_SKILL_AFFINITY_MOVE_SILENTLY, oPC)) );
}
if (nSpot > 50)
{
    nSpot = 50;
}
if (nListen > 50)
{
    nListen = 50;
}
if (nHide > 50)
{
    nHide = 50;
}
if (nListen < -50)
{
    nMS = 50;
}
if (nSpot < -50)
{
    nSpot = -50;
}
if (nListen < -50)
{
    nListen = -50;
}
if (nHide < -50)
{
    nHide = -50;
}
if (nListen < -50)
{
    nMS = -50;
}

int nConc = 50 - GetSkillRank(SKILL_CONCENTRATION, oPC, TRUE) - (10 * GetHasFeat(FEAT_EPIC_SKILL_FOCUS_CONCENTRATION, oPC))  - (3 * GetHasFeat(FEAT_SKILL_FOCUS_CONCENTRATION, oPC));
int nTaunt = (40 - GetSkillRank(SKILL_TAUNT, oPC, TRUE) - (10 * GetHasFeat(FEAT_EPIC_SKILL_FOCUS_TAUNT, oPC))  - (3 * GetHasFeat(FEAT_SKILL_FOCUS_TAUNT, oPC)) - (((GetAbilityScore(oPC, ABILITY_CHARISMA, TRUE)-10)/2)) );
effect eHide;
effect eMS;
effect eDiscipline;
effect eListen;
effect eSpot;
effect eConc;
effect eTaunt;

if (nDisc > 0)
{
    eDiscipline = EffectSkillIncrease(SKILL_DISCIPLINE, nDisc);
}
else
{
    nDisc = abs(nDisc);
    eDiscipline = EffectSkillDecrease(SKILL_DISCIPLINE, nDisc);
}
if (nSpot > 0)
{
    eSpot = EffectSkillIncrease(SKILL_SPOT, nSpot);
}
else
{
    nSpot = abs(nSpot);
    eSpot = EffectSkillDecrease(SKILL_SPOT, nSpot);
}
if (nListen > 0)
{
    eListen = EffectSkillIncrease(SKILL_LISTEN, nListen);
}
else
{
    nListen = abs(nListen);
    eListen = EffectSkillDecrease(SKILL_LISTEN, nListen);
}

if (nHide > 0)
{
    eHide = EffectSkillIncrease(SKILL_HIDE, nHide);
}
else
{
    nHide = abs(nHide);
    eHide = EffectSkillDecrease(SKILL_HIDE, nHide);
}

if (nMS > 0)
{
    eMS = EffectSkillIncrease(SKILL_MOVE_SILENTLY, nMS);
}
else
{
    nMS = abs(nMS);
    eMS = EffectSkillDecrease(SKILL_MOVE_SILENTLY, nMS);
}

if (nConc > 0)
{
    eConc = EffectSkillIncrease(SKILL_CONCENTRATION, nConc);
}
else
{
    nConc = abs(nConc);
    eConc = EffectSkillDecrease(SKILL_CONCENTRATION, nConc);
}

if (nTaunt > 0)
{
    eTaunt = EffectSkillIncrease(SKILL_TAUNT, nTaunt);
}
else
{
    nTaunt = abs(nTaunt);
    eTaunt = EffectSkillDecrease(SKILL_TAUNT, nTaunt);
}

effect eDo;
eDo = EffectLinkEffects(eHide, eDiscipline);
eDo = EffectLinkEffects(eDo, eMS);
eDo = EffectLinkEffects(eDo, eSpot);
eDo = EffectLinkEffects(eDo, eListen);
eDo = EffectLinkEffects(eDo, eConc);
eDo = EffectLinkEffects(eDo, eTaunt);
eDo = ExtraordinaryEffect(eDo);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDo, oPC, HoursToSeconds(24));
}

void DoHP(object oPC, int nAmount);
void DoHP(object oPC, int nAmount)
{
if ((GetCurrentHitPoints(oPC) >= nAmount)) //does character have more than the HP than the amount we want?
{
    int nHP = (GetCurrentHitPoints(oPC) - nAmount);
    effect eHP = EffectDamage(nHP, DAMAGE_TYPE_NEGATIVE);
    eHP = ExtraordinaryEffect(eHP);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHP, oPC);
}
else // they must have less if not more or ==
{
    int nHP = (nAmount - GetCurrentHitPoints(oPC));
    effect eHP = EffectTemporaryHitpoints(nHP);
    eHP = ExtraordinaryEffect(eHP);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oPC, HoursToSeconds(24));

}
}

void DoTrans(object oPC);
void DoTrans(object oPC)
{
effect eImm1 = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING, 100);
effect eImm2 = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 100);
effect eImm3 = EffectDamageImmunityIncrease(DAMAGE_TYPE_MAGICAL, 100);
effect eImm4 = EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE, 100);
effect eImm5 = EffectDamageImmunityIncrease(DAMAGE_TYPE_DIVINE, 100);
effect eImm = EffectLinkEffects(eImm1, eImm2);
eImm = EffectLinkEffects(eImm1, eImm2);
eImm = EffectLinkEffects(eImm, eImm3);
eImm = EffectLinkEffects(eImm, eImm4);
eImm = EffectLinkEffects(eImm, eImm5);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eImm, oPC, RoundsToSeconds(1));
}


////////////////////////////////////
//TURNS PC INTO THE LEGENDARY HUNTER
////////////////////////////////////

void HuntLegend(object oPC);
void HuntLegend(object oPC)
{
    DoRemoveBuffs(oPC);
    effect eHeal = EffectHeal(4000);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    DoTrans(oPC);
    int nPCTeam = GetLocalInt(oPC, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPC),20)+"</c>" + " becomes a Legend!", TALKVOLUME_SHOUT));

int nGender;
if (GetGender(oPC) == GENDER_MALE) // separate appearances for male and female
{
    nGender = 122;
}

else
{
    nGender = 123;
}
effect ePoly = EffectPolymorph(nGender, TRUE);
SetLocalInt(oPC, "LegendHunter", TRUE);
DeleteLocalInt(oPC, "Hunter");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 4000;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 40));
DelayCommand(1.3, DoAB(oPC, 3));
DelayCommand(1.3, DoDR(oPC, 4, 0));
DelayCommand(1.3, DoSkills(oPC, 0));
DelayCommand(1.3, DoAttacks(oPC));

DelayCommand(TurnsToSeconds(1), ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage((GetCurrentHitPoints(oPC)/2), DAMAGE_TYPE_DIVINE), oPC));
DelayCommand(TurnsToSeconds(1), FloatingTextStringOnCreature("You feats of valour take their toll on your body.", oPC));
DelayCommand(RoundsToSeconds(15), ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage((GetCurrentHitPoints(oPC)/2), DAMAGE_TYPE_DIVINE), oPC));
DelayCommand(RoundsToSeconds(15), FloatingTextStringOnCreature("You feats of valour take their toll on your body.", oPC));
DelayCommand(RoundsToSeconds(20), ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage((GetCurrentHitPoints(oPC)/2), DAMAGE_TYPE_DIVINE), oPC));
DelayCommand(RoundsToSeconds(20), FloatingTextStringOnCreature("You feats of valour take their toll on your body.", oPC));
}

///////////////////////////////////////////
//TURN PC INTO BOAR IN "THE HUNT" GAME MODE
///////////////////////////////////////////

void HuntBoar(object oPC);
void HuntBoar(object oPC)
{
if (GetLocalInt(oPC, "Monster") == 0) //don't do it if they already have it
{
    DoRemoveBuffs(oPC);
    effect eHeal = EffectHeal(4000);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    DoTrans(oPC);
    int nPCTeam = GetLocalInt(oPC, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPC),20)+"</c>" + " turned into a Wereboar!", TALKVOLUME_SHOUT));

effect ePoly = EffectPolymorph(113, TRUE);
SetLocalInt(oPC, "Monster", 1);
DeleteLocalInt(oPC, "Hunter");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 4000;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 40));
DelayCommand(1.3, DoAB(oPC, 1));
DelayCommand(1.3, DoDR(oPC, 4, 1));
DelayCommand(1.3, DoSkills(oPC, 0));
DelayCommand(1.3, DoAttacks(oPC));

//boar specific (25% movement speed decrease)
int nSpeed = 25;
effect eSlow = EffectMovementSpeedDecrease(nSpeed);
eSlow = ExtraordinaryEffect(eSlow);
DelayCommand(1.3, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oPC, HoursToSeconds(24)));
int nStealth = 30;
effect eHide = EffectSkillDecrease(SKILL_HIDE, nStealth);
effect eMS = EffectSkillDecrease(SKILL_MOVE_SILENTLY, nStealth);
eHide = EffectLinkEffects(eHide, eMS);
DelayCommand(1.3, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHide, oPC, HoursToSeconds(24)));



}
}

//////////////////////////////////////////
//TURN PC INTO RAT IN "THE HUNT" GAME MODE
//////////////////////////////////////////

void HuntRat(object oPC);
void HuntRat(object oPC)
{
if (GetLocalInt(oPC, "Monster") == 0) //don't do it if they already have it
{
    DoRemoveBuffs(oPC);
    effect eHeal = EffectHeal(4000);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    DoTrans(oPC);
    int nPCTeam = GetLocalInt(oPC, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPC),20)+"</c>" + " turned into a Wererat!", TALKVOLUME_SHOUT));

effect ePoly = EffectPolymorph(111, TRUE);
SetLocalInt(oPC, "Monster", 2);
DeleteLocalInt(oPC, "Hunter");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 1000;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 65));
DelayCommand(1.3, DoAB(oPC, 1));
DelayCommand(1.3, DoDR(oPC, 4, 1));
DelayCommand(1.3, DoSkills(oPC, 0));
DelayCommand(1.3, DoAttacks(oPC));
}
}

/////////////////////////////////////////////
//TURNS PC INTO WOLF IN "THE HUNT" GAME MODE
/////////////////////////////////////////////

void HuntWolf(object oPC);
void HuntWolf(object oPC)
{
if (GetLocalInt(oPC, "Monster") == 0) //don't do it if they already have it
{
    DoRemoveBuffs(oPC);
    effect eHeal = EffectHeal(4000);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    DoTrans(oPC);
    int nPCTeam = GetLocalInt(oPC, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPC),20)+"</c>" + " turned a the Werewolf!", TALKVOLUME_SHOUT));

effect ePoly = EffectPolymorph(114, TRUE);
SetLocalInt(oPC, "Monster", 3);
DeleteLocalInt(oPC, "Hunter");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 3000;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 60));
DelayCommand(1.3, DoAB(oPC, 1));
DelayCommand(1.3, DoDR(oPC, 4, 1));
DelayCommand(1.3, DoSkills(oPC, 0));
DelayCommand(1.3, DoAttacks(oPC));
}
}

///////////////////////////////////////////
//TURNS PC INTO CAT IN "THE HUNT" GAME MODE
///////////////////////////////////////////

void HuntCat(object oPC);
void HuntCat(object oPC)
{
if (GetLocalInt(oPC, "Monster") == 0) //don't do it if they already have it
{
    DoRemoveBuffs(oPC);
    effect eHeal = EffectHeal(4000);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    DoTrans(oPC);
    int nPCTeam = GetLocalInt(oPC, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPC),20)+"</c>" + " turned a the Werecat!", TALKVOLUME_SHOUT));

effect ePoly = EffectPolymorph(112, TRUE);
SetLocalInt(oPC, "Monster", 4);
DeleteLocalInt(oPC, "Hunter");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 3000;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 60));
DelayCommand(1.3, DoAB(oPC, 1));
DelayCommand(1.3, DoDR(oPC, 4, 1));
DelayCommand(1.3, DoSkills(oPC, 0));
DelayCommand(1.3, DoAttacks(oPC));
}
}

///////////////////////////
//TURNS PC INTO THE MUTANT
///////////////////////////

void HuntMutant(object oPC);
void HuntMutant(object oPC)
{
    DoRemoveBuffs(oPC);
    effect eHeal = EffectHeal(4000);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    DoTrans(oPC);
    int nPCTeam = GetLocalInt(oPC, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPC),20)+"</c>" + " turned into a Mutant!", TALKVOLUME_SHOUT));

effect ePoly = EffectPolymorph(120, TRUE);
SetLocalInt(oPC, "Monster", 5);
DeleteLocalInt(oPC, "Hunter");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 5000;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 40));
DelayCommand(1.3, DoAB(oPC, 1));
DelayCommand(1.3, DoDR(oPC, 4, 1));
DelayCommand(1.3, DoSkills(oPC, 0));
DelayCommand(1.3, DoAttacks(oPC));

//mutant specific (50% movement speed decrease)
int nSpeed = 50;
effect eSlow = EffectMovementSpeedDecrease(nSpeed);
eSlow = ExtraordinaryEffect(eSlow);
DelayCommand(1.2, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSlow, oPC, HoursToSeconds(24)));

int nStealth = 30;
effect eHide = EffectSkillDecrease(SKILL_HIDE, nStealth);
effect eMS = EffectSkillDecrease(SKILL_MOVE_SILENTLY, nStealth);
eHide = EffectLinkEffects(eHide, eMS);
DelayCommand(1.3, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHide, oPC, HoursToSeconds(24)));



}

/////////////////////////////
//TURNS PC INTO THE WEREFROG
/////////////////////////////

void HuntFrog(object oPC);
void HuntFrog(object oPC)
{
    DoRemoveBuffs(oPC);
    effect eHeal = EffectHeal(4000);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    DoTrans(oPC);
    int nPCTeam = GetLocalInt(oPC, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPC),20)+"</c>" + " turned into a Werefrog!", TALKVOLUME_SHOUT));

effect ePoly = EffectPolymorph(125, TRUE);
SetLocalInt(oPC, "Monster", 7);
DeleteLocalInt(oPC, "Hunter");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 2000;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 65));
DelayCommand(1.3, DoAB(oPC, 1));
DelayCommand(1.3, DoDR(oPC, 4, 1));
DelayCommand(1.3, DoAttacks(oPC));
DelayCommand(1.3, DoSkills(oPC, 0));
}

/////////////////////////////////////////////
//TURNS PC INTO SKINK IN "THE HUNT" GAME MODE
/////////////////////////////////////////////

void HuntSkink(object oPC);
void HuntSkink(object oPC)
{
if (GetLocalInt(oPC, "Monster") == 0) //don't do it if they already have it
{
    DoRemoveBuffs(oPC);
    effect eHeal = EffectHeal(4000);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    DoTrans(oPC);
    int nPCTeam = GetLocalInt(oPC, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPC),20)+"</c>" + " turned into a Wereskink!", TALKVOLUME_SHOUT));

effect ePoly = EffectPolymorph(132, TRUE);
SetLocalInt(oPC, "Monster", 8);
DeleteLocalInt(oPC, "Hunter");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 1000;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 65));
DelayCommand(1.3, DoAB(oPC, 5));
DelayCommand(1.3, DoAttacks(oPC));
DelayCommand(1.3, DoDR(oPC, 4, 1));
DelayCommand(1.3, DoSkills(oPC, 1));
effect eAB;
eAB = EffectAttackDecrease(20);
DelayCommand(1.3, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, oPC, HoursToSeconds(24)));

}
}

///////////////////////////////
//TURNS PC INTO THE WEREVULTURE
///////////////////////////////

void HuntVulture(object oPC);
void HuntVulture(object oPC)
{
    DoRemoveBuffs(oPC);
    effect eHeal = EffectHeal(4000);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    DoTrans(oPC);
    int nPCTeam = GetLocalInt(oPC, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPC),20)+"</c>" + " turned into a Werevulture!", TALKVOLUME_SHOUT));

effect ePoly = EffectPolymorph(126, TRUE);
SetLocalInt(oPC, "Monster", 9);
DeleteLocalInt(oPC, "Hunter");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 1000;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 65));
DelayCommand(1.3, DoAB(oPC, 1));
DelayCommand(1.3, DoDR(oPC, 4, 1));
DelayCommand(1.3, DoAttacks(oPC));
DelayCommand(1.3, DoSkills(oPC, 0));
}

/////////////////////////////
//TURNS PC INTO THE WEREFISH
/////////////////////////////

void HuntFish(object oPC);
void HuntFish(object oPC)
{
    DoRemoveBuffs(oPC);
    effect eHeal = EffectHeal(4000);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    DoTrans(oPC);
    int nPCTeam = GetLocalInt(oPC, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPC),20)+"</c>" + " turned into a Werefish!", TALKVOLUME_SHOUT));

effect ePoly = EffectPolymorph(130, TRUE);
SetLocalInt(oPC, "Monster", 10);
DeleteLocalInt(oPC, "Hunter");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 2000;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 60));
DelayCommand(1.3, DoAB(oPC, 1));
DelayCommand(1.3, DoAttacks(oPC));
DelayCommand(1.3, DoDR(oPC, 4, 1));
DelayCommand(1.3, DoSkills(oPC, 0));
}

/////////////////////////////
//TURNS PC INTO THE WEREBULL
/////////////////////////////

void HuntBull(object oPC);
void HuntBull(object oPC)
{
    DoRemoveBuffs(oPC);
    effect eHeal = EffectHeal(4000);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    DoTrans(oPC);
    int nPCTeam = GetLocalInt(oPC, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPC),20)+"</c>" + " turned into a Werebull!", TALKVOLUME_SHOUT));

effect ePoly = EffectPolymorph(131, TRUE);
SetLocalInt(oPC, "Monster", 11);
DeleteLocalInt(oPC, "Hunter");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 4000;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 40));
DelayCommand(1.3, DoAB(oPC, 1));
DelayCommand(1.3, DoDR(oPC, 4, 1));
DelayCommand(1.3, DoAttacks(oPC));
DelayCommand(1.3, DoSkills(oPC, 0));

int nStealth = 30;
effect eHide = EffectSkillDecrease(SKILL_HIDE, nStealth);
effect eMS = EffectSkillDecrease(SKILL_MOVE_SILENTLY, nStealth);
eHide = EffectLinkEffects(eHide, eMS);
DelayCommand(1.3, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHide, oPC, HoursToSeconds(24)));

}

/////////////////////////////
//TURNS PC INTO THE WERELOUSE
/////////////////////////////

void HuntLouse(object oPC);
void HuntLouse(object oPC)
{
    DoRemoveBuffs(oPC);
    effect eHeal = EffectHeal(4000);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    DoTrans(oPC);
    int nPCTeam = GetLocalInt(oPC, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPC),20)+"</c>" + " turned into a Werelouse!", TALKVOLUME_SHOUT));

effect ePoly = EffectPolymorph(128, TRUE);
SetLocalInt(oPC, "Monster", 12);
DeleteLocalInt(oPC, "Hunter");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 800;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 65));
DelayCommand(1.3, DoAB(oPC, 4));
DelayCommand(1.3, DoAttacks(oPC));
DelayCommand(1.3, DoDR(oPC, 4, 1));
DelayCommand(1.3, DoSkills(oPC, 0));
}

/////////////////////////////
//TURNS PC INTO THE WEREANT
/////////////////////////////

void HuntAnt(object oPC);
void HuntAnt(object oPC)
{
    DoRemoveBuffs(oPC);
    effect eHeal = EffectHeal(4000);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    DoTrans(oPC);
    int nPCTeam = GetLocalInt(oPC, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPC),20)+"</c>" + " turned into a Wereant!", TALKVOLUME_SHOUT));

effect ePoly = EffectPolymorph(129, TRUE);
SetLocalInt(oPC, "Monster", 13);
DeleteLocalInt(oPC, "Hunter");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 2000;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 60));
DelayCommand(1.3, DoAB(oPC, 1));
DelayCommand(1.3, DoDR(oPC, 4, 1));
DelayCommand(1.3, DoSkills(oPC, 0));
DelayCommand(1.3, DoAttacks(oPC));
}

/////////////////////////////
//TURNS PC INTO THE WEREGOAT
/////////////////////////////

void HuntGoat(object oPC);
void HuntGoat(object oPC)
{
    DoRemoveBuffs(oPC);
    effect eHeal = EffectHeal(4000);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    DoTrans(oPC);
    int nPCTeam = GetLocalInt(oPC, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPC),20)+"</c>" + " turned into a Weregoat!", TALKVOLUME_SHOUT));

effect ePoly = EffectPolymorph(134, TRUE);
SetLocalInt(oPC, "Monster", 14);
DeleteLocalInt(oPC, "Hunter");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 1000;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 65));
DelayCommand(1.3, DoAB(oPC, 1));
DelayCommand(1.3, DoDR(oPC, 4, 1));
DelayCommand(1.3, DoAttacks(oPC));
DelayCommand(1.3, DoSkills(oPC, 0));
}

///////////////////////////////
//TURNS PC INTO THE WEREBEETLE
///////////////////////////////

void HuntBeetle(object oPC);
void HuntBeetle(object oPC)
{
    DoRemoveBuffs(oPC);
    effect eHeal = EffectHeal(4000);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    DoTrans(oPC);
    int nPCTeam = GetLocalInt(oPC, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPC),20)+"</c>" + " turned into a Werebeetle!", TALKVOLUME_SHOUT));

effect ePoly = EffectPolymorph(127, TRUE);
SetLocalInt(oPC, "Monster", 15);
DeleteLocalInt(oPC, "Hunter");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 4000;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 40));
DelayCommand(1.3, DoAB(oPC, 1));
DelayCommand(1.3, DoAttacks(oPC));
DelayCommand(1.3, DoDR(oPC, 4, 1));
DelayCommand(1.3, DoSkills(oPC, 0));

int nStealth = 30;
effect eHide = EffectSkillDecrease(SKILL_HIDE, nStealth);
effect eMS = EffectSkillDecrease(SKILL_MOVE_SILENTLY, nStealth);
eHide = EffectLinkEffects(eHide, eMS);
DelayCommand(1.3, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHide, oPC, HoursToSeconds(24)));

}

////////////////////////////////
//TURNS PC INTO THE WERESCORPION
////////////////////////////////

void HuntScorpion(object oPC);
void HuntScorpion(object oPC)
{
    DoRemoveBuffs(oPC);
    effect eHeal = EffectHeal(4000);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    DoTrans(oPC);
    int nPCTeam = GetLocalInt(oPC, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPC),20)+"</c>" + " turned into a Werescorpion!", TALKVOLUME_SHOUT));

effect ePoly = EffectPolymorph(133, TRUE);
SetLocalInt(oPC, "Monster", 16);
DeleteLocalInt(oPC, "Hunter");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 3000;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 60));
DelayCommand(1.3, DoAB(oPC, 1));
DelayCommand(1.3, DoDR(oPC, 4, 1));
DelayCommand(1.3, DoAttacks(oPC));
DelayCommand(1.3, DoSkills(oPC, 0));
}
/////////////////////////////
//TURNS PC INTO THE WERESPIDER
/////////////////////////////

void HuntSpider(object oPC);
void HuntSpider(object oPC)
{
    DoRemoveBuffs(oPC);
    effect eHeal = EffectHeal(4000);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    DoTrans(oPC);
    int nPCTeam = GetLocalInt(oPC, "nTeam");
    int nEnemyTeam = 3 - nPCTeam;
    AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+GetStringLeft(GetName(oPC),20)+"</c>" + " turned into a Werespider!", TALKVOLUME_SHOUT));

effect ePoly = EffectPolymorph(124, TRUE);
SetLocalInt(oPC, "Monster", 6);
DeleteLocalInt(oPC, "Hunter");
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oPC, HoursToSeconds(24)));
int nAmount = 1000;
DelayCommand(1.3, DoHP(oPC, nAmount));
DelayCommand(1.3, DoAC(oPC, 65));
DelayCommand(1.3, DoAB(oPC, 1));
DelayCommand(1.3, DoDR(oPC, 4, 1));
DelayCommand(1.3, DoAttacks(oPC));
DelayCommand(1.3, DoSkills(oPC, 0));

effect eAB;
eAB = EffectAttackDecrease(15);
DelayCommand(1.3, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAB, oPC, HoursToSeconds(24)));
}
