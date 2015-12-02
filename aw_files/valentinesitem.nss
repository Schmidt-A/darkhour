#include "inc_bs_module"
void main()
{
object oPC = GetItemActivator();
object oRing = GetItemActivated();
string sMessage = GetLocalString(oRing,"OnUseShout");
BroadcastMessage("<cëV¤>"+sMessage+"</c>");
}
