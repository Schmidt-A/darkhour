/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.3

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

//Put this on action taken in the conversation editor
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

RewardPartyXP(10, oPC, FALSE);

CreateItemOnObject("professionbook", oPC);
CreateItemOnObject("nw_it_book002", oPC);
CreateItemOnObject("nw_it_book001", oPC);
CreateItemOnObject("nw_it_book003", oPC);
CreateItemOnObject("nw_it_book004", oPC);
CreateItemOnObject("nw_it_book005", oPC);
CreateItemOnObject("nw_it_book007", oPC);
CreateItemOnObject("nw_it_book006", oPC);
CreateItemOnObject("nw_it_book008", oPC);
CreateItemOnObject("nw_it_book009", oPC);
CreateItemOnObject("nw_it_book0010", oPC);
CreateItemOnObject("nw_it_book0011", oPC);
CreateItemOnObject("nw_it_book0012", oPC);
CreateItemOnObject("nw_it_book0013", oPC);
CreateItemOnObject("nw_it_book0015", oPC);
CreateItemOnObject("nw_it_book0014", oPC);
CreateItemOnObject("zn_book10", oPC);
CreateItemOnObject("zn_book09", oPC);
CreateItemOnObject("zn_book08", oPC);
CreateItemOnObject("zn_book07", oPC);
CreateItemOnObject("zn_book02", oPC);
CreateItemOnObject("zn_book01", oPC);
CreateItemOnObject("zn_book04", oPC);

}

