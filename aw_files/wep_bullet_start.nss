#include "item_enhancement"

void main()
{
    object oPC = GetPCSpeaker();
    object oMaker =  GetItemPossessedBy(oPC,"BulletMaker");
    StartCrafting(oPC,oMaker);
}
