void main()
{
    object oItem = GetModuleItemAcquired();

    if (GetIsPC(GetItemPossessor(oItem)))
    {
        SetLocalInt(oItem, "PCItem", 1);
    }
}
