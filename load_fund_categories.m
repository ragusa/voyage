function category = load_fund_categories

aa_balanced=[101 616 8 788 193 452 ];
aa_balanced=[101     8 788 193 452 ]; 

aa_LifeCycle=[1549	1537	768	747	1540	759	1543	1546	1162	762	1167	765];
aa_LifeCycle=[768 747 759 762 765 1167 1549 1537 1540 1543 1546 1162];
% using 2016Q4 grouping
aa_LifeCycle=[768     759 762 765 1167 1549     1540 1543 1546 1162 ];

aa_LifeStyle=[33	1601	32	1602	31];
% using 2016Q4 grouping

bond=[1001	833	1554	4	1003	422	439	178	787	1220	834];
bond=[4 178 422 439 787 833 834 1001 1003      1220 1554      7576]; 
% using 2016Q4 grouping
bond=[4 178 422     787 833 834 1001 1003 1041 1220 1554 6571 7576]; 


foreign_large=[1348	1551	107	573	830	1252	770	1586	228	818	1232	432	1331	190	779	1445];
foreign_large=[1348	1551	107	573	   	1252	770	1586	228	818	1232	432	1331	190	779	1445];
foreign_large=[1348 	1551	107	573	   	1252	770	1586	228	 	 	 	 	 	 	 ];
% using 2016Q4 grouping
foreign_large=[1348 	1551	107	573	   	1252	770	1586	];

glob=[818	1232	432	1331	190	779	1445];
% using 2016Q4 grouping
glob=[818	1232	432	1331	190	779	1445 3056];

large_blend=[79	1557	1120	133	1208	35	105	1	772	100	1307	];
large_blend=[79	1557	1120	133	1208	35	105	1	772	100		];
large_blend=[  	1557	1120	133	1208	35	 	1	772	 		];
% using 2016Q4 grouping
large_blend=[1595 1208 6620 079 3436 1 35 772 1557 264];

large_growth=[2713 109	742	111	1413	2015	76	572	1612	1584	];
large_growth=[2713 109	742	111	    	    	  	572	1612	1584 79 3384 ];
% using 2016Q4 grouping
large_growth=[1584 1612 572 133 109 3384 1120 742 2713 111 ];

large_value=[819	1595	108	1213	2711	437	264	617	789	1377];
large_value=[819	1595	108	1213	2711	437	264	617	789	1377];
% using 2016Q4 grouping
large_value=[819 1377 108 1213 2711 437 789 617 ];

mid_blend=[53	1560	7280	290	7007	187];
mid_blend=[53	1560	    	290	7007	187  1315 ];
% using 2016Q4 grouping
mid_blend=[53	1560	75    	290	7007	187  1315 ];

mid_growth=[81	2718	449	778	820];
% using 2016Q4 grouping
mid_growth=[81	2718	436 449	778	820];
 
mid_value=[435	75	1214	1008];
mid_value=[435	75	     	1008 7280];
% using 2016Q4 grouping
mid_value=[435	440	     	1008 7280];

small_blend=[752	832	52	1563	1315	42];
small_blend=[752	832	52	1563	    	42];
% using 2016Q4 grouping
small_blend=[1117 752	832	52	1563	    	42];

small_growth=[ 436	821	80];
% using 2016Q4 grouping
small_growth=[ 	821	80];

small_value=[191	1117	1218	440	73];
small_value=[191 73 1218 1117 440 2495];
% using 2016Q4 grouping
small_value=[191 73 1218 2495];

sector=[1019	1172	771	776	2656	1613	50	2040];
sector=[1019	1172	        2656	1613	    2040];
% using 2016Q4 grouping
sector=[1908 1776 1019	1172	        2656	1613	    1043];

fund{ 1}=aa_balanced;
fund{ 2}=aa_LifeCycle;
fund{ 3}=aa_LifeStyle;
fund{ 4}=bond;
fund{ 5}=foreign_large;
fund{ 6}=glob;
fund{ 7}=large_blend;
fund{ 8}=large_growth;
fund{ 9}=large_value;
fund{10}=mid_blend;
fund{11}=mid_growth;
fund{12}=mid_value;
fund{13}=small_blend;
fund{14}=small_growth;
fund{15}=small_value;
fund{16}=sector;

category.fund=fund;

names=char('aa'                );
names=char(names,'aaLC'        );
names=char(names,'aaLS'        );
names=char(names,'Bonds'       );
names=char(names,'foreign'     );
names=char(names,'global'      );
names=char(names,'large blend' );
names=char(names,'large growth');
names=char(names,'large value' );
names=char(names,'mid blend'   );
names=char(names,'mid growth'  );
names=char(names,'mid value'   );
names=char(names,'small blend' );
names=char(names,'small growth');
names=char(names,'small value' );
names=char(names,'sector'      );

category.names=names;

% list of fund IDs to exclude
category.fundID_excl=[2 3 5 6 19 7576 2495 6571 3056 2176];


end

