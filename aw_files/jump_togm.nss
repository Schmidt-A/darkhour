#include "inc_bs_module"
#include "aw_include"
void main()
{
object oGm = GetPCSpeaker();
object oMyTarget = GetLocalObject(oGm,"MyTarget");
if(GetIsObjectValid(oMyTarget))
   {
   if (GetLocalInt(oMyTarget,"pause") == 1)
   {
   FreezeUnfreeze(oMyTarget,oGm);
   DelayCommand(7.0,FreezeUnfreeze(oMyTarget,oGm));
   }
   location MyLocation = GetLocation(oGm);
   AssignCommand(oMyTarget,ClearAllActions(TRUE));
   AssignCommand(oMyTarget,MoveMeToLocation(MyLocation));
   }
   else FloatingTextStringOnCreature("Player not found",oGm,FALSE);
   DelayCommand(20.0, DeleteLocalObject(oGm,"MyTarget"));
}
