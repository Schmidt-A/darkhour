#include "item_enhancement"

void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC,"Mighty",4);

    AddDamageToItem(oPC,"ammo_mighty");
}
