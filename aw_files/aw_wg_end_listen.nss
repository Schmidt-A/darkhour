void main()
{
object oNPC = OBJECT_SELF;
SetListening(oNPC, FALSE);
object oPC = GetPCSpeaker();
SetListening(oPC, FALSE);
}
