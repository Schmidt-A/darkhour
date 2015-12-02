
#include "inc_bs_module"

void main()
{
    object oPC = GetEnteringObject();
    object oModule = GetModule();
    int nFlagTeam = StringToInt(GetStringRight(GetTag(OBJECT_SELF), 1));
    int nPCTeam = GetPlayerTeam(oPC);
    int nEnemyTeam = 3 - nPCTeam;
   // we do this in the aw_flagnpc_con  which is the pillar you click on to cap //  int nInRange = ExecuteScriptAndReturnInt("enemiesinrange", oPC);
    string szEnemyHasFlag = "oHasFlag_" + IntToString(nEnemyTeam);
    string szFriendlyHasFlag = "oHasFlag_" + IntToString(nPCTeam); //  Use the this variable if I ever decide to enforce Tribes-like rule for flag caps

    object oEnemyFlagHolder = GetObjectByTag("FlagHolder_" + IntToString(nEnemyTeam));
    object oFriendlyFlagHolder = GetObjectByTag("FlagHolder_" + IntToString(nPCTeam));

    if (!GetIsPC(oPC) || (GetDeity(oPC) == "GM") || GetIsDM(oPC) || (nPCTeam == TEAM_NONE))
    {
        return;
    }

   if (nPCTeam == nFlagTeam) //if crossing our own flagstand
    {
        if (oPC == GetLocalObject(oModule, szEnemyHasFlag)) //if PC has enemy flag
        {
             //check for people in range
            if(ExecuteScriptAndReturnInt("enemiesinrange", oPC) == FALSE)    //NOBODY IN RANGE
            {
                FloatingTextStringOnCreature("You can't capture the flag because no-one is in your range!",oPC,FALSE);
                DropFlag(oPC);
                RemoveFlagEffect(oPC);
                return;
            }

            if (oFriendlyFlagHolder != GetLocalObject(oModule, szFriendlyHasFlag)) //if our flag was stolen
            {
               FloatingTextStringOnCreature("You must retrieve your flag first!",oPC, FALSE);
            }
            else //else capture it!
            {
                RemoveFlagEffect(oPC);
                AssignCommand(oPC, PlaySound("as_mg_telepout1"));
                SetLocalObject(oModule, szEnemyHasFlag, oEnemyFlagHolder);
                ApplyFlagEffect(oEnemyFlagHolder);
                RewardCapture(nPCTeam, oPC);
                AddPlayerScore(oPC, 5);
                // aggiungi 1 al contatore delle bandiere catturate dal giocatore
                SetLocalInt(oPC,"m_nFlags", (GetLocalInt(oPC,"m_nFlags") + 1) );

                //auto-steal flag for player inside the trigger recorded earlier
                int iWaitIndex = GetLocalInt(oEnemyFlagHolder, "WaitIndex");
                object oWaitPlayer;
                float fDist;
                int i;
                for (i = 0; i < 5; i++)
                {
                    oWaitPlayer = GetLocalObject(oEnemyFlagHolder, "WaitPlayer" + IntToString(iWaitIndex));

                    if (GetIsObjectValid(oWaitPlayer) && GetIsPC(oWaitPlayer))
                    {
                        fDist = GetDistanceBetween(oWaitPlayer, GetObjectByTag(IntToString(GetLocalInt(oModule, "nRound")) + "_Flagholder_" + IntToString(nEnemyTeam)));
                        //SendMessageToAllDMs("DEBUG: bs_flagstand: auto-steal by " + GetName(oWaitPlayer) + " is " + FloatToString(fDist) + " meters from stand.");
                        if ((fDist > 0.0) && (fDist < 4.0) && (GetPlayerTeam(oWaitPlayer) == nPCTeam))
                        {
                            //Don't want people effected by the peaceful badger to take flags
                            if (GetLocalInt(oPC, "BadgerGift") == TRUE)
                            {
                                FloatingTextStringOnCreature("You are too peaceful to even consider taking a flag and upsetting the enemy team.", oPC, FALSE);
                            }
                            else
                            {
                                //copy paste pickup flag code
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
                        }
                    }
                    iWaitIndex = (iWaitIndex+1) % 5;
                }
                //SetLocalInt(oEnemyFlagHolder, "WaitIndex", GetLocalInt(oEnemyFlagHolder, "WaitIndex") +1);
            }
        }
    }
    else //crossing enemy flagstand
    {
        /*
        if (GetLocalObject(oModule, szEnemyHasFlag) != oEnemyFlagHolder)
        {
            //save players who are on stand to check when captured or returned
            int iWaitIndex = GetLocalInt(oEnemyFlagHolder, "WaitIndex");
            SetLocalObject(oEnemyFlagHolder, "WaitPlayer" + IntToString(iWaitIndex), oPC);
            SetLocalInt(oEnemyFlagHolder, "WaitIndex", (iWaitIndex + 1) % 5);
        }
        else
        {
            RemoveAllEffects(oEnemyFlagHolder);
            SetLocalObject(oModule, szEnemyHasFlag, oPC);
            ApplyFlagEffect(oPC);
            if (GetLocalInt(oModule, "FlagShouts"))
            {
                AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString(GetTeamColour(nPCTeam)+ GetStringLeft(GetName(oPC),20)+"</c>" + " stole the "+GetTeamColour(nEnemyTeam)+ GetTeamName(nEnemyTeam) + "</c> flag!", TALKVOLUME_SHOUT));
            }
            BroadcastMessage(GetStringLeft(GetName(oPC),20) + " stole the " + GetTeamName(nEnemyTeam) + " flag!", nPCTeam);
            BroadcastMessage(GetStringLeft(GetName(oPC),20) + " from " + GetTeamName(nPCTeam) + " stole our flag!", nEnemyTeam);
        }
        */
    }
}

