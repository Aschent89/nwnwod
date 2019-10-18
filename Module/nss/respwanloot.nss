// Treasure <span class="highlight">Chest</span> OnClose script
//::////////////////////////////////////
#include "x0_i0_treasure"

const float RESTOCK_TREASURE_DELAY = 900.0; // How long until <span class="highlight">chest</span> will <span class="highlight">respawn</span> treasure (in seconds).

void DestroyChestContents()
{ object oItem = GetFirstItemInInventory();
  while( GetIsObjectValid( oItem))
  { DestroyObject( oItem, (GetHasInventory( oItem) ? 0.2 : 0.1));
    oItem = GetNextItemInInventory();
  }
}

void main()
{
  DelayCommand(30.0, DestroyChestContents());
  DelayCommand( RESTOCK_TREASURE_DELAY +0.01, CTG_SetIsTreasureGenerated( OBJECT_SELF, FALSE));
}

