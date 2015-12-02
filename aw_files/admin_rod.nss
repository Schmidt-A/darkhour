//The Admin Rod is Used to Set Players
// Powers, as Game Masters -> it add their Login name
// in the database - so they will return TRUE to the GetIsGMNormalChar() Function
// So on Use on the rod it Manage the targeted object in the conversation
#include "aw_include"
#include "inc_bs_module"
void main()
{
//Set As Game Master

//Set As Winged God

// Set As Admin

// Remove from Game Masters

// Remove From Winged God

// Remove From Admins

object oPC = GetItemActivator();
object oItem = GetItemActivated();
object oTarget =GetItemActivatedTarget();

if (GetIsAdmin(oPC)  == FALSE)
  {
  FloatingTextStringOnCreature("You can't use this Power!",oPC,FALSE);
  DestroyObject(oItem);
  }
else
   {
   FloatingTextStringOnCreature("<c.͎>Your Target is set as: ["+ GetPCPlayerName(oTarget)+"]</c>",oPC,FALSE);
   SetLocalObject(oPC, "oMyTarget",oTarget);
   AssignCommand(oPC,ActionStartConversation(oPC,"adminsitem",TRUE,FALSE));
   }

}
