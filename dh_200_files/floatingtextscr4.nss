void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("As you depart the cave behind you, the world of the underdark unravels. Pure blackness is all that can be seen overhead, and accompanied by this is the sound of activity. Movement... crackles of what may be voices or the primal sounds of the denizens of the underdark. You are not sure. What you are sure of, however... is that you are no longer alone.", oPC);

}
