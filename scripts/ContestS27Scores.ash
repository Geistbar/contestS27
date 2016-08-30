script "ContestS27Scores.ash"

/*******************************************************
*	ContestS27Scores
*
*	Checks the winningest score of every player in 
*	the S27 back to school contest. Prints the scores
*	in order from highest to lowest.
/*******************************************************/

int [string] data;	// Map for ids to be stored in
int id;				// Temporary placeholder
boolean[string] names = $strings[efot, LadyJ, Margaret Houlihan, Somersaulter, Mister Mickey, DoubleGold, MagicToast, CzarWhuzHere666, Monechetti, Isladar, asmithsgirl, Starbearer, Ninamo, Marge, MarenG9, Quintavirus, Nienor, lagoticspy, TwoHearted_Flail, Reso, Big Daddy Grimm, Mana Yachanichu, CherryJ, Mirrorshades, wrldwzrd89, Laidak, greycat, Commander Vimes, Lynn Gwynny, EstroJenn, LanioX, jojomojo, DarthNoob7, chameco, Bilfred, Baden, dogletta, ilee, Ouro Boros, rainierburger, Bale, TwirlyRotini, Zen00, Argwarg, Syi, chotoobo, nagyss, FinaiAttack, Actually Steve, Hendrix788, Tiny Plastic Xairon, StiffKnees, Mr Gravy, Ravien, Lhopitals, BabyScarface, Louis of Apshai, MasterSilex, Eevilcat];
string[string] output;

/*******************************************************
*					int fameTaken(string player)
*	Calculates the amount of fame taken by the target
*	player. Returns the highest nue of HC or Normal.
/*******************************************************/
int winningest(string player)
{
	int score;
	string page = visit_url("showplayer.php?who=" + data[player]);
	matcher winningest = create_matcher("(?<=(HC Winningness:</b></td><td>))([0-9,]+)(?!</tr><tr>)",page);
	//matcher winningest = create_matcher("([0-9,]+)(?=<b>HC Winningness:</b></td><td>)",page);
	
	if (find(winningest))
		score = group(winningest).to_int();
	return score;
}

void main()
{
	foreach name in names
	{
		id = get_player_id(name).to_int();
		data[name] = id;
	}
	print("--------------------------","green");	// Formating
	foreach name in names							// Calculate score
		output[name] = winningest(name);
	int largest; int times; string player;
	while (times < count(names))					// Output scores in order, highest first
	{
		foreach name in names
		{
			if (output[name].to_int() > largest)
			{
				largest = output[name].to_int();
				player = name;
			}
		}
		print(player + ": " + output[player]);
		output[player] = -1; largest = -1; times+=1;
	}
}