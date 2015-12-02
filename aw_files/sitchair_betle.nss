void main()
{
object oUser = GetLastUsedBy();
string sName = GetPCPlayerName(oUser);
object oChair=OBJECT_SELF;
if (sName == "Betle")
   {
     {
   AssignCommand(oUser,ActionSit(oChair));
     }
     FloatingTextStringOnCreature("Welcome Betle", oUser, FALSE);
   }
   else
   FloatingTextStringOnCreature("You are not allowed to use this", oUser, FALSE);
}
