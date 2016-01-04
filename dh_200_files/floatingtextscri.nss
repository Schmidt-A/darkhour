void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("Upon exiting the narrow pass behind you, the air grows even colder. And the silence of the underdark holds true. Not a sound is heard around you as you make your way... this is a dangerous world. An unforgiving world.", oPC);

}
