void main()
{
    object oItem = GetItemActivated();
    object oActivator = GetItemActivator();

    if (GetTag(oItem) == "pclist")
    {
        AssignCommand(oActivator, ActionStartConversation(oActivator, "c_pcl_activate", TRUE));
    }

}
