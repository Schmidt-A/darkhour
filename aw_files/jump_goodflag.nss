#include "inc_bs_module"
#include "aw_include"
void main()
{
object oGoodFlagHolder = GetLocalObject(GetModule(), "oHasFlag_1"); //GOOD
//object oEvilFlagHolder = GetLocalObject(GetModule(), "oHasFlag_2"); //EVIL
object oGm = GetPCSpeaker();
    if ( GetIsGM(oGm) || GetIsAdmin(oGm)) //Only GM with deity can use it, until they are admins ...
   {
    AssignCommand(oGm,JumpToLocation(GetLocation(oGoodFlagHolder)));
   }
else {
     FloatingTextStringOnCreature("You cannot, please do not abuse powers on your normal char!",oGm,FALSE);
     }
}
