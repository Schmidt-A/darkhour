void main()
{
object oDoor1 = GetNearestObjectByTag("MechDoor1");
object oDoor2 = GetNearestObjectByTag("MechDoor2");
object oDoor3 = GetNearestObjectByTag("MechDoor3");
object oDoor4 = GetNearestObjectByTag("MechDoor4");
if(GetIsOpen(oDoor2) == TRUE)
    {
    AssignCommand(oDoor2, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
    }else
        {
        AssignCommand(oDoor2, ActionPlayAnimation(ANIMATION_DOOR_OPEN1));
        }
if(GetIsOpen(oDoor3) == TRUE)
    {
    AssignCommand(oDoor3, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
    }else
        {
        AssignCommand(oDoor3, ActionPlayAnimation(ANIMATION_DOOR_OPEN1));
        }
if(GetIsOpen(oDoor4) == TRUE)
    {
    AssignCommand(oDoor4, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
    }else
        {
        AssignCommand(oDoor4, ActionPlayAnimation(ANIMATION_DOOR_OPEN1));
        }
ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE,1.0,1.0);
ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE,1.0,1.0);
FloatingTextStringOnCreature("You hear mechanisms moving in the distance.", GetLastUsedBy(), TRUE);
}
