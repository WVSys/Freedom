function get_repair_cost(item_name){
	var missing = get_item_max_durability(item_name) - get_item_durability(item_name);

    if (missing <= 0) return 0;

    return max(1, ceil(missing * 0.5));

}