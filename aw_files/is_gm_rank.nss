#include"aw_include"
int StartingConditional()
{
    object oGM = GetPCSpeaker();

    if( GetGMRank(oGM) >= GM )
    {
    return TRUE;
    }
  return FALSE;
}
