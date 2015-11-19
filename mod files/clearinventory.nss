void main()
{
    object oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
        oItem = GetNextItemInInventory();
    }
}
