//------------------------------------------------------------------
//             Spiffy Fox Persistent Storage system v2
//
// sfps_inc       include file
//
// 11/09/2009     Malishara: include file created
//------------------------------------------------------------------


void MarkContents(object oContainer)
{   object oItem = GetFirstItemInInventory(oContainer);

    while (GetIsObjectValid(oItem))
    { SetLocalInt(oItem, "iSFPS_Skip", TRUE);
      oItem = GetNextItemInInventory(oContainer);
    }
}

void ScanInventory(object oContainer)
{   int iCount = 0;
    object oItem = GetFirstItemInInventory(oContainer);

    while ((iCount < 201) && (GetIsObjectValid(oItem)))
    { DeleteLocalInt(oItem, "iSFPS_Skip");
      oItem = GetNextItemInInventory(oContainer);
      iCount++;
    }

    iCount = 0;
    oItem = GetFirstItemInInventory(oContainer);

    while ((iCount < 201) && (GetIsObjectValid(oItem)))
    { if (GetHasInventory(oItem))
      { MarkContents(oItem); }
      oItem = GetNextItemInInventory(oContainer);
      iCount++;
    }
}

int WritePS(object oContainer, string sTag, string sPrefix = "PS_")
{   string sOldDB = GetLocalString(oContainer, "sSFPS_OldDatabase");
    if (sOldDB == "")
    { sOldDB = sPrefix + sTag; }

    ScanInventory(oContainer);
    DestroyCampaignDatabase(sOldDB);
    DeleteLocalString(oContainer, "sSFPS_OldDatabase");

    object oItem = GetFirstItemInInventory(oContainer);
    int iSkip = GetLocalInt(oItem, "iSFPS_Skip");

    int iCount = 0;
    int iLoop = 0;

    while ((iCount < 201) && (GetIsObjectValid(oItem)))
    { if (!iSkip)
      { StoreCampaignObject(sPrefix + sTag, "PS_item_" + IntToString(iLoop), oItem);
        iLoop++;
      }
      oItem = GetNextItemInInventory(oContainer);
      iSkip = GetLocalInt(oItem, "iSFPS_Skip");
      iCount++;
    }

    SetCampaignInt(sPrefix + sTag, "PS_iCount", iLoop);
    SetCampaignInt(sPrefix + sTag, "PS_iVersion", 2);
    return iCount;
}

int ReadPS(object oContainer, string sTag, string sPrefix = "PS_", int iVersion = 2)
{   if (GetLocalInt(oContainer, "iSFPS_Loaded") == TRUE)
    { return TRUE; }

    string sRecord;
    int iCount = 0;
    object oItem = OBJECT_SELF;
    int iLoop = GetCampaignInt(sPrefix + sTag, "PS_iCount");

    switch (iVersion)
    {  case 2:  sRecord = "PS_item_";

                while ((iLoop >= 1) && (GetIsObjectValid(oItem)))
                { iLoop--;
                  oItem = RetrieveCampaignObject(sPrefix + sTag, sRecord + IntToString(iLoop), GetLocation(oContainer), oContainer);
                  if (GetIsObjectValid(oItem))
                  { iCount++; }
                }

                break;
      default:  sRecord = "PS_in_" + sTag + "_item_";

                iLoop = 50;
                while (iLoop >= 0)
                { oItem = RetrieveCampaignObject(sPrefix + sTag, sRecord + IntToString(iLoop), GetLocation(oContainer), oContainer);
                  if (GetIsObjectValid(oItem))
                  { iCount++; }
                  iLoop--;
                }

                SetLocalString(oContainer, "sSFPS_OldDatabase", sPrefix + sTag);
                break;
    }

    SetLocalInt(oContainer, "iSFPS_Loaded", TRUE);
    return iCount;
}


