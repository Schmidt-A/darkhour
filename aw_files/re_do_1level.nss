#include "inc_rules"
void main()
{
object oPC = GetPCSpeaker();
    int PlayerXp = GetXP(oPC);
    int nLevel = (GetHitDice(oPC)-1);   //un livello in meno
    int nNewXP = GetXPRequiredForLevel(nLevel);
    int nIdx = 0;
    object oItem = GetItemInSlot(nIdx,oPC);
    while(nIdx <= 18 )
    {

        AssignCommand(oPC, ActionUnequipItem(oItem));
         nIdx++;
        oItem = GetItemInSlot(nIdx,oPC);
    }

       SetXP(oPC, nNewXP);// valore degli xp del livello di sotto
       SetXP(oPC,PlayerXp);  // vecchio valore degli xp
}
