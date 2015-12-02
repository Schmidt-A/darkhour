#include "aw_include"
void main()
{
object oGm = GetPCSpeaker();
if ( GetIsGM(oGm) || GetIsAdmin(oGm) || GetGMRank(oGm) >=3) //Only GM with deity can use it, until they are admins ...
   {
  effect eImmuneEffect = EffectSpellImmunity(SPELL_ALL_SPELLS);
         eImmuneEffect = SupernaturalEffect(eImmuneEffect);
         ApplyEffectToObject(DURATION_TYPE_PERMANENT,eImmuneEffect, oGm);
         FloatingTextStringOnCreature("You are Immune to spell now!",oGm,FALSE);
   }
else {
     FloatingTextStringOnCreature("You cannot, please do not abuse powers on your normal char!",oGm,FALSE);
     }



}
