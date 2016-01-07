void main()
{
    object oEntering = GetEnteringObject();

    if (!GetIsObjectValid(GetItemPossessedBy(oEntering, "RB_DiceBag")))
        CreateItemOnObject("rb_dicebag", oEntering);
}
