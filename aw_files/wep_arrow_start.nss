#include "item_enhancement"

void main()
{
    object oPC = GetPCSpeaker();
    object oMaker =  GetItemPossessedBy(oPC,"ArrowMaker");
    StartCrafting(oPC,oMaker);
}
