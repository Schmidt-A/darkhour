//freeze/unfreeze player freezeunfreeze ///
#include "inc_bs_module"
#include "aw_include"
void main()
{
object oGM = GetItemActivator();
object oPC = GetItemActivatedTarget();
object oItem = GetItemActivated();
if ( GetIsGM(oGM) ||GetIsGMNormalChar(oGM)) //Only GM with deity can use it, until they are admins ...
   {
   if ( oGM == oPC || GetIsDMAW(oPC))
   {
   FloatingTextStringOnCreature("You cannot!",oGM,FALSE);
   return;
   }
if ( GetIsPC(oPC)) FreezeUnfreeze(oPC,oGM);
}
else
     {
     FloatingTextStringOnCreature("You cannot!",oGM,FALSE);
     }
}


