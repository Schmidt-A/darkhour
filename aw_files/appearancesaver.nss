#include "aw_include"

void ResetSizeByAppearance(object oPC);
void ResetSizeByAppearance(object oPC)
{
  //DEBUG
  FloatingTextStringOnCreature("Resetting size via appearance.",oPC);

   int nAppearance = GetRacialType(oPC);
   /* RACIAL_TYPE_ELF
   RACIAL_TYPE_GNOME
   RACIAL_TYPE_HALFELF
   RACIAL_TYPE_HALFLING
   RACIAL_TYPE_HALFORC
   RACIAL_TYPE_HUMAN
   RACIAL_TYPE_DWARF
   */
switch  (nAppearance)
  {
  case RACIAL_TYPE_ELF:
  SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_ELF);
  break;
  case RACIAL_TYPE_GNOME:
  SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_GNOME);
  break;
  case RACIAL_TYPE_HALFELF:
  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HALF_ELF );
  break;
  case RACIAL_TYPE_HALFLING:
  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HALFLING );
  break;
  case RACIAL_TYPE_HALFORC:
  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HALF_ORC );
 break;
  case RACIAL_TYPE_HUMAN:
  SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HUMAN);
  break;
  case RACIAL_TYPE_DWARF:
  SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_DWARF);
  break;
  default:
  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HUMAN );
  break;
  }
}

void main()
{
object oPC = GetItemActivator();
int nAppearance = GetAppearanceType(oPC);
string sSave = IntToString(nAppearance);
SetSubRace(oPC, sSave);
FloatingTextStringOnCreature("Appearance saved via subrace.",oPC);
DelayCommand(1.0f, ResetSizeByAppearance(oPC));
DelayCommand(1.5f, FloatingTextStringOnCreature("You will now be booted.", oPC));
DelayCommand(2.0f, BootPC(oPC));
}
