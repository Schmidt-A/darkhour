void main()
{
object oGm = GetPCSpeaker();
object oMyTarget = GetLocalObject(oGm,"MyTarget");
SetCreatureAppearanceType(oMyTarget, APPEARANCE_TYPE_HALF_ORC);
}
