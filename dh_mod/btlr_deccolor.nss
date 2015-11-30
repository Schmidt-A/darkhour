//Created by 420 for the CEP
//Previous color
//Based on script btlr_increase.nss by bloodsong
void main()
{
object oPC = GetPCSpeaker();

string sToModify = GetLocalString(OBJECT_SELF, "ToModify"); //Get part to color

int iMin = 0; //Min color

int iChannel;
int iNewColor;

//Set part to color

if(sToModify == "SKIN")
    {
    iChannel = COLOR_CHANNEL_SKIN;
    }

if(sToModify == "HAIR")
    {
    iChannel = COLOR_CHANNEL_HAIR;
    }

if(sToModify == "TATTOO1")
    {
    iChannel = COLOR_CHANNEL_TATTOO_1;
    }

if(sToModify == "TATTOO2")
    {
    iChannel = COLOR_CHANNEL_TATTOO_2;
    }

iNewColor = GetColor(OBJECT_SELF, iChannel)-1; //Set previous color

//Check for max
if(iNewColor < iMin)
    {
    iNewColor = 175;
    }

SetColor(OBJECT_SELF, iChannel, iNewColor); //Change color

SendMessageToPC(oPC, "New Color: " + IntToString(iNewColor)); //Tell PC color
}
