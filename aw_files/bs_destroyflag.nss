#include "inc_bs_module"

void main()
{
    int nFlagTeam = GetLocalInt(OBJECT_SELF, "nTeam");
    object oModule = GetModule();
    if (GetLocalObject(oModule, "oHasFlag_" + IntToString(nFlagTeam)) == OBJECT_SELF)
    {
        FlagDestroyed(nFlagTeam);
        object oDestroyer = GetLastDamager();

        if (nFlagTeam == GetPlayerTeam(oDestroyer))
        {
            AddPlayerScore(oDestroyer, 1);
        }

        //cap the flag if it is our flag that is recovered
        object oPC = GetLocalObject(oModule, "oHasFlag_" + IntToString(3-nFlagTeam));
        if (GetIsObjectValid(oPC) && GetIsPC(oPC))
        {
            int nPCTeam = GetPlayerTeam(oPC);
            float fDist = GetDistanceBetween(oPC, GetObjectByTag(IntToString(GetLocalInt(oModule, "nRound")) + "_Flagholder_" + IntToString(nPCTeam)));
            //SendMessageToAllDMs("DEBUG: bs_destroyflag: auto-capture by " + GetName(oPC) + " is " + FloatToString(fDist) + " meters from stand.");
            if ((fDist > 0.0) && (fDist < 4.0) && (nPCTeam == nFlagTeam))
            {
                RemoveFlagEffect(oPC);
                AssignCommand(oPC, PlaySound("as_mg_telepout1"));
                object oEnemyFlagHolder = GetObjectByTag("FlagHolder_" + IntToString(3-nFlagTeam));
                SetLocalObject(oModule, "oHasFlag_" + IntToString(3-nFlagTeam), oEnemyFlagHolder);
                ApplyFlagEffect(oEnemyFlagHolder);
                RewardCapture(nFlagTeam, oPC);
                AddPlayerScore(oPC, 5);
                // aggiungi 1 al contatore delle bandiere catturate dal giocatore
                SetLocalInt(oPC,"m_nFlags", (GetLocalInt(oPC,"m_nFlags") + 1) );
            }
        }


        //auto-pickup/steal flag for player inside the trigger
        int nEnemyTeam = nFlagTeam;
        int nPCTeam = 3 - nEnemyTeam;
        string szEnemyHasFlag = "oHasFlag_" + IntToString(nEnemyTeam);
        string szFriendlyHasFlag = "oHasFlag_" + IntToString(nPCTeam);
        object oEnemyFlagHolder = GetObjectByTag("FlagHolder_" + IntToString(nEnemyTeam));
        object oFriendlyFlagHolder = GetObjectByTag("FlagHolder_" + IntToString(nPCTeam));

        int iWaitIndex = GetLocalInt(oEnemyFlagHolder, "WaitIndex") % 5;
        object oWaitPlayer;
        float fDist;
        int i;
        for (i = 0; i < 5; i++)
        {
            oWaitPlayer = GetLocalObject(oEnemyFlagHolder, "WaitPlayer" + IntToString(iWaitIndex));
            if (GetIsObjectValid(oWaitPlayer) && GetIsPC(oWaitPlayer))
            {
                fDist = GetDistanceBetween(oWaitPlayer, GetObjectByTag(IntToString(GetLocalInt(oModule, "nRound")) + "_Flagholder_" + IntToString(nEnemyTeam)));
                //SendMessageToAllDMs("DEBUG: bs_destroyflag: auto-steal by " + GetName(oWaitPlayer) + " is " + FloatToString(fDist) + " meters from stand.");
                if ((fDist > 0.0) && (fDist < 4.0) && (GetPlayerTeam(oWaitPlayer) == nPCTeam))
                {
                    RemoveAllEffects(oEnemyFlagHolder);
                    SetLocalObject(oModule, szEnemyHasFlag, oWaitPlayer);
                    ApplyFlagEffect(oWaitPlayer);
                    if (GetLocalInt(oModule, "FlagShouts"))
                    {
                        AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+ GetStringLeft(GetName(oWaitPlayer),20)+"</c>" + " stole the "+GetTeamColour(nEnemyTeam)+ GetTeamName(nEnemyTeam) + "</c> flag!", TALKVOLUME_SHOUT));
                    }
                    BroadcastMessage(GetStringLeft(GetName(oWaitPlayer),20) + " stole the " + GetTeamName(nEnemyTeam) + " flag!", nPCTeam);
                    BroadcastMessage(GetStringLeft(GetName(oWaitPlayer),20) + " from " + GetTeamName(nPCTeam) + " stole our flag!", nEnemyTeam);
                    break;
                }
                iWaitIndex = (iWaitIndex+1) % 5;
            }
        }
        //SetLocalInt(oEnemyFlagHolder, "WaitIndex", GetLocalInt(oEnemyFlagHolder, "WaitIndex") +1);
    }
}
