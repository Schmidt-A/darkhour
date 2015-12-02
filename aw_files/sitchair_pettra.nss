void main()
{
object oUser = GetLastUsedBy();
string sName = GetPCPlayerName(oUser);
object oChair=OBJECT_SELF;
if (sName == "Pettra")
   {
     {
   AssignCommand(oUser,ActionSit(oChair));
     }
     FloatingTextStringOnCreature("Welcome Pettra", oUser, FALSE);
   }
   else
   FloatingTextStringOnCreature("You are not allowed to use this", oUser, FALSE);
}
