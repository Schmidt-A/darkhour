void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("Upon entering the room, the brightness emitting from the magical torches before you comes as quite the shock, after walking around in near pitch blackness for so long. As your eyes adjust, a statue and an altar become apparent.", oPC);

}
