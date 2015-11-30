void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("The once mighty Annedhel garrison.. completely abandoned? Makes sense enough. Who would want to take refuge in a barren place such as this?", oPC);

}
