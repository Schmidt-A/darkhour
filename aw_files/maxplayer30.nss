#include "inc_bs_module"
#include "aw_include"
void main()
{
/// Sets the Max Players allowed used in the reserved GM/ winged gods slots to 30///
object oGM = GetPCSpeaker();
if (GetIsGMNormalChar(oGM) == TRUE)
 {
  SetLocalInt(GetModule(), "MaxPlayers", 30);
  SQLExecDirect("UPDATE Settings SET value='30' WHERE name='MAXPLAYERS'");
 }
else
{/*Do nothing*/}
}
