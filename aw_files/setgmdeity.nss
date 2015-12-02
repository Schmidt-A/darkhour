
void main()
{
object oDm = GetItemActivator();
object oPlayer = GetItemActivatedTarget() ;
object oItem = GetItemActivated();
if(GetIsDM(oDm))
         {
         SetDeity(oPlayer,"GM");
         FloatingTextStringOnCreature(GetPCPlayerName(oPlayer)+" ["+GetName(oPlayer)+"] Deity set to be GameMaster.",oDm, FALSE);

         effect eVis = EffectVisualEffect(VFX_DUR_SANCTUARY);
         effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
         effect eSanc = EffectEthereal();
         effect eLink = EffectLinkEffects(eVis, eSanc);
         eLink = EffectLinkEffects(eLink, eDur);
         eLink = SupernaturalEffect(eLink);
         ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oPlayer);
         }
else
   {
   FloatingTextStringOnCreature("Only Dm  can use this.",oDm, FALSE);
   DestroyObject(oItem);
   }
}
