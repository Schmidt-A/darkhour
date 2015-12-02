#include "inc_custom"
#include "aw_include"
void main()
{
    object oDm = GetItemActivator();
    object oPlayer = GetItemActivatedTarget() ;
    object oItem = GetItemActivated();

    if(GetIsDM(oDm) || GetIsGMNormalChar(oDm))
    {
        RemoveWingsTailIfAny(oPlayer);
    }
    else
    {
        FloatingTextStringOnCreature("Only Dm  can use this.",oDm, FALSE);
        DestroyObject(oItem);
    }
}
