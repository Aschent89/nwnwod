//MadRabbits BDSM Toy and Collar Controls.
//This script allows you to customize the collar and toy program by altering the
//variables listed below.

//These are the 2da appearance numbers that correspond with each toy that makes
//a clothing parts change. The defaults are based on Jenx 2.3 and Jade Jenx Addon
//haks. If you use different clothing haks, you will have to change the numbers
//to meet the needs of your hak. The best way to find which number goes with
//which clothing model is ManDragon's Tailoring Models.
const int BDSM_NUMBER_CLAMP_F = 161; // Nipple Clamps Female. Chest Model. Default = 161
const int BDSM_NUMBER_CLAMP_M = 161; // Nipple Clamps Male. Chest Model. Default = 161
const int BDSM_NUMBER_CHASTITY_F = 135; // Chastity Belt Female. Pelvis Model. Default = 135
const int BDSM_NUMBER_CHASTITY_M = 110;// Chastity Belt Male. Pelvis Model. Default = 110
const int BDSM_NUMBER_COCK_SHEATH_M = 109; // Cock Sheath Male only. Pelvis Model. Default = 109
const int BDSM_NUMBER_CATTAIL_F = 155; // Cat Tail Butt Plug Female. Belt Model. Default = 155
const int BDSM_NUMBER_CATTAIL_M = 155; // Cat Tail Butt Plug Male. Belt Model. Default = 155
const int BDSM_NUMBER_DOGTAIL_F = 184; // Dog Tail Butt Plug Female. Belt Model. Default = 184
const int BDSM_NUMBER_DOGTAIL_M = 184; // Dog Tail Butt Plug Male. Belt Model. Default = 184
const int BDSM_NUMBER_DEVILTAIL_F = 181; // Devil Tail Butt Plug Female. Belt Model. Default = 181
const int BDSM_NUMBER_DEVILTAIL_M = 181; // Devil Tail Butt Plug Male. Belt Model. Default = 181
const int BDSM_NUMBER_WRIST_CUFFS_F = 121; // Wrist Cuffs Female. Forearm model. Default = 121
const int BDSM_NUMBER_WRIST_CUFFS_M = 121; // Wrist Cuffs Male. Forearm model. Default = 121
const int BDSM_NUMBER_FOOT_CUFFS_F = 125;// Ankle Cuffs Female. Shin model. Default = 125
const int BDSM_NUMBER_FOOT_CUFFS_M = 125; // Ankle Cuffs Male. Shin model. Default = 125
const int BDSM_NUMBER_STRAP_ON_F = 139; // Strap On Female. Pelvis Model. Default = 139
const int BDSM_NUMBER_THIGH_CUFFS_F = 195; // Thigh Cuffs Female. Thigh Model. Default = 195
const int BDSM_NUMBER_COLLAR_F = 109; //Slave Collar Neck Item Female. For the Slave Collar creation. Default = 109
const int BDSM_NUMBER_COLLAR_M = 109; //Slave Collar Neck Item Male. For the Slave Collar creation. Default = 109

//If set to 0, the toys will require the player's target to consent to the toy's
//use via a conversation. If this variable is set to 1, the toys will work on
//any player WITHOUT consent conversations.
//Default = 0
const int CONSENT_CONVERSATIONS_OFF = 0;

//Changing this variable will determine the subtype of all effects created by
//the toys and collars. SUBTYPE_SUPERNATURAL, SUBTYPE_EXTRAORDINARY, and
//SUBTYPE_MAGICAL. Supernatural makes the effects completely unremovable except
//via use of the toys, but is buggy with logging in and out. Extraordinary will
//make them removable by resting, but not by magic. Magical will make them
//easily removable, but no problems with logging in and out.
//Default = SUBTYPE_SUPERNATURAL
const int TOY_EFFECTS_SUBTYPE = SUBTYPE_EXTRAORDINARY;

//If set to 0, the player using the toy will speak a public emote, defining their
//actions. If set to 1, the player will NOT speak an emote and silent messages
//will instead be set to the player and the toy's target. Some servers may prefer
//to have the emotes off as to not disrupt a BDSM RP scene with static emotes
//that can be frankly quite annoying.
//Default = 0
const int EMOTE_STRINGS_OFF = 0;

//If set to 1, the black hood created by the Hood toy will be unequipable until
//the toy is used again to remove it. If set to 0, the hood can be removed by
//the player at their will.
//Default = 1
const int BLACK_HOOD_UNEQUIPPABLE = 0;

//If set to 1, the slave collars will be unequipable from the slave's neck slot
//unless their master allows them to remove them. If set to 0, the slave can
//remove them at will.
//Defualt = 1
const int COLLAR_UNEQUIPABLE = 0;

//If set to 1 and COLLAR_UNEQUIPABLE is set to 1, the slave collars will shock
//the player when they attempt to remove them. If set to 0, this will be disabled.
//UPDATED : Also if set to 0, the slave will not be shocked when equipping weapons
//or sitting when not allowed.
//Default = 1;
const int COLLAR_DAMAGE_ON = 1;

//This variable determines the amount of d4 damage the collar does when the slave
//attempts to unequip it (if that option is enabled) or when the master uses
//the "Shock slave" option. If set to 2, the collar will deal 2d4 electrical
//damage, 1 = 1d4 damage, 3 = 3d4 damage, etc..
//Default = 2;
const int COLLAR_DAMAGE_MULTIPLIER = 2;

//If you wish there to be a VFX effect attached to the Force Position options on
//the slave collar, change the 0 to the VFX effect you want. This needs to be one
//of the VFX_DUR_ constants. Example : VFX_DUR_GLOW_BLUE,
//VFX_DUR_GLOBE_INVULNERABILITY, etc.
//Default = 0; (Off, no visual effect);
const int COLLAR_FORCE_POSITION_VFX = 0;

//If this is set to 1, Players may use their control leashs to teleport their
//slaves to their locations. If set to 0, this option will be disabled. Some
//servers may wish this off due to abuse.
//Default = 1;
const int COLLAR_TELEPORT_ON = 0;

//This is the visual effect applied instantly when the slave is stripped of
//their clothing via the slave collar. It can be any visual effect EXCEPT a
//VFX_DUR_. If you do not wish a VFX effect to be applied, set this to 0
//Default = VFX_IMP_DISPEL_DISJUNCTION
const int COLLAR_STRIP_CLOTHING_VFX = VFX_IMP_DISPEL_DISJUNCTION;

//This is the visual effect associated with the Disable Spell Casting option
//on the slave collars. It MUST be a VFX_DUR_. If you do not want a VFX effect
//to be applied, set this to 0.
//Default = VFX_DUR_GLOBE_INVULNERABILITY
const int COLLAR_DISABLE_SPELL_VFX = 0;

//If set to 0, the ability to disallow a slave to sit in chairs will be turned
//off completely. If set to 1, it will be on.
//Default = 1
const int COLLAR_NO_SIT_ON = 1;




