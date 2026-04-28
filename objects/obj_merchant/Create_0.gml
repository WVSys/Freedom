can_interact = false;
saved_message_timer = 0;
speech_bubble = noone;


show_current_line = function()
{
    var line = dialogue_lines[dialogue_index];

    var speaker_ref = line[0];
    text = line[1];

    var speaker_instance = noone;

    if (instance_exists(speaker_ref))
    {
        speaker_instance = speaker_ref;
    }
    else
    {
        speaker_instance = instance_find(speaker_ref, 0);
    }

    if (speaker_instance != noone)
    {
        with (speaker_instance)
        {
            if (object_index == obj_merchant)
            {
                merchant_say(other.text);
            }
            else
            {
                say(other.text);
            }
        }
    }
};

merchant_say = function(_text)
{
    if (instance_exists(speech_bubble))
    {
        instance_destroy(speech_bubble);
    }

    speech_bubble = instance_create_layer(
        x,
        y - 48,
        "Instances",
        obj_speech_bubble
    );

    speech_bubble.owner = id;
    speech_bubble.text = _text;
};

greeting_index = 0;

greetings = [
    "Hey there! You find anything interesting?",
    "Back again? Good to see you.",
    "Need supplies, or just browsing?",
    "Careful out there. Roads have been ugly lately.",
    "If you found coin, I found goods.",
    "Take your time. Rushed buyers make bad choices.",
    "You look like someone who has seen trouble today.",
    "The road treating you kindly? No? Didn't think so.",
    "I've got wares, you've got questions. Probably.",
    "Don't touch the sharp stuff unless you're buying.",
    "Ah, a familiar face. Still alive, too. Impressive.",
    "I was starting to wonder if the beasts got you.",
    "You bring stories or silver?",
    "Every item here has a story. Some are even true.",
    "Supplies first, heroics second. Trust me.",
    "If you're heading out, stock up before regret finds you.",
    "You look underprepared. Conveniently, I sell solutions.",
    "Good gear won't save a fool, but it helps.",
    "I've got potions, tools, and terrible advice.",
    "The cheap stuff keeps you alive. The good stuff keeps you winning.",
    "Don't ask where I got this. Ask what it costs.",
    "I only sell quality. Mostly.",
    "You break it, you bought it. You bleed on it, same rule.",
    "Another day, another customer with suspicious stains.",
    "You smell like adventure. And maybe mud.",
    "Long road ahead? Better pack heavier than your pride.",
    "I've seen brave fighters fall because they forgot rope.",
    "Gold is heavy. Let me help lighten the load.",
    "A blade is only as good as the hand holding it.",
    "A potion now is cheaper than a funeral later.",
    "If you came for discounts, you came to the wrong table.",
    "Prices are fair. My patience costs extra.",
    "Don't haggle too hard. I have feelings. Expensive ones.",
    "You want rare? I have rare. You want cheap? I have baskets.",
    "Everything has a price. Even bad decisions.",
    "I sell to heroes and cowards alike. Coin spends the same.",
    "You again. Either you're lucky or very stubborn.",
    "Still walking? Then something I sold you must have worked.",
    "I've got just the thing. Probably.",
    "You look like trouble. Good thing trouble pays well.",
    "A quiet customer is either broke or dangerous.",
    "The world is ending one bad choice at a time. Buy something.",
    "No refunds if the monster eats you anyway.",
    "If it glows, it costs more.",
    "If it hums, don't shake it.",
    "If it whispers, absolutely don't shake it.",
    "I had a map once. Then someone followed it.",
    "Maps are cheaper than wandering. Usually.",
    "You want protection? Buy armor. You want luck? Pray elsewhere.",
    "I can sell you a shield. Courage is not included.",
    "Don't mistake shiny for useful.",
    "Don't mistake rusty for useless.",
    "I've seen cursed items behave better than some customers.",
    "Some say this charm brings fortune. I say it brings profit.",
    "You seem like someone who survives by improvising.",
    "Improvising is just planning badly with confidence.",
    "That look in your eyes says you need supplies.",
    "That look in your eyes says you ignored my last advice.",
    "You ever notice trouble waits until you're low on potions?",
    "The wilds don't care how brave you are.",
    "A full pack makes a lighter heart.",
    "Buy now. Panic later.",
    "One potion can change the ending of a story.",
    "Every scar has a lesson. Mine says buy better boots.",
    "Boots, blades, bandages. The holy trinity.",
    "If you're going underground, bring light.",
    "If you're going into ruins, bring rope.",
    "If you're going into politics, bring poison. Kidding. Mostly.",
    "Never trust a locked chest. Never ignore one either.",
    "A locked chest is just a merchant with worse manners.",
    "You found treasure? Wonderful. I accept treasure.",
    "I hear the north road is dangerous. So is being unprepared.",
    "The south road is safer. That means less treasure.",
    "Strange winds lately. Makes people reckless.",
    "Monsters are moving closer. Business is moving with them.",
    "Bad omens are good for sales.",
    "People call it fear. I call it market demand.",
    "I don't make the dangers. I just profit responsibly.",
    "A merchant survives by knowing when to run.",
    "A fighter survives by knowing when to buy.",
    "I've buried customers richer than you.",
    "I've buried customers poorer than you too. Death is flexible.",
    "Don't look so grim. You're not dead yet.",
    "Come back breathing. Repeat business matters.",
    "If you die, I'll miss your coin.",
    "If you live, I'll pretend I expected it.",
    "You're either brave, desperate, or lost.",
    "Sometimes lost people find the best things.",
    "Sometimes lost people find teeth.",
    "I recommend avoiding teeth.",
    "You're welcome to browse. Just don't browse with sticky fingers.",
    "My goods are honest. My suppliers are a different story.",
    "I once sold a sword to a bard. Terrible idea.",
    "Never sell explosives to someone smiling that much.",
    "I don't sell miracles. I sell things close enough.",
    "Fresh stock today. Mostly fresh.",
    "Some of these came from ruins. Some from fools.",
    "A fool and their gold are my favorite customers.",
    "No offense. Unless it applies.",
    "You look offended. That one applied, didn't it?",
    "Relax. Everyone gets judged here.",
    "Hard times make hard people. Hard people need supplies.",
    "You carry yourself like someone with unfinished business.",
    "Unfinished business is expensive.",
    "Running from something? I sell light packs.",
    "Chasing something? I sell sharp things.",
    "Protecting someone? I sell shields.",
    "Avenging someone? I sell bad ideas with handles.",
    "Revenge dulls blades faster than monsters do.",
    "Don't let rage choose your equipment.",
    "Hope is good. Steel is better.",
    "Faith moves mountains. Rope helps climb them.",
    "You've got that look. Big quest, small budget.",
    "I've seen that look before. It usually bleeds.",
    "You don't need the best gear. Just enough to survive the mistake.",
    "Sometimes surviving is the victory.",
    "Sometimes running is the strategy.",
    "The dead don't care how honorable they were.",
    "Honor is lighter than armor and protects less.",
    "Still, I respect a noble fool.",
    "You seem like the useful kind of fool.",
    "Don't worry. That's almost a compliment.",
    "The world breaks everyone eventually. Good boots help.",
    "I stock what people need, not what they admit needing.",
    "You need more healing supplies. Yes, I can tell.",
    "Blood on the sleeve, limp in the step, empty pouch. Classic.",
    "You adventurers are terrible at subtlety.",
    "Try not to test every trap with your face.",
    "If the door growls, don't open it.",
    "If the statue moves, apologize first.",
    "If the floor clicks, stop walking.",
    "If the walls bleed, leave.",
    "If the treasure is sitting alone, it isn't alone.",
    "If the cave is quiet, listen harder.",
    "If birds stop singing, draw your weapon.",
    "If I stop talking, run.",
    "No, that hasn't happened yet.",
    "Probably.",
    "You want the practical advice or the comforting lie?",
    "Practical advice costs less.",
    "Comforting lies are premium stock.",
    "You look like you could use both.",
    "I don't ask questions. Questions lower profit.",
    "Actually, questions raise profit. People buy when nervous.",
    "You nervous?",
    "Good. Nervous people live longer.",
    "Fear sharpens the senses.",
    "Overconfidence sharpens the undertaker's shovel.",
    "I've met legends. Most were shorter than expected.",
    "Legends still need socks.",
    "Nobody sings about the merchant who packed the hero's bag.",
    "Tragic, really.",
    "One day they'll build me a statue.",
    "Probably out of unpaid debt notices.",
    "You laugh, but accounting survives empires.",
    "Steel rusts. Ledgers remain.",
    "Never underestimate a merchant with records.",
    "You owe me nothing. Yet.",
    "I remember every favor.",
    "I forget every insult after sufficient payment.",
    "You're becoming a regular.",
    "Regulars get better greetings, not better prices.",
    "Good to see you still in one piece.",
    "Mostly one piece, anyway.",
    "You lost weight. Or armor.",
    "Rough journey?",
    "No need to answer. Your boots told me.",
    "Mud from the east road. Bad sign.",
    "Ash on your cloak. Worse sign.",
    "No cloak. Worst sign.",
    "I've got cloaks.",
    "A warm cloak has saved more lives than a proud speech.",
    "Want to hear a secret? Buy more bandages.",
    "The old ruins have been active again.",
    "People say lights move in the forest.",
    "People say lots of things when scared.",
    "Scared people buy lantern oil.",
    "I love folklore.",
    "Rumors are free. Acting on them costs extra.",
    "Heard something big moved through the hills.",
    "Heard nothing came back from the marsh.",
    "Heard the dead are restless.",
    "Heard the living are worse.",
    "Keep your weapon clean and your escape route cleaner.",
    "Never enter a room you can't leave quickly.",
    "Never trust a bridge built by desperate people.",
    "Never drink from glowing water.",
    "Never eat cave mushrooms unless someone else eats first.",
    "Never follow singing underground.",
    "Never accept gifts from masked strangers.",
    "Never ignore an old woman with a warning.",
    "Never mock a small creature with big eyes.",
    "Never assume the bones are decorative.",
    "Never split the party. Yes, even alone.",
    "Adventuring is just bad planning with better stories.",
    "I respect it.",
    "You make danger look profitable.",
    "You've got potential. Dangerous thing, potential.",
    "Potential gets people killed before skill catches up.",
    "Skill keeps you alive. Gear buys skill time.",
    "That's my sales pitch. Pretty good, right?",
    "Don't answer unless it's with coin.",
    "If you need something rare, ask.",
    "If you need something illegal, whisper.",
    "If you need something impossible, pay first.",
    "I've dealt with kings, thieves, priests, and worse.",
    "The worse ones usually ask for discounts.",
    "You seem decent. That worries me.",
    "Decent people take dangerous jobs.",
    "Dangerous jobs make excellent customers.",
    "You see how this works.",
    "The road changes people.",
    "Try to let it change your boots instead of your soul.",
    "Heavy thought, I know. Buy a snack.",
    "Even heroes need lunch.",
    "Even villains need lunch.",
    "That's why I don't judge. Much.",
    "You've got the look of someone carrying too much.",
    "Not in your pack. In your head.",
    "I don't sell peace of mind.",
    "But I do sell distractions.",
    "New blade? New potion? New problem?",
    "Sometimes a purchase is just hope with a price tag.",
    "Hope sells well these days.",
    "Not as well as healing tonics.",
    "You're still here. That's worth something.",
    "Every return trip is a small victory.",
    "Don't waste it.",
    "So, what'll it be?"
];

function merchant_greet()
{
    var msg = greetings[greeting_index];

    greeting_index += 1;

    if (greeting_index >= array_length(greetings))
    {
        greeting_index = 0;
    }

    merchant_say(msg);
}