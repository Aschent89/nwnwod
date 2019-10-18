void main()
{
SetLocalInt(OBJECT_SELF, "FALLEN_IN_COFFIN", TRUE);
BeginConversation("f_vampirecoffin", GetLastUsedBy());
}
