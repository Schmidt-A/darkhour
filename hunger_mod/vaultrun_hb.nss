#include "vault_hazards"

void main()
{
    int iPCCount = GetLocalInt(OBJECT_SELF, "iPCCount");
    // Don't waste time on this if there are no PCs in the area
    if(iPCCount < 1)
        return;

    // Keep track of HB interval so we only apply effects on the interval we want
    int iHBTicks = GetLocalInt(OBJECT_SELF, "iHBTicks");
    if(iHBTicks <= GetLocalInt(OBJECT_SELF, "iHBInterval"))
        SetLocalInt(OBJECT_SELF, "iHBTicks", iHBTicks+1);
    else
        SetLocalInt(OBJECT_SELF, "iHBTicks", 1);

    int iVault = GetLocalInt(OBJECT_SELF, "iVault");
    object oObject = GetFirstObjectInArea();

    while(GetIsObjectValid(oObject))
    {
        WriteTimestampedLogEntry(GetTag(oObject));
        if(GetIsPC(oObject) && !GetLocalInt(oObject, "iHazardsChecked"))
        {
            switch(iVault)
            {
                case KALARAM:
                    // Explained below
                    SetLocalInt(oObject, "iHazardsChecked", TRUE);
                    KalaramVaultEffects(oObject);
                    break;
                case FAELOTH:
                    FaelothVaultEffects(oObject);
                    break;
                case BARABAN:
                    BarabanVaultEffects(oObject);
                default: // No HB effects for Eledhreth, Annedhel or Sispara
                    break;
            }
        }
        oObject = GetNextObjectInArea();
    }

    /* Ok at first glance this looks like: wtf are you doing Tweek.
     * Because we might create puke piles in the middle of doing the loop over
     * objects in an area, it can totally break the list (list iteration screws
     * up really hard if you modify it in the middle of an iteration). That's
     * why that iHazardsChecked flag gets set. We have to un-set it here once
     * the loop is done though, so that the check can happen on the next interval. */
    if(iVault == KALARAM)
    {
        oObject = GetFirstObjectInArea();
        while(GetIsObjectValid(oObject))
        {
             if(GetIsPC(oObject))
                SetLocalInt(oObject, "iHazardsChecked", FALSE);
             oObject = GetNextObjectInArea();
        }
    }
}
