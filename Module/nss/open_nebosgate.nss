void main()
{

object oPC = GetPCSpeaker();

ActionUnlockObject(GetObjectByTag("NebariSouth_NebariCity"));

ActionSpeakString("Open the gate!");

ActionWait(1.0f);

ActionOpenDoor(GetObjectByTag("NebariSouth_NebariCity"));

}
