#include "item_enhancement"

void main()
{

    object oPC = GetPCSpeaker();
    SetLocalInt(oPC,"eb",2);
    AddDamageToItem( oPC,"enchantment");

}
