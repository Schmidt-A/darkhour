/*
Ok this is HerMyT's handy dandy persistent chest storage code
its pathetically simple and even I should be able to get it to
work properly (especially as I coded it) so hopefully it works
for all you people out there, this script retrieves the objects
from storage in the campaign database, hopefully your campaign
database is named for your module because thats what this uses,
it stores the variable name for the object as the name of the
container plus an integer value representing the number of items
in the container, so this script which retrieves those items
takes advantage of that, now hopefully using the oItem check for
invalid items will work nicely.
*/
#include "her_persist_inc"



void main()
{
    if (GetLocalInt(OBJECT_SELF, "initialized") == 1)
    {
        //SpeakString("Initialized already");
        return;
    }
    InitContainer(OBJECT_SELF);
}

