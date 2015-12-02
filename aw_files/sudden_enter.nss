///////////////////////////////
////// OnEnter in Sudden Area /
//created by Jantima
////////////////////////
#include "inc_bs_module"
#include "aw_include"
void main()
{
    object oPlayer= GetEnteringObject();
    int nTeam = GetPlayerTeam(oPlayer);
    RemovePlayerFromTeam(nTeam,oPlayer);
    RemoveFromParty(oPlayer);
    ExploreAreaForPlayer(OBJECT_SELF, oPlayer);
    RemoveFlag(oPlayer);
    // Loop through all other players in the game
    // and set up the dislikes.
    object oPC = GetFirstPC(); //GetFirstObjectInArea(GetArea(oPlayer));
    while ( GetIsObjectValid(oPC))
    {
        if ((oPC != oPlayer) && (GetDeity(oPC) != "GM") && (GetTag(GetArea(oPC)) == "arena_100"))
        {
            DelayCommand(0.1, SetPCDislike(oPlayer,oPC));
            DelayCommand(0.1, SetPCDislike(oPC,oPlayer));
        }

        oPC = GetNextPC();
    }
}
