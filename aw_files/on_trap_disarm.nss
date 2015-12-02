void main()
{
  object oPC = GetLastDisarmed();
  int nTrapDC = GetTrapDisarmDC(OBJECT_SELF);
  int nReward =  nTrapDC*100/GetHitDice(oPC);
  SetXP(oPC,(GetXP(oPC)+ nReward));
  GiveGoldToCreature(oPC,nReward);
}
