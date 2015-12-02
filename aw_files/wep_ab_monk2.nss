#include "item_enhancement"

void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC,"ab",2);

    AddDamageToItem( oPC,"attack_bonus_monk");
}
