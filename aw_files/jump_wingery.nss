
void main()
{
 object oGm = GetPCSpeaker();
 object oLoc = GetObjectByTag("wp_Wingery");
 location lLoc = GetLocation(oLoc);
 AssignCommand( oGm,ClearAllActions(TRUE));
 AssignCommand( oGm,JumpToLocation(lLoc));
}
