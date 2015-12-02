#include "item_enhancement"

void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC,"mighty",7);

    AddDamageToItem(oPC,"ammo_mighty");
}
