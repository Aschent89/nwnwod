void main()
{
object oPC;

if (!GetIsPC(GetItemActivatedTarget())
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

oPC = GetItemActivator();

//The PC will technically start a conversation with himself
//You should add some odd little sound to the first line in the
//conversation file, or the PC will give his normal voicegreeting.

object oTarget;
oTarget = oPC;

AssignCommand(oTarget, ActionStartConversation(oPC, "vamp_animal2"));

}
