
void main()
{
 object oGm = GetPCSpeaker();
 object oLoc = GetObjectByTag("Sudden");
 location lLoc = GetLocation(oLoc);
 AssignCommand( oGm,ClearAllActions(TRUE));
 AssignCommand( oGm,JumpToLocation(lLoc));
}
