#include "inc_bs_module"
#include "aw_include"
void main()
{
object oGm = GetItemActivator();
object oItem = GetItemActivated();
if (GetIsGM(oGm)  == FALSE && GetIsGMNormalChar(oGm) == FALSE && GetIsAdmin(oGm) == FALSE)
{
FloatingTextStringOnCreature("You can't use this Power!",oGm,FALSE);
DestroyObject(oItem);
}
else  AssignCommand(oGm,ActionStartConversation(oGm,"gamemasteritem",TRUE,FALSE));
}
