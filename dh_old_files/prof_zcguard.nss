#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetFirstItemInInventory(oPC);

while (GetIsObjectValid(oItem))
   {
   if (GetTag(oItem)=="professionpc") DestroyObject(oItem);

   oItem = GetNextItemInInventory(oPC);
   }

GiveXPToCreatureDH(oPC, 10, "XP_PROFESSION");

CreateItemOnObject("kalaramguardkey", oPC);
CreateItemOnObject("barricadecreator", oPC);
CreateItemOnObject("barricadesupplies", oPC);
CreateItemOnObject("professionkgu001", oPC);
CreateItemOnObject("zholancityguarda", oPC);
}

