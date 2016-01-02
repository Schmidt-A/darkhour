// blood magic item - Aez

float GetHPIncrement(object oCaster, int iCastClass)
{
    float fHP = IntToFloat(GetMaxHitPoints(oCaster));
    float fClassNum = 0.0f;

    if (iCastClass == CLASS_TYPE_WIZARD)
    {
        fClassNum = 20.0f;
    }
    else
    {
        fClassNum = 30.0f;
    }

    float fIncrement = fHP / fClassNum;
    return fIncrement;
}

void BloodMagic(object oCaster, int iCastClass, object oCastItem, int iCastLevel)
{
    float fIncrement = GetHPIncrement(oCaster, iCastClass);
    float fStoredIncrement = GetLocalFloat(oCastItem, "storedIncrement");
    float fAdded = fIncrement + fStoredIncrement;

    //This needs refactoring, it can be better, I was lazy
    int iDamage = 0;
    while(fAdded >= 1.0f)
    {
        fAdded = fAdded - 1.0f;
        iDamage++;
    }

    effect eDam = EffectDamage(iDamage, DAMAGE_TYPE_POSITIVE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oCaster);

    SetLocalFloat(oCastItem, "storedIncrement", fAdded);
}
