script "ContestS27StoneHC.ash"

/*******************************************************
*	ContestS27StoneHC
*
*	Checks to ensure players are meeting the rule
*	requirements of the S27 PvP contest.
/*******************************************************/

int [string] data;	// Map for ids to be stored in
int id;				// Temporary placeholder
boolean[string] names = $strings[efot, LadyJ, Margaret Houlihan, Somersaulter, Mister Mickey, DoubleGold, MagicToast, CzarWhuzHere666, Monechetti, Isladar, asmithsgirl, Starbearer, Ninamo, Marge, MarenG9, Quintavirus, Nienor, lagoticspy, TwoHearted_Flail, Reso, Big Daddy Grimm, Mana Yachanichu, CherryJ, Mirrorshades, wrldwzrd89, Laidak, greycat, Commander Vimes, Lynn Gwynny, EstroJenn, LanioX, jojomojo, DarthNoob7, chameco, Bilfred, Baden, dogletta, ilee, Ouro Boros, rainierburger, Bale, TwirlyRotini, Zen00, Argwarg, Syi, chotoobo, nagyss, FinaiAttack, Actually Steve, Hendrix788, Tiny Plastic Xairon, StiffKnees, Mr Gravy, Ravien, Lhopitals, BabyScarface, Louis of Apshai, MasterSilex, Eevilcat];

/*******************************************************
*	HC(string player)
*
*	Returns TRUE if player has is in HC. Else
*	returns FALSE.	
/*******************************************************/
boolean HC(string player)
{
	string page = visit_url("showplayer.php?who=" + data[player]);
	if (page.contains_text("<br><b>(Hardcore)</b></td><td valign=center align=center><a href=account_tattoos.php>"))
		return TRUE;
	else
		return FALSE;
}
/*******************************************************
*	stone(string player)
*
*	Returns TRUE if player has a broken stone. Else
*	returns FALSE.
/*******************************************************/
boolean stone(string player)
{
	string page = visit_url("showplayer.php?who=" + data[player]).to_lower_case();
	if (page.contains_text("<a href=\"pvp.php?who=" + player.to_lower_case() + "\">attack</a>"))
		return TRUE;
	else
		return FALSE;
}

void main()
{
	foreach name in names					// Get ids assigned to names
	{
		id = get_player_id(name).to_int();
		data[name] = id;
	}
	foreach name in names					// Check players
	{
		if (!HC(name) && !stone(name))
			print(name + " is not in HC and has an intact stone.","red");
		else if (!HC(name))
			print(name + " is not in HC.","red");
		else if (!stone(name))
			print(name + " has an intact stone.","red");
	}
}