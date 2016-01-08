#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

RewardPartyXP(20, oPC, FALSE);

CreateItemOnObject("awesome", oPC);

}

