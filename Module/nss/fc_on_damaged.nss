#include "fc_include"

int nChanceOfDamage = GetLocalInt(OBJECT_SELF, "CHANCE_OF_DAMAGE");
int nDamageIncrement = GetLocalInt(OBJECT_SELF, "DAMAGE_INCREMENT");
int nMaxChanceOfDamage = GetLocalInt(OBJECT_SELF, "MAX_CHANCE_OF_DMG");

void main()
{
    // Check to see if a local variable is present on this chest - otherwise, use the global
    if (nDamageIncrement == 0)
        nDamageIncrement = DAMAGE_INCREMENT;
    // Check to see if a local variable is present on this chest - otherwise, use the global
    if (nMaxChanceOfDamage == 0)
        nMaxChanceOfDamage = MAX_CHANCE_OF_DMG;
    nChanceOfDamage = nChanceOfDamage + nDamageIncrement;
    if (nChanceOfDamage > nMaxChanceOfDamage)
      nChanceOfDamage = nMaxChanceOfDamage;
    SetLocalInt(OBJECT_SELF, "CHANCE_OF_DAMAGE", nChanceOfDamage);
}
