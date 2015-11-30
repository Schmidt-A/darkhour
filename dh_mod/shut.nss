void main()
{
object oPC = GetLastOpenedBy();
if (!GetIsPC(oPC)) return;
DelayCommand(15.0, ActionCloseDoor(OBJECT_SELF));
}

