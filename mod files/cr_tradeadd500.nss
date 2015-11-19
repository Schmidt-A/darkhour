void main()
{
object oItem = GetItemActivated();
object oPC = GetItemActivator();
object oCrafting = GetItemPossessedBy(oPC, "craftingitem");
int iAmount = GetLocalInt(oCrafting, "crafting");
SetLocalInt(oCrafting, "crafting", iAmount + 500);
}
