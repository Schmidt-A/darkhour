void main()
{
object oNPC = OBJECT_SELF;
object oPC = GetPCSpeaker();
int nNumber = GetLocalInt(oNPC, "Number");
SetCreatureAppearanceType(oPC, nNumber);
SetListening(oNPC, FALSE);
}
