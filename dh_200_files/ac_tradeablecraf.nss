void main()
{
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    string sItemTag = GetTag(oItem);

    object oCrafting = GetItemPossessedBy(oPC, "craftingitem");
    int iAmount = GetLocalInt(oCrafting, "crafting");
    int iGained = StringToInt(GetStringRight(sItemTag, 3));

    SetLocalInt(oCrafting, "crafting", iAmount + 100);
    iAmount = GetLocalInt(oCrafting, "crafting");
    SendMessageToPC(oPC, "You now have " + IntToString(iAmount) + " crafting points.");
}
