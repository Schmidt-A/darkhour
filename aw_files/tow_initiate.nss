// tow_initiate
// Scripted By: Demon X
// For: Antiworld
// This script is placed upon the INITIATE TUG OF WAR Creatures OnSpawn event.
// It is necessary to start the effects upon the Avatars.
#include "inc_bs_module"
void main()
{
StartAvatars();
DestroyObject(OBJECT_SELF);
}
