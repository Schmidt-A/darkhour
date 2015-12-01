object oItem;
void main()
{
object oPC = GetPCSpeaker();
oItem = GetItemPossessedBy(oPC, "Catalyst");
if (GetIsObjectValid(oItem))
   {
   DestroyObject(oItem);
   AssignCommand(oPC, TakeGoldFromCreature(20, oPC, TRUE));
   if (GetIsSkillSuccessful(oPC, SKILL_SPELLCRAFT, 12))
        {
        CreateItemOnObject("x1_wmgrenade002", oPC);
        }else
            {
            GiveGoldToCreature(oPC, 10);
            SendMessageToPC(oPC, "You have failed and half of the gold was lost in the process.");
            }
   }else
    {
    SendMessageToPC(oPC, "You do not possess a catalyst.");
    }
}

