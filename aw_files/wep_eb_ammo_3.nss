#include "item_enhancement"

void main()
{

    object oPC = GetPCSpeaker();
    SetLocalInt(oPC,"eb",3);
    AddDamageToItem( oPC,"ammo_enhancement");

}
