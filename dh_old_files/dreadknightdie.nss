#include "_incl_xp"
void main()
{
object oArea = GetArea(OBJECT_SELF);
    object oPeople = GetFirstObjectInArea(oArea);
    while (oPeople != OBJECT_INVALID)
    {
        if ((GetIsPC(oPeople) == TRUE) && (GetIsDM(oPeople) == FALSE))
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oPeople,4.0);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d8(2),DAMAGE_TYPE_NEGATIVE),oPeople);
            if (GetItemPossessedBy(oPeople,"badge30") == OBJECT_INVALID)
            {
                CreateItemOnObject("badge30",oPeople);
                FloatingTextStringOnCreature("You received a new badge!", oPeople, FALSE);
                GiveXPToCreatureDH(oPeople,100);;
            }
        }
        oPeople = GetNextObjectInArea(oArea);
    }
}
