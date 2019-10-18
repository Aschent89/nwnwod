void main()
{
    object oPC = GetLastUsedBy();
    object oMeh = GetObjectByTag(GetTag(OBJECT_SELF));
    AssignCommand(oPC, ActionExamine(oMeh));
}
