void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("The bridge ahead is long and full of what would seem to be trade wagons. By the looks of it, every single wagon has -already- been looted dry. Odd how the people of Siranda were so quick to act..", oPC);

}
