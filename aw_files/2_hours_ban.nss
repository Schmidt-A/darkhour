#include "aw_include"
void main()
{
object oDM = GetPCSpeaker();
object oTarget =  GetLocalObject(oDM,"MyTarget");
int banlength = 2;
BanPlayer(oDM,  oTarget, banlength );
}
