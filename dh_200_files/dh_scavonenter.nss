void main()
{
object oPC = GetEnteringObject();
if(GetIsPC(oPC))
    {
    SetLocalObject(oPC,"CanSearch",OBJECT_SELF);
    FloatingTextStringOnCreature("There is searchable junk here.",oPC,FALSE);
    }
}
