#include "inc_bs_module"
#include "aw_include"
void main()
{
object oGm = GetItemActivator();
object oItem = GetItemActivated();
 if(GetIsGMNormalChar(oGm) || GetIsDMAW(oGm))
 {
   AssignCommand(oGm,ActionStartConversation(oGm,"gamemasteritem",TRUE,FALSE));
 }
 else
 {
   FloatingTextStringOnCreature("you can not use this item", oGm, TRUE);
   DestroyObject(oItem, 0.0);
 }
}
