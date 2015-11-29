void main()
{
int iCount = 0;
string sIPS = GetStringRight(GetTag(OBJECT_SELF), 5);
object oItem;
if(GetFirstItemInInventory() == OBJECT_INVALID && GetLocalInt(OBJECT_SELF, "BeenChecked") != 1)
    {
        while(iCount < 51)
        {
            oItem = RetrieveCampaignObject("Annakolia_PS_"+GetTag(OBJECT_SELF), "PS_in_"+GetTag(OBJECT_SELF)+"_item_"+IntToString(iCount), GetLocation(OBJECT_SELF), OBJECT_SELF);
            iCount++;
        }
    }
SetLocalInt(OBJECT_SELF, "BeenChecked", 1);
}
