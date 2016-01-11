void main()
{
    object oPC = GetLastUsedBy();
    object oInv = GetFirstItemInInventory(OBJECT_SELF);
    string sTag = GetTag(oInv);
    if(oInv != OBJECT_INVALID)
        {
        while(GetIsObjectValid(oInv) == TRUE)
            {
            if(sTag != "ZEP_BABYHOLDABLE")
                {
                CopyItem(oInv, oPC, TRUE);
                DestroyObject(oInv);
                }
                else
                {
                string sName = GetName(oInv);
                FloatingTextStringOnCreature(sName + " begins to sleep quietly.", oPC, FALSE);
                }
            oInv = GetNextItemInInventory(OBJECT_SELF);
            sTag = GetTag(oInv);
            }
        }
}
