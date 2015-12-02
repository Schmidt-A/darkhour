#include "inc_bs_module"
/////OnHeartBeat:
void main()
{
    if (GetLocalInt(GetModule(),"nRound") == 98 )  //if currentround = King of the hill  (activeround)
    {
        object oThrone = OBJECT_SELF;
        object oKing = GetLocalObject(oThrone, "oKing");//this is the last that used the throne
        object oLastKing = GetLocalObject(oThrone, "oLastKing");
        int nReward = 25;
        int nTeam = GetLocalInt(oThrone, "nTeam");
        //int nCounter;
        /////////// give more xp and gp to who is sitting
        if (GetIsObjectValid(oKing) && GetCurrentAction(oKing) == ACTION_SIT && GetDistanceToObject(oKing) <= 1.0)
        {
            SetLocalInt(oKing,"Throne_counter", (GetLocalInt(oKing,"Throne_counter") +1));
        }
        else   //oKing is invalid or not sitting here ///
        {
            if (GetIsObjectValid(oKing)) //king is no more sitting but is still online and the last that used it
            {
                SetLocalObject(oThrone, "oLastKing",oKing);
                DelayCommand(12.0, DeleteLocalObject(oThrone, "oKing"));
                nTeam = GetLocalInt(oKing, "nTeam");

                int nFinalCount = GetLocalInt(oKing,"Throne_counter");
                AddPlayerScore(oKing, nFinalCount*2);
                GiveGoldToCreature(oKing, (nReward*2)*nFinalCount);
                SetXP(oKing,(GetXP(oKing)+ (nReward*2)*nFinalCount));
                DeleteLocalInt(oKing,"Throne_counter");
                // reward the last king and his team, so delete the last king
                object oPlayer = GetFirstPC();
                int finalreward = nReward*nFinalCount;
                while (GetIsObjectValid(oPlayer))
                {
                    if (nTeam == GetPlayerTeam(oPlayer) && oPlayer != oKing && GetTag(GetArea(oPlayer)) != (GetTeamName(nTeam) + "Castle"))
                    {
                        GiveGoldToCreature(oPlayer, finalreward);
                        // Record winnings
                        SetLocalInt(oPlayer,"m_nGoldwinnings", (GetLocalInt(oPlayer,"m_nGoldwinnings") +finalreward));
                        SetXP(oPlayer,(GetXP(oPlayer)+ finalreward));
                    }
                    oPlayer = GetNextPC();
                }
                AddTeamScore(nTeam,nFinalCount);
                /// ponts are given, than delete the last king so next HB there is not a king not sitting until a new one use it
                //DelayCommand(2.0,DeleteLocalObject(oThrone, "oKing"));
                // hoping that time is enought for the pengu thing
                // and set the thone usable for a new king
            } /// King is invalid /has left/crashed
            SetLocalInt(OBJECT_SELF,"InUse",0);
            DeleteLocalObject(oThrone, "oLastKing");
        }
    } /// round is not 98
}
