void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("This house looks to have been looted rather dry over time, after giving it a quick scan. Even this man's pockets lay to their exterior form, denoting the merciless looting that occurs in times like this.", oPC);

}
