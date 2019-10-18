void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

AssignCommand(oPC, ClearAllActions());

AssignCommand(oPC, ActionSpeakString("I am compelled to kneel before this altar!"));

AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0f, 5.0f));

}

