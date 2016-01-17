#include "vault_hazards"

void main()
{
    int iPCCount = GetLocalInt(OBJECT_SELF, "iPCCount");
    SetLocalInt(OBJECT_SELF, "iPCCount", iPCCount-1);
    /* If the last person is leaving, clean up the cave in so we can prompt
     * a new one. */
    if(iPCCount == 1)
        CleanUpCaveIn();
}
