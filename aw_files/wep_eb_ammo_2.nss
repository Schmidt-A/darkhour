#include "item_enhancement"

void main()
{

    object oPC = GetPCSpeaker();
    SetLocalInt(oPC,"eb",2);
    AddDamageToItem( oPC,"ammo_enhancement");

}
