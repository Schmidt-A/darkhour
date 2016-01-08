void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("A boarded doorway. All too common in the metropolitan cities of Siranda. No point in trying to take down the boards- even if you were to get into the house you'd likely be in close quarters with a 'family' of undead. Best keep moving.", oPC);

}
