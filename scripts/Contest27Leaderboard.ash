script "Contest27Leaderboard.ash"

/*******************************************************
*	Contest27Leaderboard
*
*	Lists the people on the HC winningest boards. 
*	If someone is a member of the contest, their name
*	is recolored to stand out.
/*******************************************************/

boolean[string] names = $strings[efot, ladyj, margaret houlihan, somersaulter, mister mickey, doublegold, magictoast, czarwhuzhere666, monechetti, isladar, asmithsgirl, starbearer, ninamo, marge, mareng9, quintavirus, nienor, lagoticspy, twohearted_flail, reso, big daddy grimm, mana yachanichu, cherryj, mirrorshades, wrldwzrd89, laidak, greycat, commander vimes, lynn gwynny, estrojenn, laniox, jojomojo, darthnoob7, chameco, bilfred, baden, dogletta, ilee, ouro boros, rainierburger,  bale, twirlyrotini, zen00, argwarg, syi, chotoobo, nagyss, finaiattack, actually steve, hendrix788, tiny plastic xairon, stiffknees, mr gravy, ravien, lhopitals, babyscarface, louis of apshai, mastersilex, eevilcat];

void main()
{
	int times; int prizes; int boards; string name;
	string page = visit_url("peevpee.php?place=boards");
	int index = index_of(page,"Hardcore&nbsp;Winningest");
	page = substring(page,index_of(page,"Hardcore&nbsp;Winningest"));
	matcher winningest = create_matcher("(?<=(\">))([A-z0-9 ]+)(?=&nbsp;&nbsp;&nbsp;)",page);
	// matcher winningest = create_matcher("(?<=(\">))([0-9,]+)(?!&nbsp;&nbsp;&nbsp;)",page); // Finds scores!
	
	while (find(winningest))
	{
		name = group(winningest);
		if (times > 29)
			times += 1;
		else
		{
			if (names contains name.to_lower_case())
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