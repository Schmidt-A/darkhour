
//a handy way to debug, just send the string and voila, if you caller can't speak
//then send a pc or something along with
void herDebug(string saywhat, object oSpeaker = OBJECT_SELF);

void herDebug(string saywhat, object oSpeaker = OBJECT_SELF)
{
//  if (myDebug) AssignCommand(oSpeaker, SpeakString(saywhat));
    object oPC = GetFirstPC();
    int i;
    while (oPC != OBJECT_INVALID)
    {
        if (GetPCPlayerName(oPC) == "HerMyT")
        {
            i = 1;
            break;
        }
        oPC = GetNextPC();
    }
    if (i == 1) SendMessageToPC(oPC, saywhat);
}
