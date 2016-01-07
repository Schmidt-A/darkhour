void main()
{
int nSwitch = GetLocalInt(OBJECT_SELF,"Switch");
if(nSwitch = 0)
{PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);}
else
{PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);}

object oDoor = GetNearestObjectByTag("JailDoor");
AssignCommand(OBJECT_SELF,ActionOpenDoor(oDoor));
}
