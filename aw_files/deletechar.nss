#include "inc_bs_module"
#include "aw_include"
void main()
{

object oPC = GetItemActivatedTarget();
object oDM = GetItemActivator();
 if ( GetIsDM(oDM) || GetIsGMNormalChar(oDM) || GetIsGM(oDM))
 {
 if(GetGMRank(oDM) < GM)
    {
        FloatingTextStringOnCreature("You'll be able to use this item only after you get a promotion! During your testing time, please contact an Admin or GM whenever you feel the need to use this item.",oDM, FALSE);
        return;
    }
   if (oPC == oDM)
   {
   FloatingTextStringOnCreature( "<cЧ?Ч>Use that on the character that you want to delete!! To delete yourself , talk to the archivist!</c>",oPC);
   return;
   }
 SetDeity(oPC,"eliminaCARATTERI");
 WriteTimestampedLogEntry("Game Master: ["+GetPCPlayerName(oDM)+"] Deleted Char: "+ GetName(oPC)+" ["+ GetPCPlayerName(oPC)+"]");
 FloatingTextStringOnCreature( "<cЧ?Ч>Your char has been Flagged Deleted!</c>",oPC, FALSE);
 BroadcastMessage("<c.мы>"+GetName(oPC)+"["+GetPCPlayerName(oPC)+"] has been Deleted by: "+GetName(oDM)+"["+GetPCPlayerName(oDM)+"]</c>");
 }
 else
 {
   FloatingTextStringOnCreature("Only Dm can use this Item",oDM, FALSE);
   DestroyObject(GetItemActivated());
 }

}
