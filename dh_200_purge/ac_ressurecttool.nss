#include "_incl_pc_data"
#include "raiseinclude"
#include "dmfi_dmw_inc"

int GetDCModifier(object oTarget)
{
    int iHP = GetCurrentHitPoints(oTarget);
    int iModifier = (0 - iHP) - 10;
    return iModifier / 2;
}

void main()
{
    object oPC      = GetItemActivator();
    object oItem    = GetItemActivated();
    object oTarget  = GetItemActivatedTarget();

    string sHealerName  = PCDGetFirstName(oPC);
    string sDeadName    = PCDGetFirstName(oTarget);

    int bDeadTooLong    = GetLocalInt(oTarget, "bDeadTooLong");
    int bButchered      = GetLocalInt(oTarget, "bButchered");

    string sVarName     = "bRaiseAttempt" + sHealerName;
    int iRaiseAttempts  = GetLocalInt(oTarget, "iRaiseAttempts");
    int bTried          = GetLocalInt(oTarget, sVarName);

    if(!GetIsPC(oTarget) || !GetIsDead(oTarget))
    {
        SendMessageToPC(oPC, "You can only resusciate a dead player.");
        return;
    }
    if(bDeadTooLong)
    {
        SendMessageToPC(oPC, "The poor soul before you has been dead for too " +
            "long to be ressucitated by mortal means.");
        return;
    }
    if(bButchered)
    {
        SendMessageToPC(oPC, "Someone accidentally hurried " + sDeadName + "'s death " +
            "in their attempt to help. They are beyond " + sHealerName + "'s abilities.");
        return;
    }
    if(bTried)
    {
        SendMessageToPC(oPC, sHealerName + " has already tried to bring back " +
            "the fallen individual before them.");
        return;
    }

    SetLocalInt(oTarget, sVarName, TRUE);
    int iRoll = d20();
    string sMsg;

    // Critical Success
    if(iRoll == 20)
    {
        sMsg = "In a moment of absolute clarity, " + sHealerName + " manages " +
            "to bind the worst of " + sDeadName + "'s injuries, allowing them " +
            "to regain their feet with renewed tenacity.";
        SendMessageToPC(oPC, sMsg);
        Raise(oTarget);
    }
    // Critical Failure
    else if(iRoll == 1)
    {
        sMsg = "The resolve of " + sHealerName + "'s soul wavers and their " +
            "hands tremble while attempting to resuscitate " + sDeadName + ". " +
            sDeadName + " gasps suddenly before letting the breath out in a " +
            "sickening rattle. It dawns on " + sHealerName + " that not only " +
            "have they failed, but they've ensured their fallen companion's death.";
        SendMessageToPC(oPC, sMsg);
        SetLocalInt(oTarget, "bButchered", TRUE);
    }
    else
    {
        int iDC = 18 + GetDCModifier(oTarget);
        int iSkill = GetSkillRank(SKILL_HEAL, oPC, FALSE);
        int iResult = iRoll + iSkill;

        sMsg = ColorText("Heal Check, Roll 1d20: " + IntToString(iRoll) +
            " + Modifier: " + IntToString(iSkill) +
            " = Total: " + IntToString(iResult) +
            " vs DC:" + IntToString(iDC), "cyan");
        SendMessageToPC(oPC, sMsg);

        if(iResult > iDC)
        {
            sMsg = sHealerName + "'s vigorous soul is able to call out to " +
                sDeadName + "'s and convinces it to return to its battered " +
                "body. With its return, " + sHealerName + "is able to bring " +
                sDeadName + " back to consciousness.";
                SendMessageToPC(oPC, sMsg);
                Raise(oTarget);
        }
        else
        {
            sMsg = sHealerName + " is unsuccessful in attempting to resuscitate " +
                sDeadName + ".";
            SendMessageToPC(oPC, sMsg);
        }
    }
}
