// Mount horse
// Author : Barry_1066
// Modified : 03/01/2008

#include "x3_inc_horse"

void main()
{
  object oPC    = GetLocalObject(oPC,"ITEM_ACTIVATOR");
  object oHorse = OBJECT_SELF;

  if (HorseGetIsMounted(oPC)) return;

  if (GetIsObjectValid(oHorse))
    AssignCommand(oPC, HorseMount(oHorse));


}
