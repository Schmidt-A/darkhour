#include "aw_include"
#include "zzz_huntinclude"
void main()
{
    object oPC = GetEnteringObject();

    DoRemoveBuffs(oPC);
    string sName = GetName(oPC);
    if ( (GetLocalInt(GetModule(), sName) != TRUE))
    {
SetLocalInt(GetModule(), sName, TRUE);
effect eCha = EffectAbilityDecrease(ABILITY_CHARISMA, 10);
effect eReflex = EffectSavingThrowDecrease(SAVING_THROW_REFLEX, 20);
effect eSave = EffectSavingThrowDecrease(SAVING_THROW_ALL, 20);
ExploreAreaForPlayer(OBJECT_SELF, oPC);
object oRules = GetObjectByTag("HuntRules");
DelayCommand(4.0,AssignCommand(oPC,ActionExamine(oRules)));
        if (GetHasFeat(FEAT_MONK_ENDURANCE, oPC))
        {
        SetActionMode(oPC, ACTION_MODE_DETECT, FALSE); //Loophole fix
        SetActionMode(oPC, ACTION_MODE_STEALTH, FALSE); //Loophole fix
        int nMonkLevels = GetLevelByClass(CLASS_TYPE_MONK, oPC);
        int nDecrease = 0;
        nDecrease + ( nMonkLevels/3)*10;
            //remove the effect of haste so it's not part of the calculation
            effect eLook = GetFirstEffect(oPC);
            while(GetIsEffectValid(eLook))
            {
                if( GetEffectType(eLook) == EFFECT_TYPE_HASTE)
                {
                    RemoveEffect(oPC, eLook);
                }
                eLook = GetNextEffect(oPC);
            }
        effect eDecrease = EffectMovementSpeedDecrease(nDecrease);
        eDecrease = SupernaturalEffect(eDecrease);
        DelayCommand(1.5,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDecrease, oPC));
        effect effSlow = EffectSlow();
        DelayCommand(1.6, ApplyEffectToObject(DURATION_TYPE_PERMANENT, effSlow, oPC));
        DelayCommand(1.7, RemoveEffect(oPC, effSlow));
        }

effect eDo;
effect eSpell = EffectSpellFailure(100);
eDo = EffectLinkEffects(eDo, eCha);
eDo = EffectLinkEffects(eDo, eSave);
eDo = EffectLinkEffects(eDo, eReflex);
eDo = EffectLinkEffects(eDo, eSpell);
eDo = ExtraordinaryEffect(eDo);
DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDo, oPC, HoursToSeconds(24)));
DelayCommand(0.5, DoFeats(oPC));
}
else if ( GetLocalInt(oPC, "spectator") != 1 )
{
    AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag("spawnpoint_inn"))));
    DeleteLocalInt(oPC, "LegendHunter");
    DeleteLocalInt(oPC, "Monster");
    DeleteLocalInt(oPC, "Hunter");
    DeleteLocalInt(GetModule(), sName);
}
}
