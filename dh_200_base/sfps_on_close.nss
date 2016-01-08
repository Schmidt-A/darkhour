void main()
{
object oItem = GetFirstItemInInventory();
object oPC = GetLastClosedBy();
int iCount = 0;
string sTemp;
DestroyCampaignDatabase("Annakolia_PS_"+GetTag(OBJECT_SELF));
while(iCount < 51)
    {
        if(GetStringLength(GetTag(OBJECT_SELF)) > 19)
            {
                FloatingTextStringOnCreature("ERROR: Storage container tag too long! Items not stored!", oPC, FALSE);
            }
        else if(GetBaseItemType(oItem) == BASE_ITEM_LARGEBOX || GetBaseItemType(oItem) == 306)
            {
                sTemp = GetResRef(oItem);
                oItem = CreateItemOnObject(sTemp, GetObjectByTag("Fox_IP_chest"));
                StoreCampaignObject("Annakolia_PS_"+GetTag(OBJECT_SELF), "PS_in_"+GetTag(OBJECT_SELF)+"_item_"+IntToString(iCount), oItem);
                DestroyObject(oItem, 0.1);
                oItem = GetNextItemInInventory();
                iCount++;
            }
        else
            {
                StoreCampaignObject("Annakolia_PS_"+GetTag(OBJECT_SELF), "PS_in_"+GetTag(OBJECT_SELF)+"_item_"+IntToString(iCount), oItem);
                oItem = GetNextItemInInventory();
                iCount++;
            }
    }
if(oItem != OBJECT_INVALID)
    {
        FloatingTextStringOnCreature("WARNING: There are too many items to store persistantly! Please remove some.", oPC, FALSE);
    }
}
