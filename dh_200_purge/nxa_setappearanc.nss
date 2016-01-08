void main()
{
object oPC = GetPCSpeaker();
int iHeard = GetLocalInt(oPC,"iheard");

SetCreatureAppearanceType(oPC,iHeard);
DelayCommand(3.0, ExportSingleCharacter(oPC));
SendMessageToPC(oPC,"Appearance set to " + IntToString(iHeard));
}
