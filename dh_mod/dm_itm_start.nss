//::///////////////////////////////////////////////
//::
//:: DM_Itm_Start
//::
//:: dm_itm_Start.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is used in the item manipulating
//:: conversation. This script sets most of the
//:: conversation tokens used in this conversation:
//::
//:: <CUSTOM600001> Name of the item
//:: <CUSTOM600002> Tag of the item
//:: <CUSTOM600003> If the item drops from dead NPCs
//:: <CUSTOM600004> If the item is plot
//:: <CUSTOM600005> If the item is stolen
//:: <CUSTOM600006> The name of the items owner
//:: <CUSTOM600007> The toolset value of the item
//:: <CUSTOM600008> The Brynsaar merchant value
//:: <CUSTOM600009> The toolset item level
//:: <CUSTOM600010> If the item is identified
//:: <CUSTOM600011> Allowed level on Brynsaar
//:: <CUSTOM600012> The ResRef of the item
//:: <CUSTOM600013> If players can drop this item
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Nordavind
//::         On: June 4, 2004
//::
//:://////////////////////////////////////////////


int StartingConditional()
{
    int nResult = TRUE;
    object oItem = GetLocalObject(GetPCSpeaker(), "TARGETED_ITEM");
    object oOwner = GetItemPossessor(oItem);
    string sItemName = GetName(oItem);
    string sItemTag = GetTag(oItem);
    string sItemResRef = GetResRef(oItem);
    string sItemDroppable = "Yes";
    string sItemPCDroppable = "Yes";
    string sItemPlot = "No";
    string sItemStolen = "No";
    string sItemOwner = "None";
    string sIdentified = "No";
    string sItemValue = IntToString(GetGoldPieceValue(oItem));
    string sItemBrynValue = IntToString(FloatToInt(GetGoldPieceValue(oItem)*0.15));
    string sItemLevel;
    string sBrynLevel;

    if (GetDroppableFlag(oItem) == FALSE)
        sItemDroppable = "No";

    if (GetItemCursedFlag(oItem) == TRUE)
        sItemPCDroppable = "No";

    if (GetPlotFlag(oItem) == TRUE)
        sItemPlot = "Yes";

    if (GetStolenFlag(oItem) == TRUE)
        sItemStolen = "Yes";

    if (GetIsObjectValid(oOwner) == TRUE)
        sItemOwner = GetName(oOwner);

    if (GetIdentified(oItem) == TRUE)
        sIdentified = "Yes";

    int nLevel;
    int gp = GetGoldPieceValue(oItem);

    //Set up what the Lvl of an item is
    if (gp<1000)
        nLevel= 1;
    if (gp>1000 && gp<1500)
        nLevel= 2;
    if (gp>1499 && gp<2500)
        nLevel= 3;
    if (gp>2499 && gp<3500)
        nLevel= 4;
    if (gp>3499 && gp<5000)
        nLevel= 5;
    if (gp>4999 && gp<7000)
        nLevel= 6;
    if (gp>6999 && gp<9000)
        nLevel= 7;
    if (gp>8999 && gp<12000)
        nLevel= 8;
    if (gp>11999 && gp<15000)
        nLevel= 9;
    if (gp>14999 && gp<20000)
        nLevel= 10;
    if (gp>19999 && gp<25000)
        nLevel= 11;
    if (gp>24999 && gp<30000)
        nLevel= 12;
    if (gp>29999 && gp<35000)
        nLevel= 13;
    if (gp>34999 && gp<40000)
        nLevel= 14;
    if (gp>39999 && gp<50000)
        nLevel= 15;
    if (gp>49999 && gp<65000)
        nLevel= 16;
    if (gp>64000 && gp<75000)
        nLevel= 17;
    if (gp>74999 && gp<90000)
        nLevel= 18;
    if (gp>89999 && gp>110000)
        nLevel= 19;
    if (gp>109999 && gp<130000)
        nLevel= 20;
    if (gp>129999 && gp<250000)
        nLevel= 21;
    if (gp>249999 && gp<500000)
        nLevel= 22;
    if (gp>499999 && gp<750000)
        nLevel= 23;
    if (gp>749999 && gp<1000000)
        nLevel= 24;
    if (gp>999999 && gp<1200000)
        nLevel = 25;
    if (gp>1999999 && gp<1400000)
        nLevel = 26;
    if (gp>1399999 && gp<1600000)
        nLevel = 27;
    if (gp>1599999 && gp<1800000)
        nLevel = 28;
    if (gp>1799999 && gp<2000000)
        nLevel = 29;
    if (gp>1999999 && gp<2200000)
        nLevel = 30;
    if (gp>2199999 && gp<2400000)
        nLevel = 31;
    if (gp>2399999 && gp<2600000)
        nLevel = 32;
    if (gp>2599999 && gp<2800000)
        nLevel = 33;
    if (gp>2799999 && gp<3000000)
        nLevel = 34;
    if (gp>2999999 && gp<3200000)
        nLevel = 35;
    if (gp>3199999 && gp<3400000)
        nLevel = 36;
    if (gp>3399999 && gp<3600000)
        nLevel = 37;
    if (gp>3599999 && gp<3800000)
        nLevel = 38;
    if (gp>3799999 && gp<4000000)
        nLevel = 39;
    if (gp>3999999)
        nLevel = 40;

    sItemLevel = IntToString(nLevel);
    sBrynLevel = IntToString(nLevel-4);
    if(nLevel < 5)
        sBrynLevel = "1";

    if (GetObjectType(oItem) != OBJECT_TYPE_ITEM)
        nResult = FALSE;

    SetCustomToken(600001, sItemName);
    SetCustomToken(600002, sItemTag);
    SetCustomToken(600003, sItemDroppable);
    SetCustomToken(600004, sItemPlot);
    SetCustomToken(600005, sItemStolen);
    SetCustomToken(600006, sItemOwner);
    SetCustomToken(600007, sItemValue);
    SetCustomToken(600008, sItemBrynValue);
    SetCustomToken(600009, sItemLevel);
    SetCustomToken(600010, sIdentified);
    SetCustomToken(600011, sBrynLevel);
    SetCustomToken(600012, sItemResRef);
    SetCustomToken(600013, sItemPCDroppable);


    return nResult;
}
