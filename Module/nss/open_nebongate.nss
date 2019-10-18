void main()
{

object oPC = GetPCSpeaker();

ActionUnlockObject(GetObjectByTag("NebariNorth_NebariCity"));

ActionWait(1.0f);

ActionOpenDoor(GetObjectByTag("NebariNorth_NebariCity"));

}
