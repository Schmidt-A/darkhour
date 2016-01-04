//::///////////////////////////////////////////////
//:: FileName open_store
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Otwyn
//:: Created On: 9/02/2003
//::
//:: Place this script in the Action Taken tab of
//:: a conversation node.
//:: Paint a merchant near the NPC that called the
//:: conversation with tag of 'Store_<tag>' where
//:: <tag> is the NPC's tag.
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
    string sStore = GetTag(OBJECT_SELF);

    object oStore = GetNearestObjectByTag("Store_"+sStore);
    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
        gplotAppraiseOpenStore(oStore, GetPCSpeaker());
    else
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);

}
