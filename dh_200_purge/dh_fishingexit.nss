void main()
{
object oPC = GetEnteringObject();
if(GetIsPC(oPC))
    {
    SetLocalInt(oPC,"FishingPossible",0);
    }
}
