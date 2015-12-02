#include "team_balance"
#include "inc_bs_module"

void main()
{
    object oPC = GetEnteringObject();

    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPC)), oPC);

    //Removes the effect of crippling strike. For those pansy mages who retreat back to the base.
    if (!GetIsPC(oPC)) return;

    object oTarget;
    oTarget = oPC;
    RemoveFlag(oPC);
    ForceRest(oPC);
    effect eEffect;
    eEffect = GetFirstEffect(oTarget);
    while (GetIsEffectValid(eEffect))
    {
    if (GetEffectType(eEffect)==EFFECT_TYPE_ABILITY_DECREASE) RemoveEffect(oTarget, eEffect);
    eEffect = GetNextEffect(oTarget);
    }
    if (!GetLocalInt(GetModule(),"DisableAutosave"))  DelayCommand(IntToFloat(Random(5)+2), ExportSingleCharacter(oPC));

  DeleteLocalInt(oPC,"UsingBackToCastle");

}


    /*if (GetLocalInt(GetModule(), "TeamBalance") && !GetLocalInt(GetModule(), "NearEndOfRound"))
    {
        DelayCommand(2.0, CheckPlayerBalance(oPC));
    }
    */

