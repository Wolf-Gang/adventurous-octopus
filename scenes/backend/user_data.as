
shared enum item_type
{
	useless,
	food,
	weapon,
};


shared class inventory_item
{
	inventory_item()
	{
		mCount = 1;
	}
	
	string get_name()
	{
		return "Error Item";
	}
	
	item_type get_type()
	{
		return item_type::useless;
	}
	
	// This is HP restore points if food and DP if weapon
	int get_value()
	{
		return 0;
	}
	
	bool is_stackable()
	{
		return true;
	}
	
	int get_count() final
	{
		return mCount;
	}
  
	void set_count(int pCount) final
	{
		mCount = pCount;
	}
  
	void add_count(int pAmount = 1) final
	{
		mCount += pAmount;
	}
  
	private int mCount;
};

shared class crusty_bread_item : inventory_item
{
	string get_name() override
	{
		return "Crusty Bread";
	}
	
	item_type get_type() override
	{
		return item_type::food;
	}
	
	int get_value()
	{
		return 2;
	}
};

shared class crusty_knife_item : inventory_item
{
	string get_name() override
	{
		return "Crusty Knife";
	}
	
	item_type get_type() override
	{
		return item_type::weapon;
	}
	
	int get_value()
	{
		return 1;
	}
};

shared class player_data
{
	player_data()
	{
		mHP = 10;
		mHP_max = 10;
		mAtk = 2;
		add_inventory_item(crusty_bread_item());
		add_inventory_item(crusty_bread_item());
		add_inventory_item(crusty_knife_item());
	}

	int get_hp()
	{
		return mHP;
	}
  
	void set_hp(int pHP)
	{
		mHP = pHP;
	}
	
	int get_hp_max()
	{
		return mHP_max;
	}
	
	void set_hp_max(int pMax)
	{
		mHP_max = pMax;
	}
	
	int get_atk()
	{
		return mAtk;
	}
	
	void set_atk(int pAtk)
	{
		mAtk = pAtk;
	}
	
	void add_inventory_item(inventory_item@ mItem)
	{
		inventory_item@ find = find_item(mItem.get_name());
		
		if (find !is null &&
			find.is_stackable())
			find.add_count(mItem.get_count());
		else
			mInventory.insertLast(mItem);
	}
	
	void remove_item(uint pIndex)
	{
		if (mInventory[pIndex].get_count() > 1)
			mInventory[pIndex].add_count(-1);
		else
			mInventory.removeAt(pIndex);
	}
	
	inventory_item@ find_item(const string&in pName)
	{
		for (uint i = 0; i < mInventory.length(); i++)
		{
			if (mInventory[i].get_name() == pName)
				return @mInventory[i];
		}
		return null;
	}
	
	array<inventory_item@>@ get_inventory()
	{
		return @mInventory;
	}
	
	private int mHP;
	private int mHP_max;
	private int mAtk;
	private array<inventory_item@> mInventory;
};

shared player_data@ get_player_data()
{
	ref@ s_data = get_shared("player_data");
	if (s_data is null) // Create new data if none exists
	{
		player_data new_data();
		make_shared(@new_data, "player_data");
		return @new_data;
	}
	
	return cast<player_data>(s_data);
}
