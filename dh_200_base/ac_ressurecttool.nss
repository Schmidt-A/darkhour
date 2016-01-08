#include "x2_inc_switches"
#include "raiseinclude"
void main()
{
int nEvent = GetUserDefinedItemEventNumber();
if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();
    int nTries = GetLocalInt(oTarget, "raiseattempts");
    if(GetIsPC(oTarget) == FALSE)
        {
        SendMessageToPC(oPC, "You may only use this on a dead or dying player.");
        return;
        }
    if(GetIsDead(oTarget) != TRUE)
        {
        SendMessageToPC(oPC, "You may only use this on a dead or dying player.");
        return;
        }
    if(nTries >= 3)
        {
        SendMessageToPC(oPC, "Three attempts have already been made to raise this player. They are now beyond your skill.");
        return;
        }
    SetLocalInt(oTarget, "raiseattempts", nTries + 1);
    location oLoc = GetLocation(oTarget);
    int nSkill = GetSkillRank(SKILL_HEAL, oPC, FALSE);
    int nRand = d20();
    int nRoll = nSkill + nRand;
    SendMessageToPC(oPC, "You attempt to heal the severe wounds on " + GetName(oTarget) + ".");
    FloatingTextStringOnCreature(IntToString(nRand) + " + " + IntToString(nSkill) + " = " + IntToString(nRoll) + " vs DC:28", oPC, FALSE);
    if(nRoll >= 28)
        {
        SendMessageToPC(oPC, "You have succeeded in healing " + GetName(oTarget));
        Raise(oTarget);
        SetLocalInt(oTarget, "raiseattempts", 0);
        }else
            {
            SendMessageToPC(oPC, "You have failed to heal " + GetName(oTarget));
            }
    }
}
