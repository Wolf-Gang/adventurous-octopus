
shared enum item_type
{
	useless,
	food,
	weapon,
};

shared class item 
{
  
  item(string pName = "Error item", item_type pType = item_type::useless, bool pStackable = true, int pValue = 0)
  {
    
    mName = pName;
    mType = pType;
    mValue = pValue;
    mStackable = pStackable;
    
  }
  
  string get_name()
	{
		return mName;
	}
	
	item_type get_type()
	{
		return mType;
	}
	
	// This is HP restore points if food and ATK if weapon
	int get_value()
	{
		return mValue;
	}
	
	bool is_stackable()
	{
		return mStackable;
	}
  
  private string mName;
  private item_type mType;
  private int mValue;
  private bool mStackable;
};

shared class inventory_item
{
	inventory_item()
	{
		mCount = 1;
	}
	
	item@ get_item() final
  {
    return mItem;
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
  private item mItem;
};

shared class player_data
{
	player_data()
	{
		mHP = 10;
		mHP_max = 10;
		mAtk = 2;
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
	
	void add_inventory_item(item@ mItem)
	{
		inventory_item@ find = find_item(mItem.get_name());
		
		if (find !is null &&
			find.get_item().is_stackable())
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
			if (mInventory[i].get_item().get_name() == pName)
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
