# Payday 2 Custom Skill Tree

My custom skill tree for Payday 2. Has a lot of inside memes that nobody will understand asides from a few people. Meant as a joke, but I may repurpose it into a normal custom tree in the future.

# Why?

Few reasons

1. I was bored and wanted to do something at least semi-productive.
2. I think Payday 2 doesn't have enough skill versatility.
3. There's almost no custom skill tree mods (only perk decks) which is sad.
4. To learn more about coding and how my C# skills translate into other high level languages (surprisingly well).
5. To learn more about design and balancing.

Oh yeah, balancing, I should also explain that.

# Balancing?

I'm obviously trying my best to make skills not too powerful, but strong enough to warrant investing points into them. And, as you can probably guess, that's easier said than done. As such we end up with some skills that are too weak for their cost (Police Badge), and skills that are too strong (Mongolian Miracle?)

The only sure way to test their usefuleness is playing. A lot of playing. That's why, if you've got any feedback, don't shy from posting it in Issues. I will always read it and take into consideration during rebalancing.

# Pull requests?

I'm always open for pull requests, especially ones that fix bugs/issues or improve the readibility/optimization of my code. Not so much for ones that implement new functionality/new skills (but don't be reluctant to try, the worst case scenario is that I refuse).

# Future plans

Plans are hard to keep up to, as life likes complicating everything, so it's best not to make too detailed or far-fetched plans. I don't promise anything on the list below will get implemented, but I promise to try my hardest to make it a reality. With that out of the way, here are the features that I'd love to implement.

- At least three skill trees. Possibly more if I get some more inspiration, but for now I only have enough ideas for three of them. I could possibly stretch it to four, however as Payday's tree system displays three trees per category, I'd also prefer to keep to that.
- Crackdown and Total Crackdown support, with Lar-Dheas skills rebalanced accordingly. That'd take a lot of work, as any Crackdown update could always break my mod.
- Increased difficulty for additional skill points, compatible with Crackdown. That's a really far-fetched goal and only something I'd strive to do after doing everything I want with this mod. This setting would be optional, limiting you to play only with people that also have it activated.


# Current issues and bugs

- Adaptation skill 
	- Concussion skill randomly doesn't work?
		- Played three whole heists single-player. Worked perfectly fine on 2/3. Didn't work on Lab Rats.
	
	- Check if it grants the Cheater tag (didn't get it after an one hour long heist, but it still should get tested more)
	- Reword description to make it take less space but also be easily understood (is it even possible?)
	- Concussion doesn't get set off when player gets critically wounded. Code is disabled. Is pretty random, doesn't help much and prevents getting set off on more useful occassions (like getting tased). Possible solutions:
		- Seperate cooldown for critical wounds and tasers.
		- Remove it completely from description.
	- Possibly make Stacks and Flashbang Cooldown display on HUD (could cause incompatibilities)
- Denis skill overrides CopBrain:convert_to_criminal, which may cause incompatibilities with other mods
	(Currently implemented band-aid fix makes it so this function is only overrided when player has this skill aced)
- Non-updated localization
- Few skills don't function as described
- Police Badge doesn't always get updated properly due to the core game not calling it that often. Relatively low priority, as it doesn't impact the gameplay almost at all.
- The upper-most skill in Police tree is a placeholder
- Messy code in "ammoclip.lua"
- Police Badge uses flat multiplier instead of a variable. Lowest priority, as it doesn't impact anything other than the flexibility of my code.
- Redundant variables
