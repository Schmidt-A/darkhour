#include "inc_bs_module"
void RewardLastStand(object LastStand)
{
ChooseTeam(LastStand);
MovePlayerToSpawn(LastStand);
}

void main()
{
    object oModule = GetModule();
    if (GetLocalInt(oModule, "bScanningSudden") == FALSE && GetLocalInt(GetModule(), "nSuddenRound") == 2 )
    {
        SetLocalInt(oModule, "bScanningSudden", TRUE);
        int DeathCount = GetLocalInt(oModule,"deathcount");

        int PlayerCount = 0;
        object oPlayer = GetFirstPC();
        object LastStand;
        while (GetIsObjectValid(oPlayer))
        {
            if(GetTag(GetArea(oPlayer)) == "arena_100" && GetCurrentHitPoints(oPlayer) > 0 && !GetIsDM(oPlayer) && (GetDeity(oPlayer)  != "GM"))
            {
                PlayerCount++;
                LastStand = oPlayer;
                RemoveFromParty(oPlayer);
            }
            oPlayer = GetNextPC();
        }
        if (PlayerCount < GetLocalInt(oModule, "SDPlayerCount"))
        {
            if (GetLocalInt(GetModule(), "FlagShouts"))
            {
                AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("<cýGÒ>" + IntToString(PlayerCount) + " players left standing in sudden death!</c>", TALKVOLUME_SHOUT));
            }
            else
            {
                BroadcastMessage("<cýGÒ>" + IntToString(PlayerCount) + " players left standing in sudden death!</c>");
            }
        }
        SetLocalInt(oModule, "SDPlayerCount", PlayerCount);

        if (PlayerCount == 1)
        {
            //Reward the winner
            BroadcastMessage("<cýGÒ>The last stand is: "+GetName(LastStand)+"</c>");
            FloatingTextStringOnCreature("<cýGÒ>Congratulation </c>",LastStand,FALSE);
            SetXP(LastStand,(GetXP(LastStand)+ 100*DeathCount));
            DelayCommand(2.0 ,FloatingTextStringOnCreature("<cýGÒ>You can chose a special item!</c>", LastStand));
            if (GetGender(LastStand) == GENDER_FEMALE)
            {
                CreateItemOnObject("specialitemf",LastStand);
            }
            else
            {
                CreateItemOnObject("specialitem",LastStand);
            }
            DelayCommand(10.0, RewardLastStand(LastStand));
            SetLocalInt(oModule, "nSuddenRound",0);
            SetLocalInt(oModule,"deathcount",0);
        }
        SetLocalInt(oModule, "bScanningSudden", FALSE);
    }
}
