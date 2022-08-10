# opencomputers-scripts
a couple of scripts I used in my playthrough of compact clasutrophobia, a minecraft modpack.

# treecutter.lua
plants trees, uses axes, can handle axe breakage when cutting tree, waters tree, does basically anything you could want when cutting trees. Doesn't actually like picking anything up so you gotta have a vacuumulator (or other item collector thing) picking up the drops. My setup is unnecessarily small for kinda literally no reason other than that I think it's cool (4x5x2 footprint if anyone cares) but you don't have to do that. Additionally there's a boolean you can toggle to make it not take axes which can make it even more compact, but is pretty significantly slower.

requires inventory controller and inventory upgrade

<video src="https://user-images.githubusercontent.com/59105749/183991339-c127f2ba-d4e3-41d8-a3f4-efb1fd8532f2.mp4"></video>

# crafting.lua
Works in tandem with `recipes.lua`. Setup is as shown but if you prefer you can lift everything off the ground one and have the input chest be below the robot instead of to the right with a boolean toggle. This also works for 5x5x5 crafts and also literally anyhthing else. You shouldn't have too much trouble adding recipes to `recipes.lua` given the examples, but if you just bug me on discord or make an issue or something. Notice how in the video it pauses before it moves to the middle block--if it had the robot would have collided with something (I don't think it's the item entity because it shouldn't cause collisions, maybe it's the shrinking animation?) so it waits for it to finish. It does the same with faster crafts (like the machine walls) by waiting before

 it drops the item to start the next craft. It should be almost as fast as physically possible. It's also technically possible to stack two on top of eachother but idk how I'd get it to work with refined storage.

Other than that, notice that there are some useless items in the chest as well--iron grit and cobblestone. These are "catalysts" that we use to let the robot what craft we want them to make. It's defined in `recipes.lua` and can really be anything not used in another craft (and iron grit and cobble are common so they're good candidates). It returns these in the chest to its right after it finishes crafting. You must include them otherwise the robot won't know what to craft. Same goes for refined storage autocrafts.

requires inventory controller and inventory upgrade

<video src="https://user-images.githubusercontent.com/59105749/183991959-3b2beacb-b812-44f8-9532-0b753944abef.mp4"></video>


