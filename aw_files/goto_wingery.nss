#include "inc_bs_module"
#include "aw_include"
void main()
{
object oPlayer = GetLastUsedBy();
location lLoc = GetLocation(GetObjectByTag("wp_Wingery"));
int nIsWG = GetIsWingedGod(oPlayer);
   if(nIsWG == TRUE)
   {
    AssignCommand(GetObjectByTag("antiworld_npc"), SpeakString("<cóõ„> "+GetName(oPlayer)+" ["+GetPCPlayerName(oPlayer)+"] The Winged God has Entered The Wingery</c>",TALKVOLUME_SHOUT));
    PlaySound("as_mg_frstmagic1");
    effect eEffect= EffectVisualEffect(VFX_DUR_CALTROPS);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(OBJECT_SELF),2.2);
    AssignCommand(oPlayer,ClearAllActions());
    DelayCommand(1.2,AssignCommand(oPlayer,JumpToLocation(lLoc)));
    }
else
   {
   FloatingTextStringOnCreature("<cóõ„>You cannot enter here!</c>" ,oPlayer,FALSE);
   }




}
