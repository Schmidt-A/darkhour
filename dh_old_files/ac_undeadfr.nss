// Undead Frenzy Item Script.
void main()
{
object oDM = GetItemActivator();
object oArea = GetArea(oDM);
object oUndead = GetFirstObjectInArea(oArea);
while(oUndead != OBJECT_INVALID)
    {
    if(GetObjectType(oUndead)==OBJECT_TYPE_CREATURE && GetRacialType(oUndead)==RACIAL_TYPE_UNDEAD)
        {
        SetLocalInt(oUndead,"DM_Frenzy",TRUE);
        DelayCommand(120.0,SetLocalInt(oUndead,"DM_Frenzy",FALSE));
        }
    oUndead = GetNextObjectInArea(oArea);
    }
}
