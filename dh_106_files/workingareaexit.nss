void main()
{
object oPC = GetExitingObject();
if (!GetIsPC(oPC)) return;
object oAmmy = GetItemPossessedBy(oPC, "CraftingNecklace");
DestroyObject(oAmmy);
}
