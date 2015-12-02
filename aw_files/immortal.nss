#include "aw_include"
void main()
{
object oGm = GetPCSpeaker();
if ( GetIsGM(oGm) || GetIsAdmin(oGm) || GetGMRank(oGm) >= 3) //Only GM with deity can use it, until they are admins ...  or seniors
   {
   SetImmortal(oGm,TRUE);
   FloatingTextStringOnCreature("You are Immortal now!",oGm,FALSE);
   }
else {
     FloatingTextStringOnCreature("You cannot, please do not abuse powers on your normal char!",oGm,FALSE);
     }
}
