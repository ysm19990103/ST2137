/*ST2137_tut1 */
data htwt;
	infile '~/tut1htwt.csv' delimiter=";" firstobs=2;
	input id  gender $ height weight siblings;
	
data test;
	infile '~/tut1test.csv' delimiter=";" firstobs=2;
	input id test;
	
data htwtf;
	set htwt;
	where (gender="F");
run;

proc sort data=htwt;
	by id;
proc sort data=test;
	by id;
data htwttest;
	merge htwt test;
	by id;
run;

data tall;
	set htwttest;
	where (height>184);
run;

data htwtfixed;
	infile '~/tut1htwtfixed.txt' firstobs=2;
	input id 1-3 gender $ 4 height 5-7 weight 8-9 siblings 10;
run;

/*want to remove some data point from the dataset*/
data htwtfixedremo;
	set htwtfixed;
	where (id^=356);
	
/*the third tallest female in this group */
proc sort data=htwtf;
	 by descending height;

data rankedf;
	set htwtf;
	ranking=_n_; /*_n_ denotes the number that it has gone through the loop */
run;

data selectf;
	set rankedf;
	where ranking=3;
run;

/* how many male students get F */
data htwtgrade;
	set htwttest;
	if test>=80 then grade="A";
		else if test>=70 then grade="B";
			else if test>=60 then grade="C";
				else if test>=50 then grade="D";
					else grade="F";
run;

data malefstudents;
	set htwtgrade;
	where (grade="F" & gender="M");
run;

/*study on glass transition temperature of a certain polymer compound. 3*4 table */
data batchtemp;
	do batch=1 to 3;
		do treatment=1 to 4;
			input temperature @@;
			output;
			/* The OUTPUT statement tells SAS to write the current observation 
			to a SAS data set immediately, not at the end of the DATA step. 
			If no data set name is specified in the OUTPUT statement, the 
			observation is written to the data set or data sets that are 
			listed in the DATA statement. If do not use output statement here, 
			will only contain 4,5,257 in the output table*/
		end;
	end;
		
	datalines;
	303 311 289 270 242 290 259 263 289 282 277 257
	;
run;

/*input same dataset without using loops */
/*@@ Tell SAS to read data until there is no data, THEN go to the next row */
data batchtemp2;
	input batch treatment temperature @@;
	datalines;
	1 1 303 1 2 311 1 3 289 1 4 270 2 1 242 2 2 290 2 3 259 2 4 263 3 1 289 3 2 282 3 3 277 3 4 257
	;
run;

data missvalue;
	do batch=1 to 3;
		do treatment=1 to 4;
			input temperature @@;
			output;
		end;
	end;
	datalines;
	303 311 289 270 242 . 259 263 289 282 277 257
	;
run;
			
data missvalue2;
	input batch treatment temperature @@;
	datalines;
	1 1 303 1 2 311 1 3 289 1 4 270 2 1 242 2 2 . 2 3 259 2 4 263 3 1 289 3 2 282 3 3 277 3 4 25
	;
run;
/* proc print data=missvalue2;
run; to show the results */




	
	





	