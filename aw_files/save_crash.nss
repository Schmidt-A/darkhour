#include "nw_i0_generic"
#include "inc_bs_module"
void main()
{
object oDM = GetItemActivator();
object oDM2 = GetPCSpeaker();
if (GetIsDM(oDM) || GetIsObjectValid(oDM2))
 {
   ExportAllCharacters();
   FloatingTextStringOnCreature("The server will reload ", oDM);
   BroadcastMessage("<c¾>SERVER: <cý´>All characters have been saved!</c>");
   BroadcastMessage("<c¾>SERVER: <cý´>Server will reload in 30 seconds!</c>");
   DelayCommand(15.0,StartNewModule(GetModuleName()));
 }
   else FloatingTextStringOnCreature("Only Dm can use this Power!", oDM);
}
