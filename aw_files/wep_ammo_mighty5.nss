#include "item_enhancement"

void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC,"mighty",5);

    AddDamageToItem(oPC,"ammo_mighty");
}
