#include "aw_include"
void main()
{
object oGm = GetPCSpeaker();
if (GetIsGM(oGm) || GetIsAdmin(oGm) || GetGMRank(oGm) >= 3) //Only GM with deity can use it, until they are admins ...
   {
    effect eVis = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eSight = EffectTrueSeeing();
    effect eLink = EffectLinkEffects(eVis, eSight);
    eLink = EffectLinkEffects(eLink, eDur);
         ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oGm);
   }
else {
     FloatingTextStringOnCreature("You cannot, please do not abuse powers on your normal char!",oGm,FALSE);
     }




}
