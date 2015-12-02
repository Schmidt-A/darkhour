#include "nw_i0_plot"
void main()
{
    object oStore = GetObjectByTag(GetTag(OBJECT_SELF)+"Store");

    object oPost = GetNearestObjectByTag("POST_"+GetTag(OBJECT_SELF));
    JumpToObject(oPost);
    SetFacing(GetFacing(oPost));

    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        //without a convo GetLastSpeaker in this case returns the object who clicked on OBJECT_SELF
        OpenStore(oStore, GetLastSpeaker());
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
