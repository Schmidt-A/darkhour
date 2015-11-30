//::///////////////////////////////////////////////
//::
//:: DM_Itm_Tgl_Plot
//::
//:: dm_itm_tgl_plot.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is used in the item manipulating
//:: conversation. It will toggle the plot flag
//:: of the item on/off.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Nordavind
//::         On: June 4, 2004
//::
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetLocalObject(oPC, "TARGETED_ITEM");
    int nPlot = GetPlotFlag(oItem);
    int nState;

    if (nPlot == TRUE)
        nState = FALSE;

    if (nPlot == FALSE)
        nState = TRUE;

    SetPlotFlag(oItem, nState);
}
