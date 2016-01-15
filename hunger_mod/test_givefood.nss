void main()
{
    object oPC = GetLastUsedBy();
    // if tag(0,4) = food
    object oFood = GetItemPossessedBy(GetObjectByTag("fc_all"), "food_apple");
    CopyItem(oFood, oPC, TRUE);
}
