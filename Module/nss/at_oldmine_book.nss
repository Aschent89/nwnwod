// author @ Khamul85
#include "inc_party"

void main()
{
    // Set the variables
    CreateItemOnObject("bookoldminelogto", GetPCSpeaker(), 1);
    SetPartyInt(GetPCSpeaker(), "oldMineQuest", 2);
}
