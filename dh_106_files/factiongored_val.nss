/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.3

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("goredcape", oPC);

object oItem;
oItem = GetFirstItemInInventory(oPC);

while (GetIsObjectValid(oItem))
   {
   if (GetTag(oItem)=="tradecape") DestroyObject(oItem);

   oItem = GetNextItemInInventory(oPC);
   }
   oItem = GetFirstItemInInventory(oPC);

while (GetIsObjectValid(oItem))
   {
   if (GetTag(oItem)=="goredo") DestroyObject(oItem);

   oItem = GetNextItemInInventory(oPC);
   }

oItem = GetFirstItemInInventory(oPC);

while (GetIsObjectValid(oItem))
   {
   if (GetTag(oItem)=="ironcape") DestroyObject(oItem);

   oItem = GetNextItemInInventory(oPC);
   }

}
