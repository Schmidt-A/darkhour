#include "item_enhancement"

void main()
{
     object oPC = GetPCSpeaker();
     SetLocalInt(oPC,"damage_type",IP_CONST_DAMAGETYPE_ELECTRICAL);
     AddDamageToItem(oPC,"weapon");
}
