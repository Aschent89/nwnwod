
//Put this script OnClick or OnFailToOpen
void main()
{

object oPC = GetClickingObject();

if (!GetIsPC(oPC)) return;

SendMessageToPC(oPC, "the handle has a red circle with a green light shining through it");

}
