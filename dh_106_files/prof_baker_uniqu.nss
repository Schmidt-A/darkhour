/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.3

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

void main()
{
object oPC;
object oItem;
oPC = GetItemActivator();
oItem = GetItemPossessedBy(oPC, "FoodRaw");
if (GetItemPossessedBy(oPC, "FoodRaw")!= OBJECT_INVALID)
   {
   oPC = GetItemActivator();
   if (GetIsObjectValid(oItem))
   DestroyObject(oItem);
   CreateItemOnObject("cookedfood", oPC);
   }else if (GetItemPossessedBy(oPC, "preparedmeats")!= OBJECT_INVALID)
   {
   oItem = GetItemPossessedBy(oPC, "preparedmeats");
   oPC = GetItemActivator();
   if (GetIsObjectValid(oItem))
   DestroyObject(oItem);
   CreateItemOnObject("cookedfood", oPC);
   }else
   {
   oPC = GetItemActivator();
   FloatingTextStringOnCreature("*You have no food to cook*", oPC);
   }

}
