#include "inc_bs_module"
#include "aw_include"
void main()
{
object oBadger = OBJECT_SELF;
object oAttacker = GetLastAttacker();
effect eMorph = EffectPolymorph(POLYMORPH_TYPE_BADGER,TRUE);
effect eConceal = EffectConcealment(100);
effect eSR = EffectSpellResistanceIncrease(80);
effect ePeace = EffectAttackDecrease(70);
effect eSlow = EffectMovementSpeedDecrease(50);
effect eBadger;
eBadger = EffectLinkEffects(eMorph, ePeace);
eBadger = EffectLinkEffects(eBadger, eConceal);
eBadger = EffectLinkEffects(eBadger, eSR);
eBadger = EffectLinkEffects(eBadger, eSlow);
eBadger = ExtraordinaryEffect(eBadger);
effect eKD = EffectKnockdown();


if ( GetLocalInt(oAttacker, "BadgerGift") != TRUE )
{
AssignCommand(oBadger, SpeakString("Rather than attacking you in retribution, the selfless badger gives you the gift of badgerliness.", TALKVOLUME_WHISPER));
    effect eLook = GetFirstEffect(oAttacker);
    while(GetIsEffectValid(eLook))
    {
        if(GetEffectSpellId(eLook) == SPELL_FREEDOM_OF_MOVEMENT)
        {
            RemoveEffect(oAttacker, eLook);
        }
        eLook = GetNextEffect(oAttacker);
    }
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBadger, oAttacker, RoundsToSeconds(10));
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKD, oAttacker, RoundsToSeconds(1));
SetLocalInt(oAttacker, "BadgerGift", TRUE);
SendMessageToPC(oAttacker, "For a few moments, you can do nothing but contemplate the wonders of badgerliness.");

        int nEnemyTeam = 3 - GetPlayerTeam(oAttacker);
        string szHasFlag = "oHasFlag_"+IntToString(nEnemyTeam);
        if (GetLocalObject(GetModule(),szHasFlag) == oAttacker)
        {
           DropFlag(oAttacker);
           RemoveFlagEffect(oAttacker);
        }

DelayCommand(RoundsToSeconds(10), DeleteLocalInt(oAttacker, "BadgerGift"));
}
}
