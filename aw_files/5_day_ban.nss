#include "aw_include"
void main()
{
object oDM = GetPCSpeaker();
object oTarget =  GetLocalObject(oDM,"MyTarget");
int banlength = 120;
BanPlayer(oDM,  oTarget, banlength );
}
