#include"inc_bs_module"
void main()
{
object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC))
    {
     if ((!GetIsDM(oPC)) && (GetPlayerTeam(oPC) != TEAM_NONE) && (GetDeity(oPC)  != "GM"))
     {
     RemovePlayerFromTeam(GetPlayerTeam(oPC),oPC);
     int PcLevel = GetHitDice(oPC);
     location lSpawn;
     object oSpawnpoint;
        if (PcLevel <13)
        {
        oSpawnpoint = GetObjectByTag("sudden"+IntToString(PcLevel),d4()-1);
        lSpawn = GetLocation(oSpawnpoint);
        }
        else
        {
        oSpawnpoint = GetObjectByTag("sudden"+IntToString(PcLevel),d2()-1);
        lSpawn = GetLocation(oSpawnpoint);
        }
     AssignCommand(oPC, ClearAllActions(TRUE));
     AssignCommand(oPC, MoveMeToLocation (lSpawn));
     }
     oPC = GetNextPC();
    }
   DelayCommand(10.0,SetLocalInt(GetModule(), "nSuddenRound",2));

}
