////OnEnter for No team Areas//////////
#include "inc_bs_module"
#include "aw_include"


void main()
{
    object oPlayer = GetEnteringObject();
    int nTeam = GetPlayerTeam(oPlayer);
    if (nTeam == 1 ||  nTeam == 2)
    {
        RemovePlayerFromTeam(nTeam, oPlayer);
    }


if(GetTag(OBJECT_SELF) == "Wingery")
    {
        if(!GetIsGMNormalChar(oPlayer) && !GetIsWingedGod(oPlayer) && !GetLocalInt(oPlayer, "MVMWinner"))
        {
            //Port Back to welcome
            AssignCommand(oPlayer,ClearAllActions(TRUE));
            AssignCommand( oPlayer,JumpToLocation(GetLocation(GetObjectByTag("Welcome1"))));
        }
        DeleteLocalInt(oPlayer, "MVMWinner"); //allow entry only once per MVM
        }
}