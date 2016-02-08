#include "_incl_inventory"

void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsDM(oPC))
        DelayCommand(0.5, DestroyAllItems(oPC, TRUE));
}
