void main()
{
    object oPC = GetLastDisturbed();
    object oItem = GetInventoryDisturbItem();
    ActionGiveItem(oItem,oPC);
}
