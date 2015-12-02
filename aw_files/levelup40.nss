#include "inc_bs_module"
void main()
{
object oDm = GetItemActivator();
object oPlayer = GetItemActivatedTarget() ;
object oItem = GetItemActivated();
if(GetIsDM(oDm))
         {
         int nGold = GetTotalPlayerItemCost(oPlayer)+ GetGold(oPlayer) ;
         SetXP(oPlayer, 780000);
         GiveGoldToCreature(oPlayer, 780000-nGold);
         effect eVis = EffectVisualEffect(VFX_DUR_AURA_FIRE);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY,  eVis, oPlayer,3.0f);
         }
else
   {
   FloatingTextStringOnCreature("Only Dm  can use this.",oDm, FALSE);
   DestroyObject(oItem);
   }

}
