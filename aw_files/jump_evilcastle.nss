
void main()
{
 object oGm = GetPCSpeaker();
 object oLoc = GetObjectByTag("EvilCastle1");
 location lLoc = GetLocation(oLoc);
 AssignCommand( oGm,ClearAllActions(TRUE));
 AssignCommand( oGm,JumpToLocation(lLoc));
}
