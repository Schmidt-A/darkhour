#include "aw_include"
void main()
{
object oGm = GetPCSpeaker();
if (GetIsGM(oGm) || GetIsAdmin(oGm) || GetGMRank(oGm) >= 3) //Only GM with deity can use it, until they are admins ... or senior
   {
  effect eVis = EffectVisualEffect(VFX_DUR_SANCTUARY);
         effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
         effect eSanc = EffectEthereal();
         effect eLink = EffectLinkEffects(eVis, eSanc);
         eLink = EffectLinkEffects(eLink, eDur);
         eLink = SupernaturalEffect(eLink);
         ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oGm);
   }
else {
     FloatingTextStringOnCreature("You cannot, please do not abuse powers on your normal char!",oGm,FALSE);
     }




}
