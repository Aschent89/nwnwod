void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

SendMessageToPC(oPC, "*Gazing over the debrie and skeleton riddled room; a deep sense of dread tingles against the back of your mind. You suddenly get the feeling that you shouldn't be here; and the urgency to leave is rising.*");

}
