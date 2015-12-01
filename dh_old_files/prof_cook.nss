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
   CreateItemOnObject("exquisitefood", oPC);
   }else if (GetItemPossessedBy(oPC, "preparedmeats")!= OBJECT_INVALID)
   {
   oItem = GetItemPossessedBy(oPC, "preparedmeats");
   oPC = GetItemActivator();
   if (GetIsObjectValid(oItem))
   DestroyObject(oItem);
   CreateItemOnObject("exquisitefood", oPC);
   }else
   {
   oPC = GetItemActivator();
   FloatingTextStringOnCreature("*You have no food to cook*", oPC);
   }

}
