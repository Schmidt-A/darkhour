#include "disease_inc"
#include "_incl_disease"

void main()
{
    object oPC = GetItemActivator();
    CureDisease(oPC);
}

