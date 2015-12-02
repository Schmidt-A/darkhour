#include "item_enhancement"

void main()
{
    object oPC = GetPCSpeaker();
    object oWep =  GetItemPossessedBy(oPC,"AxeMaker");
    StartCrafting(oPC,oWep);
}
