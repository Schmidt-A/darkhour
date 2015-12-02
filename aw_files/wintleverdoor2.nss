void main()
{
object oDoor = GetObjectByTag("WinterBridge2");

SetLocked(oDoor, FALSE);
ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
PlaySound("as_sw_lever1");
AssignCommand(oDoor, PlaySound("gui_picklockopen"));
AssignCommand(oDoor,ActionOpenDoor(oDoor));
}
