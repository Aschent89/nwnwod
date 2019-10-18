void main()
{
DestroyObject(OBJECT_SELF, 240.0f);
object oSubject = GetLastKiller();
AdjustAlignment(oSubject, ALIGNMENT_EVIL, 5);
string msgevl1 = "To slay the innocent is akin to salying one's own soul.";
SendMessageToPC(oSubject, msgevl1);
string iWho = GetName(oSubject);
SendMessageToAllDMs (iWho + " did something very evil. ");
ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
