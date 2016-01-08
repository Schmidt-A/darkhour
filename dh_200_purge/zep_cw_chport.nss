//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Set portrait to be changed
*/
//:://////////////////////////////////////////////
//:: Created By:   420
//:: Created On:   April 20, 2009
//:://////////////////////////////////////////////
#include "zep_cw_inc"

void main()
{
struct CW2da data = Get2daData();
object oTarget = data.target;
int nApp = GetAppearanceType(oTarget);
int nTail = GetCreatureTailType(oTarget);

if(Get2DAString("appearance", "PORTRAIT", nApp) == "")
    {
    nApp = TailToApp(nTail);
    }

//Fix for Invisible Dragon appearances
else if(nApp >= 569 &&
        nApp <= 588)
        {
        nApp = TailToApp(nTail);
        }
else if(nApp >= 2616 &&
        nApp <= 2635)
        {
        nApp = TailToApp(nTail);
        }

SetLocalInt(OBJECT_SELF, "CW_APP", nApp);
SetLocalString(OBJECT_SELF, "CW_Change", "portrait");
ExecuteScript("zep_cw_con_tlist", OBJECT_SELF);
}
