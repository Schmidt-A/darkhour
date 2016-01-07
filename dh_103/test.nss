// This script will be on the "Actions Taken" portion of the conversation.
// This script will check the PCs quest part, advance it, and store it
// dynamically. You may perform the reward actions in this script, or in the
// convo it is really up to you, but this should help clear some things up.
void main()
{
// The PC in question is speaking to the NPC
object oPC = GetPCSpeaker();
// This variable will be used below as our quest item
object oItem;
// This is how we retrieve our campaign int for quest part
int iPart = GetCampaignInt(GetName(GetModule()), "questpart", oPC);
// Part is 0, meaning new and unstarted
if(iPart == 0)
    {
    oItem = GetItemPossessedBy(oPC, "itempart1tag");
    if(oItem != OBJECT_INVALID)
        {
        // The player has the item for part 1, so we are going to increase his
        // part value and store it, then do what else you need
        iPart += 1;
        SetCampaignInt(GetName(GetModule()), "questpart", iPart, oPC);
        }
        else
            {
            // The player does not have the item for this part, tell them & end
            SendMessageToPC(oPC, "You do not possess the necessary item.");
            return;
            }
    }
    // Player has completed part 1, now they will be in part 2. Note the if
    // statement says part == 1, but it is counting 0 also.
    else if(iPart == 1)
        {
        oItem = GetItemPossessedBy(oPC, "itempart2tag");
        if(oItem != OBJECT_INVALID)
            {
            // The player has the item for part 2, so we are going to increase his
            // part value and store it, then do what else you need
            iPart += 1;
            SetCampaignInt(GetName(GetModule()), "questpart", iPart, oPC);
            }
            else
                {
                // The player does not have the item for this part, tell them & end
                SendMessageToPC(oPC, "You do not possess the necessary item.");
                return;
                }
    }
    // Player has completed part 2, now they will be in part 3. Note the if
    // statement says part == 2, but it is counting 0 and 1 also.
    else if(iPart == 2)
        {
        oItem = GetItemPossessedBy(oPC, "itempart3tag");
        if(oItem != OBJECT_INVALID)
            {
            // The player has the item for part 3, so we are going to increase his
            // part value and store it, then do what else you need
            iPart += 1;
            SetCampaignInt(GetName(GetModule()), "questpart", iPart, oPC);
            }
            else
                {
                // The player does not have the item for this part, tell them & end
                SendMessageToPC(oPC, "You do not possess the necessary item.");
                return;
                }
    }
}
