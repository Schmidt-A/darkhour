#include "item_enhancement"

void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC,"ab",4);

    AddDamageToItem( oPC,"attack_bonus");
}
