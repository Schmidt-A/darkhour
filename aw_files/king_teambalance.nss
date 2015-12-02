#include "inc_bs_module"
void main()
{
int nGoodTotalLevel =  GetTeamTotalLevel(TEAM_GOOD);
int nEvilTotalLevel =  GetTeamTotalLevel(TEAM_EVIL);

  SetCustomToken(611, IntToString(nEvilTotalLevel));
  SetCustomToken(612, IntToString(nGoodTotalLevel));


  SetCustomToken(711, IntToString(GetTeamCount(TEAM_GOOD)));
  SetCustomToken(712, IntToString(GetTeamCount(TEAM_EVIL)));


}
