void main()
{
object oPC = GetExitingObject();
if(GetIsPC(oPC))
    {
    SetLocalObject(oPC,"CanSearch",OBJECT_INVALID);
    }
}
