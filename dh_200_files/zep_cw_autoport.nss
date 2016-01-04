//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Attempts to automatically set the portrait to
    match the appearance
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
int nApp = GetLocalInt(OBJECT_SELF, "CW_APP");
int nPort = AppToPort(nApp);

ActionPauseConversation();
SetPortraitId(oTarget, nPort);
SetPortraitId(OBJECT_SELF, nPort);
DelayCommand(0.3, ActionResumeConversation());
}
