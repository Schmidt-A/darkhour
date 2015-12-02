#include "item_enhancement"

void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC,"mighty",8);

    AddDamageToItem(oPC,"ammo_mighty");
}
