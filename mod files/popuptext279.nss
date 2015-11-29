void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("It looks as if the dunes have taken their toll upon the outer walls of the city of Annedhel. Sand pours in from a huge pile of sand standing infront of the former gates of the city. Clearly this city was built upon the activity and livelihood of its inhabitants. And now that such.. livelihood is lost. The city is literally falling apart before you.", oPC);

}
