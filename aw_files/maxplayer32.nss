#include "inc_bs_module"
#include "aw_include"
void main()
{
/// Sets the Max Players allowed used in the reserved GM/ winged gods slots to 32///
object oGM = GetPCSpeaker();
if (GetIsGMNormalChar(oGM) == TRUE)
 {
  SetLocalInt(GetModule(), "MaxPlayers", 32);
  SQLExecDirect("UPDATE Settings SET value='32' WHERE name='MAXPLAYERS'");
 }
else
{/*Do nothing*/}
}
