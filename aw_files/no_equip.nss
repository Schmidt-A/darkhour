int StartingConditional()
{
    object oPlayer = GetPCSpeaker();
    object oItem;
    int iResult;
    int nCount;
 for ( nCount = 0; nCount < NUM_INVENTORY_SLOTS; nCount++ )
    {
        oItem = GetItemInSlot(nCount,oPlayer);
        if ( GetIsObjectValid(oItem) )
        {
           return FALSE;
        }
    }

    return TRUE;
}
