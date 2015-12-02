#include "aps_include"

int StartingConditional()
{
    int iResult;

    if(GetLocalInt(GetPCSpeaker(), "RDD_ID") > 0)
    {
        iResult = TRUE;
    }
    else
    {
        iResult = FALSE;
    }
    return iResult;
}
