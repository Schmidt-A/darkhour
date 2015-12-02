#include "inc_leto"
#include "inc_bs_module"
#include "aw_include"

void main()
{
   object oDM = GetItemActivator();
   object oTarget = GetItemActivatedTarget();
   object oItem = GetItemActivated();

   if ( GetIsDMAW(oDM) || GetIsGMNormalChar(oDM))
   {
       if (GetIsDMAW(oTarget) || GetIsAdmin(oTarget))
       {
          SendMessageToPC(oDM, "This will not work on a DM");
          return;
       }

       if (GetDeity(oTarget) != "delete_bio" && GetDeity(oTarget) != "" && GetLocalInt(oTarget, "delete_bio_try2") != 1)
       {
          SendMessageToPC(oDM, "Player already flagged with '"+ GetDeity(oTarget) +"'. Use wand again on player to force reset.");
          WriteTimestampedLogEntry("Player" + GetPCPlayerName(oTarget) + " ["+GetName(oTarget)+"] already flagged with "+GetDeity(oTarget));
          SetLocalInt(oTarget, "delete_bio_try2", 1);
          return;
       }

        SendMessageToPC(oTarget, "Please do not log in for 1 minute while your bio is removed. You will now be booted.");

        QueueDeleteBio(oDM, oTarget);
   }
   else
   {
       FloatingTextStringOnCreature("Only DM can use this.",oDM, FALSE);
       DestroyObject(oItem);
   }

}
