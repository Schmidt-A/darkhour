#include "aw_include"

int StartingConditional()
{
    object oGM = (GetLastSpeaker());

    int rank = GetLocalInt(oGM,"gmRank");


    if (rank >= SENIOR_GM  || GetDeity(oGM) == "GM")
        return 1;
    else
        return 0;
}
