#include "inc_bs_module"
#include "aw_include"
void main()
{
/// Sets the Max Players allowed used in the reserved GM/ winged gods slots to 36///
object oGM = GetPCSpeaker();
if (GetIsGMNormalChar(oGM) == TRUE)
 {
  SetLocalInt(GetModule(), "MaxPlayers", 36);
  SQLExecDirect("UPDATE Settings SET value='36' WHERE name='MAXPLAYERS'");
 }
else
{/*Do nothing*/}
}
