void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("You cross over the highly-bound rock bridge and the floor immediately turns to the strong stone and a large gate is evident before you. Here it is. Ismail, the Ancient Duergar city.", oPC);

}
