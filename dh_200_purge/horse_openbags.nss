//*************************************
//    Filename:  horse_openbags
/*
    Created by Barry_1066
    12/12/2006
*/
//*************************************

void main()
{
    object oPC = GetPCSpeaker();
    int nObjectType = OBJECT_TYPE_PLACEABLE;
    string sResRef = "saddlebag";
    string sHorseTag2 = GetName(OBJECT_SELF);
    string sHorseTag = (GetStringLeft(sHorseTag2, 16));
    string sNewTag = sHorseTag + "_sb";

    location lLoc = GetLocation(oPC);

    object oBag = CreateObject(nObjectType, sResRef, lLoc, FALSE, sNewTag);

    SetLocalObject(oPC,"PC_Bag",oBag);
    SetLocalInt(oPC, "PC_Saddle",1);
}


