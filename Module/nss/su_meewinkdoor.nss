void main()
{
    object oPC = GetLastOpenedBy();
    AssignCommand(OBJECT_SELF, ActionOpenDoor(OBJECT_SELF));
    PlayVoiceChat(VOICE_CHAT_CUSS, oPC);
    FloatingTextStringOnCreature("The room inside is too gruesome to bear!", oPC, FALSE);
    AssignCommand(OBJECT_SELF, ClearAllActions());
    DelayCommand(1.0, AssignCommand(OBJECT_SELF, ActionCloseDoor(OBJECT_SELF)));
}
