//NX's Wing Convo
//Ne0nx3r0@gmail.com

void main()
{
object oPC = GetPCSpeaker();
int iCurrentTail = GetCreatureTailType(oPC) - 1;
string sNewTail  = Get2DAString("tailmodel","LABEL",iCurrentTail);

//For the blank spots in CEP2
if (iCurrentTail==150)
    {
    iCurrentTail = 4;
    sNewTail = Get2DAString("tailmodel","LABEL",iCurrentTail);
    }

while((sNewTail == "") && (iCurrentTail > -1))
    {
    iCurrentTail = iCurrentTail - 1;
    sNewTail     = Get2DAString("tailmodel","LABEL",iCurrentTail);
    }

if(iCurrentTail == -1) iCurrentTail = 239;

SetCreatureTailType(iCurrentTail,oPC);
}
