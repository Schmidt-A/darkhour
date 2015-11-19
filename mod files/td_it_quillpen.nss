//::///////////////////////////////////////////////
//:: Name: Quill Pen Item Event Script
//:: FileName: td_it_quillpen
//:://////////////////////////////////////////////
/*
    This is an example on how to use the
    new default module events for NWN to
    have all code concerning one item in
    a single file.

    Note that this system only works, if
    the following events set on your module

    OnEquip      - x2_mod_def_equ
    OnUnEquip    - x2_mod_def_unequ
    OnAcquire    - x2_mod_def_aqu
    OnUnAcqucire - x2_mod_def_unaqu
    OnActivate   - x2_mod_def_act

    This is the on aquired and on activate script
    for the player book writing quill
*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-09-10
//:: Modified By: Thales Darkshine (Russ Henson)
//:: Modified On: 07-20-2008
//:://////////////////////////////////////////////


#include "x2_inc_switches"
#include "td_quill_inc"
void main()
{
    int nEvent =GetUserDefinedItemEventNumber();
    object oPC;
    object oItem;
    object oTarget;
    int oType;
    // * This code runs when the Unique Power property of the item is used
    // * Note that this event fires PCs only
    if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
        oPC   = GetItemActivator();
        oItem = GetItemActivated();
        oTarget = GetItemActivatedTarget();
        oType = GetBaseItemType(oTarget);
        string sTag = GetTag(oTarget);
        string sLastChat = GetLocalString(oPC,"TD_QUILLCHAT");
        // check to see if pen was used on the PC
        // if so maake PC examine the quillpen
        if (oTarget == oPC)
        {
            // make PC examie quill
            DeleteLocalString(oPC,"TD_QUILLCHAT");
            AssignCommand(oPC,ActionExamine(oItem));
            return;
        }
        //:://////////////////////////////////////////////
        /*
            if pen was used on a blank book either set the books
            new name or update its descritpion with the players
            last chat message.
        */
        //:://////////////////////////////////////////////
        if (oType == BASE_ITEM_BOOK)
        {
            if (sTag == "td_it_blankbook") //blank book alow writing
            {
                if (GetStringLeft(sLastChat, 5)=="name-")
                {
                    int iTitle = (GetStringLength(sLastChat)-5);
                    string sName = GetStringRight(sLastChat,iTitle);
                    SetBookName(oTarget, sName);
                    FloatingTextStringOnCreature(NAME_BOOK,oPC,FALSE);
                    //SendMessageToPC(oPC,NAME_BOOK);
                    AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_READ,1.0,4.0));
                    DeleteLocalString(oPC,"TD_QUILLCHAT");
                    return;
                }
                else if(GetStringLeft(sLastChat, 6)=="write-")
                {
                    int iText = (GetStringLength(sLastChat)-6);
                    string sText = GetStringRight(sLastChat,iText);
                    WriteBook(oTarget, sText);
                    FloatingTextStringOnCreature(WRITE_BOOK,oPC,FALSE);
                    SendMessageToPC(oPC,WRITE_BOOK);
                    AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_READ,1.0,4.0));
                    DeleteLocalString(oPC,"TD_QUILLCHAT");
                    return;
                }
            }
            else //do if is published book
            {
                //* if item is book but not a blank one tell pc that you cant write in this book
                FloatingTextStringOnCreature(BOOK_DONE,oPC,FALSE);
                //SendMessageToPC(oPC,BOOK_DONE);
                AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD,1.0,4.0));
                PlayVoiceChat(VOICE_CHAT_CANTDO,oPC);
                DeleteLocalString(oPC,"TD_QUILLCHAT");
                return;
            }
        }//* done with books
        //:://////////////////////////////////////////////
        /*
            section for sheets of parchment, they can be writen on
            but not named like books
        */
        //:://////////////////////////////////////////////
        else if (oType == BASE_ITEM_MISCMEDIUM)
        {
            if (sTag == "td_it_blankparch")//* if item is the blank parchemnt do this
            {
                if (GetStringLeft(sLastChat, 5)=="name-")
                {
                    int iTitle = (GetStringLength(sLastChat)-5);
                    string sName = GetStringRight(sLastChat,iTitle);
                    SetNoteName(oTarget, sName);
                    FloatingTextStringOnCreature(NAME_NOTE,oPC,FALSE);
                    //SendMessageToPC(oPC,NAME_NOTE);
                    AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD,1.0,4.0));
                    PlayVoiceChat(VOICE_CHAT_CANTDO,oPC);
                    DeleteLocalString(oPC,"TD_QUILLCHAT");
                    return;
                }
                else if(GetStringLeft(sLastChat, 6)=="write-")
                {
                    int iText = (GetStringLength(sLastChat)-6);
                    string sText = GetStringRight(sLastChat,iText);
                    WriteNote(oTarget, sText);
                    FloatingTextStringOnCreature(WRITE_NOTE,oPC,FALSE);
                    //SendMessageToPC(oPC,WRITE_NOTE);
                    AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_READ,1.0,4.0));
                    DeleteLocalString(oPC,"TD_QUILLCHAT");
                    return;
                }
            }
        }
        //:://////////////////////////////////////////////
        /*
            all other items, tell PC that this cant be written on
        */
        //:://////////////////////////////////////////////
        else
        {
            //tell pc they cant write on this item
            FloatingTextStringOnCreature(NOT_BOOK,oPC,FALSE);
            //SendMessageToPC(oPC,NOT_BOOK);
            AssignCommand(oPC,PlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD,1.0,4.0));
            PlayVoiceChat(VOICE_CHAT_CUSS,oPC);
            DeleteLocalString(oPC,"TD_QUILLCHAT");
            return;
        }
    }
    //:://////////////////////////////////////////////////
    // * This code runs when the item is acquired
    // * Note that this event fires PCs only
    else if (nEvent == X2_ITEM_EVENT_ACQUIRE)
    {

        oPC = GetModuleItemAcquiredBy();
        oItem  = GetModuleItemAcquired();
        // make PC examie quill the first time they pick it up
        // so that they see the instructions on how its used
        if (GetLocalInt(oItem,"NW_DO_ONCE") != 0)
        {
        return;
        }
        SetLocalInt(oItem,"NW_DO_ONCE",1);
    }
}

