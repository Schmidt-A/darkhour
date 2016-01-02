//NX's Wing Convo
//Ne0nx3r0@gmail.com

void main()
{
object oPC = GetPCSpeaker();
int iCurrentWing = GetCreatureWingType(oPC) - 1;
string sNewWing  = Get2DAString("wingmodel","LABEL",iCurrentWing);

while((sNewWing == "") && (iCurrentWing > -1))
    {
    iCurrentWing = iCurrentWing - 1;
    sNewWing     = Get2DAString("wingmodel","LABEL",iCurrentWing);
    }

if(iCurrentWing == -1) iCurrentWing = 255;

SetCreatureWingType(iCurrentWing,oPC);

}
