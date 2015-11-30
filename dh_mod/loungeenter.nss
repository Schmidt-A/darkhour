void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
object oAmmy = GetItemPossessedBy(oPC, "CraftingNecklace");
DestroyObject(oAmmy);
}
