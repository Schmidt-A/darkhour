#include "stx_inc_craft"

int StartingConditional() {
    return (GetLocalInt(GetPCSpeaker(), "STX_CR_DONE") == STX_CR_DONE_NODYE);
}
