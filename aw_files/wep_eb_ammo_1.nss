#include "item_enhancement"

void main()
{

    object oPC = GetPCSpeaker();
    SetLocalInt(oPC,"eb",1);
    AddDamageToItem( oPC,"ammo_enhancement");

}
