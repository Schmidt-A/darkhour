//::///////////////////////////////////////////////
//:: Name: printers desk on close event
//:: FileName: td_quill_plc_oc
//:://////////////////////////////////////////////
/*
    checks to see if there is an object in the desk when
    closed, it there is a valid object it begins the
    conversation with the pc.
*/
//:://////////////////////////////////////////////
//:: Created By: ChronusH
//:: Created On: 07-20-2008
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetLastUsedBy();
    object oInv = GetFirstItemInInventory(OBJECT_SELF);
    int iBook = 0;
    string sTag = GetTag(oInv);
    if(oInv != OBJECT_INVALID)
        {
        while(GetIsObjectValid(oInv) == TRUE)
            {
            if(sTag == "td_it_blankbook")
                {
                iBook = 1;
                }
                else
                    {
                    CopyItem(oInv, oPC, TRUE);
                    DestroyObject(oInv);
                    }
            oInv = GetNextItemInInventory(OBJECT_SELF);
            sTag = GetTag(oInv);
            }
        if(iBook != 0)
            {
            ActionStartConversation(GetLastUsedBy());
            }
        }
}
