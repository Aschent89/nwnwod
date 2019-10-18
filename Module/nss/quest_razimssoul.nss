//SAMPLE AND COMPILE TESTING RFMI-SCRIPT.
#include "rfmi"
void main()
{
//Called from a Conversation this setting would do the following:
//The Player speaking and ALL his/her Party Members in the same area
//would get 15 XP each per item with the tag "Tag" (case senitive), the player,
//but not his party (no matter location) would also get 10 Gold per Item.
//If the player has more than 25 items with that Tag (or if the cap is reached
//due to previous turn ins) it stops counting and rewards for all the items
//turned in this time. DMs are NOT notified of this delievery and the variable-
//type is Local (Not Campaign/Persistant) and is stored on the Conversation NPC.
RewardForMultipleItems(GetPCSpeaker(), OBJECT_SELF, "ks_razimsouls", 50, 15, 10, PARTY_RESTRICT_SAME_AREA, TRUE, FALSE, 0, TRUE, FALSE, FALSE);


//Called from a Conversation this Setting would do the following:
//The Player speaking and ALL his/her Party Members, REGARDLESS of location on
//the server would, would get 200 XP. This Function does not set variables
//nor does it take items.
RP_XP(000, GetPCSpeaker(), PARTY_RESTRICT_ALL_MEMBERS);

//Called from a Conversation this Setting would do the following:
//The Player speaking would get 300 Gold. His/Her Party Members would not
//receive a single gold piece. This Function does not set variables nor
//does it take items.
RP_GP(000, GetPCSpeaker(), PARTY_RESTRICT_NO_PARTY);


//Called from a conversation this Setting would do the following:
//Return the INT stored by the function in line 13 of this Sample Script.
//Useful if you want to see how many items, THIS Player have turned in.
//NB: This does NOT return the value of the Party Members.
GetVar_INT(GetPCSpeaker(), OBJECT_SELF, "X3_IT_DIAMOND");

/*
//This Script, if triggered would give the PC Speaking
//200 XP + 15 XP per items the PC carries with the Tag "Tag" to a Max of 675 XP
//300 GP + 10 GP per items the PC carries with the Tag "Tag" to a Max of 550 GP
//A LocalInt would be set on the object/NPC, with whom the PC is speaking.
//The PartyMembers in the same Area as him
*/
}

