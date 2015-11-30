object oItem;
void main()
{
object oPC = GetPCSpeaker();
oItem = GetItemPossessedBy(oPC, "Catalyst");
if (GetIsObjectValid(oItem))
   {
   DestroyObject(oItem);
   AssignCommand(oPC, TakeGoldFromCreature(300, oPC, TRUE));
   if (GetIsSkillSuccessful(oPC, SKILL_SPELLCRAFT, 30))
        {
        CreateItemOnObject("x2_it_acidbomb", oPC);
        }else
            {
            GiveGoldToCreature(oPC, 150);
            SendMessageToPC(oPC, "You have failed and half of the gold was lost in the process.");
            }
   }else
    {
    SendMessageToPC(oPC, "You do not possess a catalyst.");
    }
}
