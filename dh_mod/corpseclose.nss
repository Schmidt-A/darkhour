/*******************************************************/
/* When somebody gets all their stuff on the corpse it */
/* will destroy itself when they close it.             */
/*******************************************************/
/* Created by: Osthman                                 */
/* Date: Saturday, 9/14/02                             */
/*******************************************************/


void main()
{
    object oItem = GetFirstItemInInventory();

    if (oItem == OBJECT_INVALID)
    {
        DestroyObject(OBJECT_SELF);
    }
}
