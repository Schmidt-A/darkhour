#include "inc_bs_module"
int StartingConditional()
{
    //int iResult;
    object oPC = GetPCSpeaker();
    object oPlayer = GetFirstPC();
    int Level;
    string sName;
    //string sTeamName;
    string sLogin;
    int count = 301;   //playername/object
    int DescCount = 401; //description :level
    while (GetIsObjectValid(oPlayer))
    {
    if(3-GetPlayerTeam(oPC)== GetPlayerTeam(oPlayer) && (GetKillRangeResult(oPC,oPlayer) == TRUE) && (oPC != oPlayer))
       {
       Level = GetTotalPlayerLevel(oPlayer);
       SetCustomToken(count,GetName(oPlayer));   //this is the player name token
       SetCustomToken(DescCount,"["+IntToString(Level)+"]");
       //sName = GetName(oPlayer);
       SetLocalObject(oPC,IntToString(count),oPlayer);
       DescCount= DescCount+1;  //this is the description token: team and level
       count = count+1;
       }
    oPlayer = GetNextPC();
    }
   SetLocalInt(oPC,"ValentinesCount",count-301);
   return TRUE;
}
