#include "inc_bs_module"
void main()
{
object oGm = GetPCSpeaker();
object oMyTarget = GetLocalObject(oGm,"MyTarget");
if(GetIsObjectValid(oMyTarget))
   {

   location MyLocation = GetLocation(oMyTarget);
   AssignCommand(oGm,ClearAllActions(TRUE));
   AssignCommand(oGm,MoveMeToLocation(MyLocation));
   }
   else FloatingTextStringOnCreature("Player not found",oGm,FALSE);
   DelayCommand(20.0, DeleteLocalObject(oGm,"MyTarget"));
}
