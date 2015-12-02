#include "inc_bs_module"
#include "aw_include"
void main()
{
    object oPlayer = GetLastOpenedBy();
    int noDev = GetLocalInt(GetModule(),"noDev");

    if (GetIsDMAW(oPlayer) || (GetDeity(oPlayer) == "GM"))
    {
        AssignCommand(oPlayer, MoveMeToLocation(GetLocation(GetObjectByTag("spawnpoint_1"))));
    }
    else if (noDev && GetHasDev(oPlayer))
    {
        FloatingTextStringOnCreature("Sorry, Anti Dev mode is currently active, please come back at another time or change builds",oPlayer,FALSE);
    }
    else if (GetHitDice(oPlayer) >= 10)
    {
        // Gold cheating check
        if ( CheckXpGoldBalance(oPlayer) )
        {
            //player sent to jail instead
        }
        else
        {

            InitializePlayerForGame(oPlayer);
            MovePlayerToSpawn(oPlayer);
            ActionWait(3.0);
            ActionCloseDoor(OBJECT_SELF);
        }
    }
    else
    {
        SpeakOneLinerConversation();
        ActionCloseDoor(OBJECT_SELF);
    }
}
