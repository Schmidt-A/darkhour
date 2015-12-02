#include "inc_bs_module"


void main()
{
    object oPlayer = GetExitingObject();
    int nTeam = GetLocalInt(oPlayer, "nTeam");
    string szEnemyHasFlag = "oHasFlag_" + IntToString(3 - nTeam);
    int nStatue = d4(1);
    if (GetLocalInt(oPlayer, "Monster") > 0)
    {
            if ((nStatue == 1) && (GetLocalInt(GetObjectByTag("zzz_statnw"), "StatueUsed") != TRUE))
        {
            nStatue = 2;
            if ((nStatue == 2) && (GetLocalInt(GetObjectByTag("zzz_statne"), "StatueUsed") != TRUE))
            {
                nStatue = 3;
            }
            if ((nStatue == 3) && (GetLocalInt(GetObjectByTag("zzz_statsw"), "StatueUsed") != TRUE))
            {
                nStatue = 4;
            }
        }
        if ((nStatue == 2) && (GetLocalInt(GetObjectByTag("zzz_statne"), "StatueUsed") != TRUE))
        {
            nStatue = 3;
            if ((nStatue == 3) && (GetLocalInt(GetObjectByTag("zzz_statsw"), "StatueUsed") != TRUE))
            {
                nStatue = 4;
            }
            if ((nStatue == 4) && (GetLocalInt(GetObjectByTag("zzz_statse"), "StatueUsed") != TRUE))
            {
                nStatue = 1;
            }
        }
        if ((nStatue == 3) && (GetLocalInt(GetObjectByTag("zzz_statsw"), "StatueUsed") != TRUE))
        {
            nStatue = 4;
            if ((nStatue == 4) && (GetLocalInt(GetObjectByTag("zzz_statse"), "StatueUsed") != TRUE))
            {
                nStatue = 1;
            }
            if ((nStatue == 1) && (GetLocalInt(GetObjectByTag("zzz_statnw"), "StatueUsed") != TRUE))
            {
                nStatue = 2;
            }
        }
        if ((nStatue == 4) && (GetLocalInt(GetObjectByTag("zzz_statse"), "StatueUsed") != TRUE))
        {
            nStatue = 1;
            if ((nStatue == 1) && (GetLocalInt(GetObjectByTag("zzz_statnw"), "StatueUsed") != TRUE))
            {
                nStatue = 2;
            }
            if ((nStatue == 2) && (GetLocalInt(GetObjectByTag("zzz_statne"), "StatueUsed") != TRUE))
            {
                nStatue = 3;
            }
        }
                        if (nStatue == 1)
                        {
                            AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("A monster spirit inhabits the northwest statue!", TALKVOLUME_SHOUT));
                            object oStatue = GetObjectByTag("zzz_statnw");
                            DeleteLocalInt(oStatue, "StatueUsed");
                            effect eVis = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oStatue, HoursToSeconds(17));
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                                int nSet = GetLocalInt(GetModule(), sTeam) - 1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                        }
                        if (nStatue == 2)
                        {
                            AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("A monster spirit inhabits the northeast statue!", TALKVOLUME_SHOUT));
                            object oStatue = GetObjectByTag("zzz_statne");
                            DeleteLocalInt(oStatue, "StatueUsed");
                            effect eVis = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oStatue, HoursToSeconds(17));
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                                int nSet = GetLocalInt(GetModule(), sTeam) - 1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                        }
                        if (nStatue == 3)
                        {
                            AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("A monster spirit inhabits the southwest statue!", TALKVOLUME_SHOUT));
                            object oStatue = GetObjectByTag("zzz_statsw");
                            DeleteLocalInt(oStatue, "StatueUsed");
                            effect eVis = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oStatue, HoursToSeconds(17));
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                                int nSet = GetLocalInt(GetModule(), sTeam) - 1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                        }
                        if (nStatue == 4)
                        {
                            AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("A monster spirit inhabits the southeast statue!", TALKVOLUME_SHOUT));
                            object oStatue = GetObjectByTag("zzz_statse");
                            effect eVis = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oStatue, HoursToSeconds(17));
                            DeleteLocalInt(oStatue, "StatueUsed");
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                                int nSet = GetLocalInt(GetModule(), sTeam) - 1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                        }
    }
    if (GetLocalInt(oPlayer, "LegendHunter") == TRUE)
    {
        DeleteLocalInt(GetModule(), "StatueUsed");
        AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("The Legend disappears mysteriously! A new one may arise if need be.", TALKVOLUME_SHOUT));
    }
    DeleteLocalInt(oPlayer, "Monster");
    DeleteLocalInt(oPlayer, "Hunter");
    DeleteLocalInt(oPlayer, "LegendHunter");
    //do something to know that they logged out

    //SendMessageToAllDMs("Playername"+GetPCPlayerName(oPlayer)+" Char:"+GetName(oPlayer)
    //+" Class:" +IntToString(GetPrimaryClass(oPlayer)) + " DoneLogin:" + IntToString(GetLocalInt(oPlayer,"DoneLogin")));

    if (nTeam != TEAM_NONE && GetLocalObject(GetModule(), szEnemyHasFlag) == oPlayer)
    {
        DropFlag(oPlayer);
    }

    if (nTeam == TEAM_GOOD || nTeam == TEAM_EVIL)
    {
        //PrintString("Removing player from team.");
        RemovePlayerFromTeam(nTeam, oPlayer);
    }

    CheckTeamBalance();

    /// vcs_onexit
     // object oPC = GetExitingObject();
    //DeleteLocalObject(GetModule(), "VCSPO_" + GetPCPlayerName(oPC));

     /*
    object oMod = GetModule();
    int i;
    string sName;
    object oCurPC;
    int nCount = -1; //exiting PC object is still valid
    for (i = 0; i < 38; i++)
    {
        sName = "PC" + IntToString(i);
        oCurPC = GetLocalObject(oMod, sName);
        if (GetIsObjectValid(oCurPC))
        {
            nCount++;
        }
        else
        {
            DeleteLocalObject(oMod, sName);
        }
    }
    int nCount2;
    oCurPC = GetFirstPC();
  while (GetIsObjectValid(oCurPC))
    {
        if (GetIsPC(oCurPC))
        {
            nCount2++;
        }
        oCurPC = GetNextPC();
    }
    if (nCount != nCount2)
    {
        WriteTimestampedLogEntry("DEBUG: [bs_clientexit] Bad count: " + IntToString(nCount) + " Count2: " + IntToString(nCount2));
    }
*/
    // Remove the player's GetPlayerByName entry.
    //DeleteLocalObject(GetModule(), "PCName_" + GetStringUpperCase(GetLocalString(GetModule(), "PCCName_" + GetName(oPlayer))));
}
