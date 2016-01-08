void main()
{
    object oItem = GetInventoryDisturbItem();
    object oPC = GetLastDisturbed();
    int nAmount = GetWeight(oItem) / 10;
    DestroyObject(oItem);
    GiveGoldToCreature(oPC,nAmount);
}
