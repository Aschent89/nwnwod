/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.0

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

//Put this OnEnter
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

FloatingTextStringOnCreature("An uneasy feeling stirs your stomach as the arrow filled corpse comes into view.  The stenches of death and other foul things drift down the tunnel, as do cries of pain and pleasure, mixed with the steady beat of wardrums...", oPC);

}
