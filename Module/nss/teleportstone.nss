//this starts the convo "g_alpharanks" for the garou rank token system

void main()
{
object oPC;

if (!GetIsPC(GetItemActivatedTarget())
){

SendMessageToPC(GetItemActivator(), "You can only move people.");
return;}

object oTarget;
oPC = GetItemActivator();

//The PC will technically start a conversation with himself
//You should add some odd little sound to the first line in the
//conversation file, or the PC will give his normal voicegreeting.

oTarget = oPC;

AssignCommand(oTarget, ActionStartConversation(oPC, "teleport_pc"));

}
