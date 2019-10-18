
//Put this script OnClick or OnFailToOpen
void main()
{

object oPC = GetClickingObject();

if (!GetIsPC(oPC)) return;

SendMessageToPC(oPC, "the handle has a green circle with a yellow light shining through it");

}
