script "Contest27Leaderboard.ash"

/*******************************************************
*	Contest27Leaderboard
*
*	Lists the people on the HC winningest boards. 
*	If someone is a member of the contest, their name
*	is recolored to stand out.
/*******************************************************/

boolean[string] names = $strings[efot, LadyJ, Margaret Houlihan, Somersaulter, Mister Mickey, DoubleGold, MagicToast, CzarWhuzHere666, Monechetti, Isladar, asmithsgirl, Starbearer, Ninamo, Marge, MarenG9, Quintavirus, Nienor, lagoticspy, TwoHearted_Flail, Reso, Big Daddy Grimm, Mana Yachanichu, CherryJ, Mirrorshades, wrldwzrd89, Laidak, greycat, Commander Vimes, Lynn Gwynny, EstroJenn, LanioX, jojomojo, DarthNoob7, chameco, Bilfred, Baden, dogletta, ilee, Ouro Boros, rainierburger, Bale, TwirlyRotini, Zen00, Argwarg, Syi, chotoobo, nagyss, FinaiAttack, Actually Steve, Hendrix788, Tiny Plastic Xairon, StiffKnees, Mr Gravy, Ravien, Lhopitals, BabyScarface, Louis of Apshai, MasterSilex, Eevilcat];

void main()
{
	int times; int prizes; int boards; string name;
	string page = visit_url("peevpee.php?place=boards");
	matcher winningest = create_matcher("(?<=(\">))([A-z0-9 ]+)(?=&nbsp;&nbsp;&nbsp;)",page);
	// matcher winningest = create_matcher("(?<=(\">))([0-9,]+)(?!&nbsp;&nbsp;&nbsp;)",page); // Finds scores!
	
	while (find(winningest))
	{
		name = group(winningest);
		if (times < 150 || times > 179)
			times += 1;
		else
		{
			if (names contains name)
			{
				if (boards > 4 && prizes == 0)
				{
					print(name + " -- first place!","red");
					prizes += 1;
				}
				else if (boards > 4 && prizes == 1)
				{
					print(name + " -- second place!","red");
					prizes += 1;
				}
				else if (boards > 4 && prizes == 2)
				{
					print(name + " -- third place!","red");
					prizes += 1;
				}
				else
					print(name, "orange");
			}
			else
				print(name, "green");
			times += 1; boards +=1;
		}
	}
}