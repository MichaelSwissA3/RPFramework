/*
Author: Kerkkoh
First Edit: 23.4.2016

params
0 - Object - cursorObject
*/
params ["_ct"];

closeDialog 0;
createDialog "virtualShopSell";

_array = _ct getVariable "shopSystemShop";
ctrlSetText [1000, (_array select 0) call BIS_fnc_localize];

{
	_class = _x select 0;
	_price = [_x,1] call ClientModules_fnc_retrieveGlobalPrice;	
	_type = [_class] call ClientModules_fnc_findItemType;
	_classPriceType = [_class, _price, _type];

	_stringName = "";
	switch (true) do {
	    case (_type == 0 || _type == 2 || _type == 3 || _type == 4 || _type == 5): {
			_stringName = [_class]call Client_fnc_getWeaponName;
		};
	    case (_type == 1): {
			_stringName = [_class]call Client_fnc_getMagazineName;
		};
		case (_type == 6): {
			_stringName = [_class]call Client_fnc_getVehicleName;
		};
	};
	_shopItem = lbAdd [1500, _stringName];
	lbSetData [1500, _shopItem, str _classPriceType];
}forEach (_array select 2);

lbSetCurSel [1500, 0];
[]call ClientModules_fnc_shopSystemRefresh;
