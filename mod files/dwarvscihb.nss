void main()
{
int iChance = d8();
if(GetIsInCombat(OBJECT_SELF) == FALSE)
    {
    if(iChance == 5)
        {
        ClearAllActions(TRUE);
        ActionCastFakeSpellAtObject(SPELL_NATURES_BALANCE, OBJECT_SELF, PROJECTILE_PATH_TYPE_DEFAULT);
        }else
            {
            ActionRandomWalk();
            }
    }
}
