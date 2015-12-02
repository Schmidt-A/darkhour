#include "inc_bs_module"


void main()
{
    string sGateTag = GetTag(OBJECT_SELF);
    object oClicker = GetClickingObject();
    int nTeam = GetPlayerTeam(oClicker);

    if ((sGateTag == "FlorinGate" && nTeam == TEAM_GOOD)
        || (sGateTag == "GuilderGate" && nTeam == TEAM_EVIL))
    {
        SetLocked(OBJECT_SELF, FALSE);
        if (GetIsPC(oClicker))
        {
            SendMessageToPC(oClicker, "You unlock the gate.");
            ActionOpenDoor(OBJECT_SELF);
        }
    }
    else
    {
        if (GetIsPC(oClicker))
        {
            SendMessageToPC(oClicker, "You must either pick or bash the enemy lock.");
        }
    }
}
