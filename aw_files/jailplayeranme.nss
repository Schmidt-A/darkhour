#include "criminalrecorder"
#include "inc_bs_module"
#include "aw_include"
void main()
{
object oDm = GetItemActivator();
object oPlayer = GetItemActivatedTarget() ;
object oItem = GetItemActivated();
object oJail = GetObjectByTag("antiworld_jail");
location lJail = GetLocation(oJail);
int nTeam = GetPlayerTeam(oPlayer);

if(GetIsDM(oDm) || GetIsGMNormalChar(oDm))
         {
         AssignCommand(oPlayer, MoveMeToLocation(lJail));
         FloatingTextStringOnCreature(GetPCPlayerName(oPlayer)+" ["+GetName(oPlayer)+"] Moved to Antiworld Pen.",oDm, FALSE);
         //BroadcastMessage(GetName(oDm)+" Castigated "+GetPCPlayerName(oPlayer)+" ["+GetName(oPlayer)+"] into Antiworld Pen!");
         AssignCommand( oDm, MoveMeToLocation(lJail));
            if (!GetIsGM(oPlayer)) CriminalRecordEntry(oPlayer, oDm, "", 0);
         }
else
   {
   FloatingTextStringOnCreature("Only Dm  can use this.",oDm, FALSE);
   DestroyObject(oItem);
   }
}
