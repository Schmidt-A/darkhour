#include "item_enhancement"

void main()
{
    object oPC = GetPCSpeaker();
    object oMaker =  GetItemPossessedBy(oPC,"BoltMaker");
    StartCrafting(oPC,oMaker);
}
