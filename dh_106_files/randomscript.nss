void main()
{
    int nEmpty = TRUE;
    int nNumber = 1;
    int nChoice = 0;
    object oZomb = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,nNumber);
    while (oZomb != OBJECT_INVALID)
    {
        if ((GetStringLeft(GetTag(oZomb),9) == "ZN_ZOMBIE") && (GetTag(oZomb) != "ZN_ZOMBIEB"))
        {
            if (nChoice == 0)
            {
                nChoice = nNumber;
            }
            else if (Random(5) == 1)
            {
                nChoice = nNumber;
            }
        }
        if ((GetIsPC(oZomb) == TRUE) && (GetIsDM(oZomb) == FALSE))
        {
            nEmpty = FALSE;
        }
        nNumber += 1;
        oZomb = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,nNumber);
    }
    if ((nEmpty == TRUE) && (nChoice > 0))
    {
        oZomb = GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,nChoice);
        object oClear = GetItemInSlot(INVENTORY_SLOT_CHEST,oZomb);
        SetDroppableFlag(oClear,FALSE);
        DestroyObject(oZomb);
        DelayCommand(18.0,ExecuteScript("randomscript",OBJECT_SELF));
    }
    else
    {
        DelayCommand(6.0,ExecuteScript("randomscript",OBJECT_SELF));
    }
}
