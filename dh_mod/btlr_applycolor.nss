//Created by 420 for the CEP
//Apply color being worked on to PC
void main()
{
object oPC = GetPCSpeaker();

string sToModify = GetLocalString(OBJECT_SELF, "ToModify"); //Get part to color

int iChannel;

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

SetColor(oPC, iChannel, GetColor(OBJECT_SELF, iChannel)); //Change color
}
