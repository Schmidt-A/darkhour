#include "item_enhancement"

void main()
{
    object oPC = GetPCSpeaker();
    object oMaker =  GetItemPossessedBy(oPC,"DartMaker");
    StartCrafting(oPC,oMaker);
}
