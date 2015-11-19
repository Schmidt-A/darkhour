void main()
{
    object oItem = GetItemActivated();
    object oPC = GetItemActivator();

    if (GetTag(oItem) == "Waybread")
    {
        CreateItemOnObject("pieceofwaybread",oPC);
    }
}
