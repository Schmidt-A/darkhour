#include "aw_include"
void main()
{
object oGm = GetPCSpeaker();

if ( GetIsGM(oGm) || GetIsAdmin(oGm)) //Only GM with deity can use it, until they are admins ...
   {
   ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oGm);
   ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectCutsceneGhost(), oGm);
   }
else {
     FloatingTextStringOnCreature("You cannot, please do not abuse powers on your normal char!",oGm,FALSE);
     }

}
