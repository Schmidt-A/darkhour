void main()
{
object oPC = GetPCSpeaker();
int iGold = GetGold(oPC);
if(iGold >= 20)
    {
    TakeGoldFromCreature(20, oPC, TRUE);
    CreateItemOnObject("dwarvencriticalh", oPC);
    }else
        {
        SendMessageToPC(oPC, "You do not have enough gold.");
        }
}
