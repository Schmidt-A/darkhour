void main()
{
object oPC = GetEnteringObject();
if(GetIsPC(oPC) && GetItemPossessedBy(oPC,"farmerprofhide")!=OBJECT_INVALID)
    {
    FloatingTextStringOnCreature("It looks like you could harvest some of the crop...",oPC,FALSE);
    SetLocalObject(oPC,"FARMABLE",OBJECT_SELF);
    }
else
    FloatingTextStringOnCreature("If you had possessed the necessary skill, you might be able to get something off the crops here.",oPC,FALSE);
}
