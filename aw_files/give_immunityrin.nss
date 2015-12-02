void main()
{
    object oPC = GetPCSpeaker();
    object oItem;
    oItem = GetItemPossessedBy(oPC,"specialitem");
    if(GetIsObjectValid(oItem)) DestroyObject(oItem);
    oItem = GetItemPossessedBy(oPC,"specialitemf");
    if(GetIsObjectValid(oItem)) DestroyObject(oItem);
    CreateItemOnObject("immunityring",oPC);
}
