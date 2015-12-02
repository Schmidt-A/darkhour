#include "item_enhancement"

void main()
{
     object oPC = GetPCSpeaker();
     SetLocalInt(oPC,"damage_type",IP_CONST_DAMAGETYPE_ACID);
     AddDamageToItem(oPC,"damage_arrow");
}
