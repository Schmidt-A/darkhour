void main()
{
object oPC = GetEnteringObject();
if(GetIsPC(oPC))
    {
    FloatingTextStringOnCreature("You might be able to catch some fish here.",oPC,FALSE);
    SetLocalInt(oPC,"FishingPossible",1);
    }
}
