#include"stx_inc_craft"
void main()
{
object oPC = GetPCSpeaker();
object oItem = GetLocalObject(oPC, "STX_CR_ITEM");
//AssignCommand(oPC,ActionUnequipItem(oItem));
string sNewName =  GetLocalString(oPC, "NewItemName");
if ( sNewName != "")
SetName(oItem,sNewName);
}
