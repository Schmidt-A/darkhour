//Should hopefully fix a horse-bugged character from a dialog option.
#include "inc_custom"
#include "bodypart_inc"
#include "aw_include"
#include "inc_leto"
#include "x3_inc_horse"
void main()
{
object oPC = GetPCSpeaker();
if (!GetSkinInt(oPC,"bX3_IS_MOUNTED")) HorseIfNotDefaultAppearanceChange(oPC);
}
