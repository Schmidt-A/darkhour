#include "inc_bs_module"


int StartingConditional()
{
    object oPost = GetNearestObjectByTag("POST_"+GetTag(OBJECT_SELF));
    JumpToObject(oPost);
    SetFacing(GetFacing(oPost));

    int nTeam = GetLocalInt(GetLastSpeaker(), "nTeam");


    SetCustomToken(500, GetTeamName(nTeam));
    return TRUE;
    //All the tokens about map names are in bs_initialize
}
