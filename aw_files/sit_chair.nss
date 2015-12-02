void main()
{
object oUser = GetLastUsedBy();
object oChair=OBJECT_SELF;
   AssignCommand(oUser ,ActionSit(oChair));

}
