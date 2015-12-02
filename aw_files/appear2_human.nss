void main()
{
object oGm = GetPCSpeaker();
object oMyTarget = GetLocalObject(oGm,"MyTarget");
SetCreatureAppearanceType(oMyTarget, APPEARANCE_TYPE_HUMAN);

DelayCommand(20.0, DeleteLocalObject(oGm,"MyTarget"));
}
