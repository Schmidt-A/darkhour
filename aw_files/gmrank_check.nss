#include "aw_include"

int StartingConditional()
{
    object oGM = (GetLastSpeaker());

    int rank = GetLocalInt(oGM,"gmRank");


    if (rank >= GM || GetIsGM(oGM))
        return 1;
    else
        return 0;
}
