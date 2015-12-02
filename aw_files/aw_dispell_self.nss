#include "inc_bs_module"

void main()
{
//allow DM to cast o them
object oPC = GetLastSpellCaster();
if( GetIsPC(oPC ) )
    DelayCommand(1.0, RemoveBuffs( OBJECT_SELF ));
}
