#include "inc_bs_module"
int StartingConditional()
{
    //int iResult;
    object oGm = GetPCSpeaker();
    object oPlayer = GetFirstPC();
    int Level;
    string sName;
    string sTeamName;
    string sLogin;
    int count = 101;   //   playername/object
    int DescCount = 201;     //description : team/level
    while (GetIsObjectValid(oPlayer))
    {
    Level = GetTotalPlayerLevel(oPlayer);
    SetCustomToken(count,GetName(oPlayer));   //this is the player name token
    SetCustomToken(DescCount,"("+GetPCPlayerName(oPlayer)+") "+GetTeamColour(GetPlayerTeam(oPlayer))+GetTeamName(GetPlayerTeam(oPlayer))+"</c> ["+IntToString(Level)+"]");
    sName = GetName(oPlayer);
    SetLocalString(oGm,IntToString(count),sName);  //save the charname
    DescCount= DescCount+1;  //this is the description token: team and level
    count = count+1 ;
    oPlayer = GetNextPC();
    }
    SetLocalInt(oGm,"playersnumber",count);    //save the total
    return TRUE;
}
