/* This script should be put on the heartbeat event of an invisible object
   placed in the center of the space.
   Allows for "securable area" behavior on a smaller defined space.
   WARNING: The area in which this is placed must have an iPCCount HB script on
   it.


   The following local variables must be set on the object:

   float fRadius        Defines the radius in meters of a square-shape (which is kind of
                        weird) of which this space. One toolset tile = 10m.
   
   string sCreatureN    The resref of the Nth creature that should be part of this
                        spawn, where N is however many number of creatures you've
                        already defined + 1.

   int sCreatureAmtN    The amount of creatures with resref N that should be
                        spawned.

   Here's an example:
        fRadius = 20.0m
        sCreature1      = "lizardfolk"
        sCreatureAmt1   = 10
        sCreature2      = "zombie003"
        sCreatureAmt2   = 5

   This example means that in the 4x4 tile space, 10 lizardfolk creatures and
   5 zombies will spawn.


   Optional variables:

   string sCreatureWPN  If set, causes creature N to be spawned at a specific
                        waypoint as opposed to at a random location. Using the
                        above example, you could set sCreatureWP2 = "zWP"
                        to cause all zombies to spawn at a waypoint with the 
                        tag zWP.

   string sDoorTag      If clearing the spawn should open a door, specify its
                        tag here.

   float fClearedTime   Time (in seconds) that a room should remain cleared
                        after all creatures within it are killed. Defaults to
                        2 in-game hours (which is equal to 8 IRL minutes = 480.0)

   int bStationary      Set this to TRUE if you don't want spawned creatures to
                        wander around.
*/

#include "_incl_spawns"

void main()
{
    HBSecurableSubArea();
}
