 //::///////////////////////////////////////////////
//:: Name: Printers desk make copie
//:: FileName: td_quill_copy5
//:://////////////////////////////////////////////
/*
    create a copie of the players book in the
    printers desk
*/
//:://////////////////////////////////////////////
//:: Created By: Thales Darkshine (Russ Henson)
//:: Created On: 07-20-2008
//:://////////////////////////////////////////////
#include "td_quill_inc"
void main()
{
    object oPC = GetPCSpeaker();
    object oCrafting = GetItemPossessedBy(oPC,"craftingitem");
    int iAmount = GetLocalInt(oCrafting, "crafting");
    if(iAmount < 50)
        {
        SendMessageToPC(oPC, "You do not possess enough crafting points.");
        return;
        }
    object oOriginalBook = GetFirstItemInInventory(OBJECT_SELF);
    //search desks inventory for a formerly blank book
    if(oOriginalBook != OBJECT_INVALID)
    {
        string sResRef = GetResRef(oOriginalBook);
        string sBookName = GetName(oOriginalBook);
        string sBookstory = GetDescription(oOriginalBook);
        if(sResRef == "td_it_blankbook" && sBookName != "Blank Book")
            {
            //creare a copy of the book in the desk.
            SetDescription(CopyItemAndModify(oOriginalBook,ITEM_APPR_TYPE_SIMPLE_MODEL,0,2,TRUE),sBookstory,TRUE);
            }
    }
    SetLocalInt(oCrafting, "crafting", iAmount - 50);
}
