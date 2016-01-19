/* Needs to be added to an OnEnter script for the Eledreth vault run area.
 * Triggers our "cave in" effect when the first player enters the area.
 * The cave-in points (currently expecting 3) need to be set up with the following
 * tags:
 *      eled_cave_in1
 *      eled_cave_in2
 *      eled_cave_in3
 * More detail (with pictures) is available on the builder forum thread
 * http://dhepilogue.boards.net/thread/277/vault-revamp-ideas?page=1&scrollTo=981
 * Cave-ins cannot be cleared unless by a character who is a miner. */

#include "vault_hazards"

void main()
{
    int iPCCount = GetLocalInt(OBJECT_SELF, "iPCCount");

    // Have to do a cave-in
    if(iPCCount == 0)
        CaveIn();

    SetLocalInt(OBJECT_SELF, "iPCCount", iPCCount+1);
}
