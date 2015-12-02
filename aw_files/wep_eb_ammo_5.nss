#include "item_enhancement"

void main()
{

    object oPC = GetPCSpeaker();
    SetLocalInt(oPC,"eb",5);
    AddDamageToItem( oPC,"ammo_enhancement");

}
