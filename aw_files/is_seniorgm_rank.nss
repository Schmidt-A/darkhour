#include"aw_include"
int StartingConditional()
{
    object oGM = GetPCSpeaker();

    if( GetGMRank(oGM) >= SENIOR_GM )
    {
    return TRUE;
    }
  return FALSE;
}
