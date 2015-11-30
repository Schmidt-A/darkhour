void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("Here it is.. the grand Annedhellian Desert in all of its glory. Dunes upon dunes of unending sands and blazing hot temperatures. An unwise choice to venture further without proper premeditation.", oPC);

}
