#include "inc_bs_module"
#include "aw_include"
void main()
{
object oDm = GetItemActivator();
object oPlayer = GetItemActivatedTarget() ;
object oItem = GetItemActivated();


 if(GetIsDM(oDm) || GetIsGMNormalChar(oDm))
      {
      if (GetLocalInt(oPlayer, "pause")) FreezeUnfreeze(oPlayer,oDm);
      AssignCommand(oPlayer, MovePlayerToSpawn(oPlayer));
      AssignCommand(oDm, MovePlayerToSpawn(oDm));
      }
else
   {
   FloatingTextStringOnCreature("Only Dm  can use this.",oDm, FALSE);
   DestroyObject(oItem);
   }
}
