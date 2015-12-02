#include "aw_include"

int StartingConditional()
{
    object oGM = (GetLastSpeaker());

    int rank = GetLocalInt(oGM,"gmRank");


    if (rank >= GM)
        return 1;
    else
        return 0;
}
