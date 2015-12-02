void main()
{
object oPC = GetPCSpeaker();
object oDismissed = GetLocalObject(oPC,"MyValentine");
DeleteLocalObject(oPC,"MyValentine");
DeleteLocalObject(oDismissed,"MyValentine");
FloatingTextStringOnCreature("You've been Dismissed from "+ GetName(oPC),oDismissed, FALSE);
DelayCommand(2.0,FloatingTextStringOnCreature("You're no longer "+ GetName(oPC)+ "Valentine.",oDismissed, FALSE));
}
