////////////////////////////////////////////////////////////////////////////////
///
/// Class Control System (CCS) v 1.3a
/// Created on 11/25/03 by DarthJohn
/// Last Modified on 01/12/04 by DarthJohn
/// Originally based on HCR code (http://www.rpging.net/nwn)
///
/// Script: ccs_defaults
///
////////////////////////////////////////////////////////////////////////////////
///
/// Level control policies are set to on (1) or off (0). By default they are all
/// set to on (1 or otherwise). After changing any of these setting, you should
/// run Build Module.
///
////////////////////////////////////////////////////////////////////////////////

    /// ***Character Level Control Policy***
    /// This setting will turn on and off whether a PC needs to talk to a
    /// trainer before taking a level.
    const int CCS_CHARACTER_LEVEL_CONTROL=0;

    /// ***Trainer Level Restriction Policy***
    /// This setting will turn on and off an NPC trainer's ability to train a PC
    /// if his own level in the desired class is not greater than that of the
    /// PC. If set to on (1) the NPC trainer must have more levels in the PC's
    /// desired class to train him.
    /// If the trainer is a PC then this option is automatically on.
    const int CCS_TRAINER_RESTRICTION=1;

    /// ***Multiclass Control Policy***
    /// This setting will turn on and off whether or not a PC can multiclass. If
    /// set to on (1), you can control how many levels the PC has to have in
    /// each of their current classes before changing classes.
    /// NOTE: requires CCS_CHARACTER_LEVEL_CONTROL set to on (1). Setting this
    /// value to 0 will allow the PC to train in all classes.
    const int CCS_MULTICLASS_LEVEL_CONTROL=1;

    /// This setting controls how many levels a PC must have before advancing in
    /// another class. When set to off (0) the PC cannot multiclass. When set to
    /// any number greater than 0 and less than 40, the PC must have the number
    /// of levels specified by this setting in each class before advancing in
    /// another class.
    const int CCS_MULTICLASS_LEVEL_AMOUNT=3;

    /// ***Trainer Start Level Policy***
    /// This value defines at which level the PC must seek out a trainer for
    /// advancement. If CCS_MULTICLASS_LEVEL_CONTROL is enabled then the PC may
    /// only advance in the same class he started in, but may seek out a trainer
    /// to get multiclassed and then be able to train in both classes without a
    /// trainer. Setting this value to 1 will require the PC to seek out a trainer
    /// for every level of advancement. Setting this value to off (0) will allow
    /// the PC to advance without ever needing a trainer. Setting this value to
    /// any number greater than 1, but equal to or less than 40, will require
    /// the PC to seek out a trainer for advancement starting at his character
    /// level equal to this value.
    const int CCS_TRAINER_START=7;

    /// ***Epic Level Control Policy***
    /// This setting turns on and off whether or not a PC can advance beyond
    /// level 20.
    /// NOTE: requires CCS_CHARACTER_LEVEL_CONTROL set to on (1).
    const int CCS_EPIC_LEVEL_CONRTOL=1;

    /// ***Training Cost Policy***
    /// This setting determines how much the character's level advancement will
    /// cost. This is called by the NPC trainer to determine if he charges the
    /// PC for training or not, and, if so, for how much.
    /// NOTE: set this value to 0 if you want to turn it off.
    const int CCS_LEVEL_COST=1;

    /// This setting determines at what level the PC will start getting charged
    /// for level advancement. Setting this value to 0 will turn it off.
    const int CCS_LEVEL_COST_START=12;

    /// This setting requires the PC leveler to pay a PC trainer the amount set
    /// by CCS_LEVEL_COST and observes CCS_LEVEL_COST_START.  CCS_LEVEL_COST
    /// must be enabled for this option to be available.
    const int CCS_LEVEL_COST_PCTRAINER=25;

    /// This setting overrides CCS_LEVEL_COST if set to on (any value greater
    /// than 0), so that the PC leveler has to pay a PC trainer a different fee
    /// than that of an NPC trainer. CCS_LEVEL_COST must be enabled for this
    /// option to be available.
    const int CCS_LEVEL_COST_PCTRAINER_FEE=25;

    /// This setting overrides CCS_LEVEL_COST_START if set to on (any value
    /// greater than 0), so that the PC leveler begins paying for training with
    /// a PC trainer at a different level than specified by
    /// CCS_LEVEL_COST_START. CCS_LEVEL_COST_START must be enabled for this
    /// option to be available.
    const int CCS_LEVEL_COST_PCTRAINER_FEE_START=0;

    /// ***PC Trainer XP Bonus Policy***
    /// This option turns on or off whether or not PC trainers get a little XP
    /// reward for training other PC's.
    const int CCS_PCTRAINER_XP_BONUS=1;

    /// This variable determines how many XP's per the PC trainee the PC trainer
    /// is awarded for training the PC trainee.
    const int CCS_PCTRAINER_XP_BONUS_VALUE=15;

    /// ***Experience Cap Policy***
    /// This setting will prevent PC's from continually acquiring XP until they
    /// have trained. With this value set to on (1), when a PC has gained
    /// enough XP to advance but has not yet trained they will not continue to
    /// gain XP until they level up. With this value set to off (0), PC's will
    /// continue to gain XP reguardless of whether or not they have trained.
    /// Note: this option is good for games that want to slow down the rate at
    /// which the PC's level.
    const int CCS_XP_LEVEL_CAP=0;

    /// This setting determines what the name of the CCS database will be for
    /// maintaining persistent CCS data in the module. Currently it only saves
    /// a value for enabling epic levels. Without it PC's will not be able to
    /// gain epic levels.
    const string CCS_DATABASE="CCS_Database";
