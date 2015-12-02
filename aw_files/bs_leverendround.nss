#include "inc_bs_module"


void main()
{
    ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    GetVotedRound();
    EndTheGame();
    ActionWait(2.0);
    ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
}
