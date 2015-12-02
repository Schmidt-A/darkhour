#include "item_enhancement"

void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC,"ab",3);

    AddDamageToItem( oPC,"attack_bonus");
}
