void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetItemPossessedBy(oPC, "rotd_wood");

    if(oItem != OBJECT_INVALID)
    {
        DestroyObject(oItem);
        CreateItemOnObject("barricadesupplie", oPC);
    }
}

