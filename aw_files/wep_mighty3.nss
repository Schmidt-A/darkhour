#include "item_enhancement"

void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC,"mighty",3);

    AddDamageToItem(oPC,"weapon_ranged");
}
