void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
if (GetIsDM(oPC)) return;
if(GetItemPossessedBy(oPC, "CraftingNecklace") == OBJECT_INVALID)
    {
    object oAmmy = CreateItemOnObject("ultimatecrafting", oPC);
    GiveGoldToCreature(oPC, 100000);
    }
}
