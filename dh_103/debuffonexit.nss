void main()
{
object oPC = GetExitingObject();
effect eSearch = GetFirstEffect(oPC);
while(GetIsEffectValid(eSearch))
    {
    if(GetEffectType(eSearch) == EFFECT_TYPE_SKILL_INCREASE && GetEffectSubType(eSearch) == SUBTYPE_EXTRAORDINARY && GetEffectCreator(eSearch) == OBJECT_SELF)
        {
        RemoveEffect(oPC,eSearch);
        }
    eSearch = GetNextEffect(oPC);
    }
}
