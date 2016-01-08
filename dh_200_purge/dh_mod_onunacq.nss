// Wrapper for the Dark Hour OnUnAcquire event.

// pc_drop_item
// This script will destroy any item dropped by a player immediately.
// Weapons that are disarmed will not be destroyed.
// Author: Scarface666
// Commenting: Zunath
// Re-editing by Mike Gleeson
#include "disease_inc"
void CheckDroppedItem(object oItem)
{
if (GetItemPossessor(oItem)==OBJECT_INVALID)
{
if(GetArea(oItem)!=OBJECT_INVALID)
{DestroyObject(oItem);}
//FloatingTextStringOnCreature("Dropped item was destroyed!!!", oPC); // Inform the player.
}
}
void main()
{
object oItem = GetModuleItemLost(),
oPC = GetModuleItemLostBy();
if(GetTag(oItem)=="ZombieDisease")
{RemoveDiseaseEffects(oPC);}
}
