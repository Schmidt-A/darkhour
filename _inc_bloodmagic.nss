

float GetHPIncrement(object oCaster, string sCastClass) 
{
	float fHP = IntToFloat(GetMaxHitPoints(oCaster));
	float fClassNum = 0.0f;

	if (sCastClass == 'CLASS_TYPE_WIZARD')
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

void BloodMagic(string sSpellId, object oTargetObject, location lTargetObject, object oCaster, string sCastClass, object oCastItem, int iCastLevel)
{
	float fIncrement = GetHPIncrement(oCaster, sCastClass);
	float fStoredIncrement = GetLocalFloat(oCastItem, "storedIncrement");
	float fAdded = fIncrement + fStoredIncrement;
	int iDamage = 0;

	while(fAdded >= 1.0f)
	{
		fAdded = fAdded - 1.0f;
		iDamage++;
	}

	effect eDam = EffectDamage(iDamage, DAMAGE_TYPE_DIVINE);
	ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oCaster);

	SetLocalFloat(oCastItem, "storedIncrement", fAdded);
}