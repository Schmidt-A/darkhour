void main()
{
object oUser = GetLastUsedBy();
string sName = GetPCPlayerName(oUser);
object oChair=OBJECT_SELF;
if (sName == "Nilas_87")
   {
     {
   AssignCommand(oUser,ActionSit(oChair));
     }
     FloatingTextStringOnCreature("Welcome Nilas", oUser, FALSE);
   }
   else
   FloatingTextStringOnCreature("You are not allowed to use this", oUser, FALSE);
}
