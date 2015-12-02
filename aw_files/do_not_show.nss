#include "x2_inc_itemprop"
#include "aw_include"
int StartingConditional()
{
      if(GetIsDM(GetPCSpeaker()) || GetIsAdmin(GetPCSpeaker()) ) return TRUE;

       else return FALSE;

}
