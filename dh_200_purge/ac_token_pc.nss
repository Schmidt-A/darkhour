#include "_incl_pc_data"

void main()
{
    object oPC = GetItemActivator();
    PCDOnActivate(oPC);
    PCDDebugOutput(oPC);
}
