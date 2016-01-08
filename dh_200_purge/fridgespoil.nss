void main()
{
int iTime = GetCampaignInt(GetName(GetModule()), "fridgetimeleft", OBJECT_SELF);
if(iTime > 0)
    {
    iTime -= 6;
    SetCampaignInt(GetName(GetModule()), "fridgetimeleft", iTime, OBJECT_SELF);
    }else
        {
        SetCampaignInt(GetName(GetModule()), "fridgetimeleft", 0, OBJECT_SELF);
        int nCharges;
        int nNumberSpoiled = 0;
        object oFood = GetFirstItemInInventory(OBJECT_SELF);
        while (GetIsObjectValid(oFood))
        {
            if (GetTag(oFood) == "Food")
          {
                nCharges = GetItemCharges(oFood);
                if (nCharges <= 1)
                {
                    if (GetName(oFood) != "Purified Food")
                    {
                        nNumberSpoiled += 1;
            }
                    DestroyObject(oFood);
                }
                else
                {
                    SetItemCharges(oFood,(nCharges - 1));
                }
            }
            else if (GetTag(oFood) == "SpoiledFood")
            {
                nCharges = GetItemCharges(oFood);
               if (nCharges <= 1)
               {
                       DestroyObject(oFood);
               }
               else
               {
                   SetItemCharges(oFood,(nCharges - 1));
               }
            }
            oFood = GetNextItemInInventory(OBJECT_SELF);
        }
        while (nNumberSpoiled > 0)
        {
            CreateItemOnObject("spoiledfood", OBJECT_SELF);
         nNumberSpoiled -= 1;
        }
    }
}
