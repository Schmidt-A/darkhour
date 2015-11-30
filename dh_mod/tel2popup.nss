void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("You step into the broken wall and make your descent down and through a short, dense hole until you depart into the vast corridor before you. Hulking pillars and intricate architecture. Certainly not Lizardfolk doing.. but if not Lizardfolk, then who?", oPC);

}
