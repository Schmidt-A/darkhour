void main()
{
object oUser = GetLastUsedBy();
string sName = GetPCPlayerName(oUser);
object oChair=OBJECT_SELF;
if (sName == "ENIRO")
   {
     {
   AssignCommand(oUser,ActionSit(oChair));
     }
     FloatingTextStringOnCreature("Welcome Eniro", oUser, FALSE);
   }
   else
   FloatingTextStringOnCreature("You are not allowed to use this", oUser, FALSE);
}

