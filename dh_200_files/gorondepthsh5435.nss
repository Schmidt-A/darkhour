void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("It looks like a mine shaft leading even deeper into the Underdark. However.. even if one had intention to go down. The rope suspended above is broken and hanging limply.", oPC);

}
