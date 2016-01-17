#include "vault_hazards"

void main()
{
    int iPCCount = GetLocalInt(OBJECT_SELF, "iPCCount");

    // Have to do a cave-in
    if(iPCCount == 0)
        CaveIn();

    SetLocalInt(OBJECT_SELF, "iPCCount", iPCCount+1);
}
