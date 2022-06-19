# Design notes, comments and changes.

Notes describing more or less interesting things about implemented skills. These may help you utilize some skills better, but aren't required to use them effectively. They are here just for people that are more interested in my thought processes behind each change. These notes include:

- Reasons why this skill was made, why it works like it does, why it has such a weird name etc.
- Explanations how some more convoluted skills actually work. (Some skills have in-game description that isn't entirely accurate. As stated before, it's enough to understand what they do, but isn't accurate to how they work code-wise.)
- Problems I've encountered and how they were dealt with.
- Other things that may be of interest.

## Police Skill Tree

### Badge

- Why camouflage (the decreased chance to get targeted)?
	- Because it was easy to explain lore-wise. During the heat of a battle, police notices your badge and is reluctant to shoot you. 
- Why is the bonus active only above 50% health?
	- As of the time of making this mod (this probably won't change, but who knows) the DS/OD meta was staying at low health with Berserk or other similar skills. As the police tree's main focus is survival, adding on top of those skills would only increase their already high viability.
- Who's Denis?
	- Long story, read the LORE.md file (once I make it).
- Why dodge chance?
	- The skill on it's own was too weak to spend points into it, and increasing the camouflage just wasn't an interesting option.
- Camouflage gets applied twice? That means 10% turns into 20%, right?
	- Well, no. It turns into 19%, as the bonus is multiplicative, not additive. If you don't get what it means, longer explanation below.
	* Every player has a stat called Attention (seperate from detection). It's the chance that enemies will target you. You can find more information about it on the internet, here I will only explain what the camouflage does. *
	* Camouflage decreases attention by multiplying it. 35% camouflage (from Optical Illusions skill) decrease it by 100% - (100% $\times$ 65%). 10% camouflage from badge decreases it by 100% - (100% $\times$ 90%). Applying this bonus again does 100% - (100% $\times$ 90% $\times$ 90%) which is 19%. *
	* Combining max efficiency of Badge with Optical Illusions grants 100% - (100% $\times$ 65% $\times$ 80% $\times$ 80%) which is 58,4% less chance to get targeted. *
	* (Dodge is not affected, as dodge is additive, meaning ex. 5% + 5% = 10%) *
	
	**TL;DR: The more camouflage bonuses get stacked, the less they give.**
	
### Thick Skin

- There's already a skill called Thick Skin.
	- Yeah, I know. I wasn't aware back when I was making it, and I can't just swap it with something else, because it's a reference to a character from lore (who in turn is a reference to Hotline Miami 2).
- Why above 50% endurance?
	- Read 2nd point of notes about Badge.
- What is an endurance, and why not just health?
	- Endurance is the total amount of hitpoints your character has. So just health + armor value. I used endurance as maintaining over 50% health is easier with armor-oriented builds (Anarchist), and harder with health oriented ones (Stoic). Endurance makes it the same for everyone, no matter what you prefer.
- Doesn't the ACED effect make Nine Lives redundant?
	- Somewhat yes, however on higher difficulties Nine Lives already didn't change anything and people just buy it to unlock the rest of the tree. In the future I may give Thick Skin ACED additional effect if player also has Nine Lives (similar to Vincent + Sneaky Bastard), but I don't promise anything.
- Isn't ACED effect too overpowered?
	- At the first glance, it may seem so. Maybe it is in the hand of lower-skilled players, however it's not that useful at higher-skill gameplay.
		- In multiplayer many players use Inspired which has 20s cooldown. You have 30s before getting to custody. 
		- Even without Inspire, the strat is to lay down without shooting and throw flashbangs/concussion grenades to let your teammates rush and revive you.
		- In solo gameplay bots have enough HP to stand in front of SWAT turret for 5s straight. 
		- In solo without bots, getting downed is already a death sentence (pun not intended).
		- Only useful application I could think of is when you use it with Messiah on solo heists.
- Any fun trivia?
	- The ACED effect doesn't make you immortal, rather gives you 9999900 bleedout health. Don't worry, it's enough to survive 39.22 minutes in front of SWAT Turret on Death Sentence.
	
### Discipline

- Why change converted enemies of all things?
	- I don't like their current implementation. They're bullet sponges meant to be a distraction for enemies. They can survive so much onslaught, whilst giving you an unnoticable change, that you basically forget about their existence.
		- I love games where you can have AI minions that help you through your gameplay. In Magicka I always spammed the summoning spells. It changes the solo/small group battle against the world into a full-blown, chaotic war. 
		- Of course it's impossible to achieve in Payday 2 with just one skill change and would need a whole rebalance, so I settled on a smaller victory; turning them from immortal bullet sponges into actual soldiers. 
		- Also getting tased with no ammo and seeing a convert just straight-up obliterate him from existence is a fun sight to watch.
	- Making converts die more often makes the ACED skill more usable.
- Why give a bonus when an enemy is converted?
	- Makes the convert mechanic more strategic. Rather than converting on the first best opportunity, you may want to wait until you have a far away objective to rush towards.
- Those temporary bonuses appear on my mod's HUD, how did you achieve that?
	- Those bonuses you get after converting an enemy aren't actually functions coded by me. I'm just granting player bonuses that are already in vanilla Payday 2 game, those being "Damage reduction during lock-picking", and "Team bonus speed after broken armor".
		- This means you can't have both of those bonuses stacked at the same time. For example, you can't convert a cop for 50% damage reduction, and start lock-picking a door for another 50% dmaage reduction.
		- I chose the first bonus to replace specifically to avoid stacking two 50% damage reductions together.
		- I chose the second bonus to replace because this vanilla skill is rarely used anyways, so the chance of one getting replaced is slim.