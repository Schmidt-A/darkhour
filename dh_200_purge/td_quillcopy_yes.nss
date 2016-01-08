//::///////////////////////////////////////////////
//:: Name:
//:: FileName:
//:://////////////////////////////////////////////
/*
    converstation check to see if thier is a valid book to copy
*/
//:://////////////////////////////////////////////
//:: Created By: Thales Darkshine (Russ Henson)
//:: Created On: 07-20-2008
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oOriginalBook = GetFirstItemInInventory(OBJECT_SELF);
    //search desks inventory for a formerly blank book
    string sResRef = GetResRef(oOriginalBook);
    string sBookName = GetName(oOriginalBook);
    if(sResRef == "td_it_blankbook" && sBookName != "Blank Book")
        {
        return TRUE;
        }
    else return FALSE;
}
