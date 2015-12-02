void main()
{
object oPC = GetPCSpeaker();

int pcGold = GetGold(oPC);

if (2780 >= pcGold)
  {
    FloatingTextStringOnCreature("You don't have enough gold!",oPC,FALSE);
    return;
  }
else if (GetItemPossessedBy(GetPCSpeaker(),"ArrowMaker") != OBJECT_INVALID)
  {
    FloatingTextStringOnCreature("You already have an arrow maker!",oPC,FALSE);
    return;
  }
else
  {
    CreateItemOnObject("item050",oPC);
    TakeGoldFromCreature(2780,oPC,TRUE);
  }
}
