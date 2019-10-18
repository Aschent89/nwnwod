#include "emo_source"
void main()
{
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    string sTag = GetTag(oItem);

    if (sTag == EMOTE_WAND_TAG)
    {
        AssignCommand(oPC, ActionStartConversation(oPC, "emote_wand", TRUE, FALSE));
        return; }
}
