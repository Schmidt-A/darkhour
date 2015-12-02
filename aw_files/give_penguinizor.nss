const int nMVMS = 3;

void main()
{
    object oPC = GetPCSpeaker();
    int nDestroyed = 0;

    object oItem = GetFirstItemInInventory(oPC);

    while (oItem != OBJECT_INVALID && nDestroyed < nMVMS)
    {

        if (GetTag(oItem) == "specialitem" || GetTag(oItem) == "specialitemf")
        {
            DestroyObject(oItem);
            nDestroyed++;
        }

        oItem = GetNextItemInInventory(oPC);
    }

    CreateItemOnObject("penguinizor",oPC);
}
