function buy_hp_potion(){
	var cost = 25;

    if (obj_character.coins >= cost)
    {
        obj_character.coins -= cost;
        obj_character.hp_potions += 1;
    }
}