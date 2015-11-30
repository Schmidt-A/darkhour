void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("As you reach the top stair and take your first few steps into the room- your situation becomes apparent. You are in a descecrated temple. Bodies lay scattered and piled all around the temple, blood covering the floors with the brutal aftertaste of slaughter still laying in the air about you.", oPC);

}
