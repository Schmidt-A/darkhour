
void main()
{
object oPC = GetLastUsedBy();
if (GetLocalInt(oPC,"CANNON")!= 0)
   return;

DelayCommand(7.0, SetLocalInt(oPC, "CANNON", 1));

}

