void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("As you step up towards the odd mechanism before you, some sort of motion sensor goes off and it begins to churn. Gears and clicks are heard as the rope-suspended platform from the depths of the nearby pit is pulled up, ready to be safely mounted.", oPC);

}
