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

# Current issues and bugs

- Converting cops crashes client on multiplayer
   (UnitNetworkHandler.mark_minion, mark_minion_original)
- Disappearing ammo pickups on multiplayer (? Needs more testing)
- Non-updated localization
- Few skills don't function as described
- Police Badge and Discipline replace vanilla functionality of respectively Optical Illusion and Partners in Crime
- The upper-most skill in Police tree is a placeholder
- Messy code in "ammoclip.lua"
- Redundant variables
