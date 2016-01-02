void main()
{
   DelayCommand(120.0, ActionCloseDoor(OBJECT_SELF));
   DelayCommand(120.0, SetLocked(OBJECT_SELF, TRUE));
}
