/* 
	Import script for NPPES NPI data from CMS. 
	By: Steven Smith, Univ. of Florida.
	Last tested with May 2020 release 

	Note: there is some arbitrariness to the variable names, as NPPES
	does not provide headers that conform to typical variable name sizes, 
	but instead what are essentially long labels as headers. I've tried
	to be as descriptive as possible in the variable names. The CMS-
	supplied headers are applied as labels below. 
*/

*permanent storage library path;
libname pstore "E:\DATA\NPPES_NPI\SAS_datasets";

*path for NPI data file (CSV);
%let source_npi = E:\DATA\NPPES_NPI\Source_data\npidata_pfile_20050523-20200510.csv ;

*path for practice location reference file (CSV);
%let source_pl_ref = E:\DATA\NPPES_NPI\Source_data\pl_pfile_20050523-20200510.csv ;

*path for other name reference file (CSV);
%let source_othname_ref = E:\DATA\NPPES_NPI\Source_data\othername_pfile_20050523-20200510.csv ;



%macro npi_repeaters1;
	%local i;
	%do i = 1 %to 15;
		ptaxcode&i $10. plicnum&i $20. plicstate&i $2. pprimtax&i $1. 
	%end;
%mend;
%macro npi_repeaters1a;
	%local i;
	%do i = 1 %to 15;
		ptaxcode&i $ plicnum&i $ plicstate&i $ pprimtax&i $ 
	%end;
%mend;
%macro npi_repeaters2;
	%local i;
	%do i = 1 %to 50;
		othpid&i $20. othpidty&i $2. othpidst&i $2. othpidiss&i $80. 
	%end; 
%mend;
%macro npi_repeaters2a;
	%local i;
	%do i = 1 %to 50;
		othpid&i $ othpidty&i $ othpidst&i $ othpidiss&i $ 
	%end; 
%mend;
%macro npi_repeaters3;
	%local i;
	%do i = 1 %to 15;
		ptaxgroup&i $10. 
	%end;
%mend;
%macro npi_repeaters3a;
	%local i;
	%do i = 1 %to 15;
		ptaxgroup&i $  
	%end;
%mend;


data pstore.npi_2020_05;
	%let _EFIERR_ = 0;
	infile "&source_npi" delimiter=',' DSD missover firstobs=2;
	informat npi $10. entity $1. replacement_npi $10. ein $9. porgname $70. plname $35. pfname $20. pmname $20. pnameprefix $5. pnamesuffix $5.
		pcredential $20. porgnameoth $70. porgnameothcode $1. plnameoth $35. pfnameoth $20. pmnameoth $20. pnameprefixoth $5. 
		pnamesuffixoth $5. pcredentialoth $20. plnamecode $1. pmailline1 $55. pmailline2 $55. pmailcityname $33. pmailstatename $40. 
		pmailzip $17. pmailcountry $2. pmailtel $20. pmailfax $20. plocline1 $55. plocline2 $55. ploccityname $40. plocstatename $40.
		ploczip $20. ploccountry $2. ploctel $20. plocfax $20. penumdate mmddyy10. lastupdate mmddyy10. 
		npideactreason $2. npideactdate mmddyy10. npireactdate mmddyy10. pgender $1. aolname $35. aofname $20. aomname $20. aotitle $35.
		aotelnum $20. %npi_repeaters1 %npi_repeaters2 soleprop $1. orgsubpart $1. parent_org_lbn $70. parent_org_tin $9. aoname_prefix $5. 
		aoname_suffix $5. aocredential $20. %npi_repeaters3 certification_date mmddyy10. ;
	format npi $10. entity $1. replacement_npi $10. ein $9. porgname $70. plname $35. pfname $20. pmname $20. pnameprefix $5. pnamesuffix $5.
		pcredential $20. porgnameoth $70. porgnameothcode $1. plnameoth $35. pfnameoth $20. pmnameoth $20. pnameprefixoth $5. 
		pnamesuffixoth $5. pcredentialoth $20. plnamecode $1. pmailline1 $55. pmailline2 $55. pmailcityname $33. pmailstatename $40. 
		pmailzip $17. pmailcountry $2. pmailtel $20. pmailfax $20. plocline1 $55. plocline2 $55. ploccityname $40. plocstatename $40.
		ploczip $20. ploccountry $2. ploctel $20. plocfax $20. penumdate mmddyy10. lastupdate mmddyy10. 
		npideactreason $2. npideactdate mmddyy10. npireactdate mmddyy10. pgender $1. aolname $35. aofname $20. aomname $20. aotitle $35.
		aotelnum $20. %npi_repeaters1 %npi_repeaters2 soleprop $1. orgsubpart $1. parent_org_lbn $70. parent_org_tin $9. aoname_prefix $5. 
		aoname_suffix $5. aocredential $20. %npi_repeaters3 certification_date mmddyy10. ;
	input npi $ entity $ replacement_npi $ ein $ porgname $ plname $ pfname $ pmname $ pnameprefix $ pnamesuffix $
		pcredential $ porgnameoth $ porgnameothcode $ plnameoth $ pfnameoth $ pmnameoth $ pnameprefixoth $ 
		pnamesuffixoth $ pcredentialoth $ plnamecode $ pmailline1 $ pmailline2 $ pmailcityname $ pmailstatename $ 
		pmailzip $ pmailcountry $ pmailtel $ pmailfax $ plocline1 $ plocline2 $ ploccityname $ plocstatename $
		ploczip $ ploccountry $ ploctel $ plocfax $ penumdate lastupdate  
		npideactreason $ npideactdate npireactdate pgender $ aolname $ aofname $ aomname $ aotitle $
		aotelnum $ %npi_repeaters1a %npi_repeaters2a soleprop $ orgsubpart $ parent_org_lbn $ parent_org_tin $ aoname_prefix $ 
		aoname_suffix $ aocredential $ %npi_repeaters3a certification_date ; 
	label
		npi = 'National Provider Identifier (NPI)'
		entity = 'Entity Type Code'
		replacement_npi = 'Replacement NPI'
		ein = 'Employer Identification Number (EIN)'
		porgname = 'Provider Organization Name (Legal Business Name)'
		plname = 'Provider Last Name (Legal Name)'
		pfname = 'Provider First Name'
		pmname = 'Provider Middle Name'
		pnameprefix = 'Provider Name Prefix Text'
		pnamesuffix = 'Provider Name Suffix Text'
		pcredential = 'Provider Credential Text'
		porgnameoth = 'Provider Other Organization Name'
		porgnameothcode = 'Provider Other Organization Name Type Code'
		plnameoth = 'Provider Other Last Name'
		pfnameoth = 'Provider Other First Name'
		pmnameoth = 'Provider Other Middle Name'
		pnameprefixoth = 'Provider Other Name Prefix Text'
		pnamesuffixoth = 'Provider Other Name Suffix Text'
		pcredentialoth = 'Provider Other Credential Text'
		plnamecode = 'Provider Other Last Name Type Code'
		pmailline1 = 'Provider First Line Business Mailing Address'
		pmailline2 = 'Provider Second Line Business Mailing Address'
		pmailcityname = 'Provider Business Mailing Address City Name'
		pmailstatename = 'Provider Business Mailing Address State Name'
		pmailzip = 'Provider Business Mailing Address Postal Code'
		pmailcountry = 'Provider Business Mailing Address Country Code (If outside U.S.)'
		pmailtel = 'Provider Business Mailing Address Telephone Number'
		pmailfax = 'Provider Business Mailing Address Fax Number'
		plocline1 = 'Provider First Line Business Practice Location Address'
		plocline2 = 'Provider Second Line Business Practice Location Address'
		ploccityname = 'Provider Business Practice Location Address City Name'
		plocstatename = 'Provider Business Practice Location Address State Name'
		ploczip = 'Provider Business Practice Location Address Postal Code'
		ploccountry = 'Provider Business Practice Location Address Country Code (If outside U.S.)'
		ploctel = 'Provider Business Practice Location Address Telephone Number'
		plocfax = 'Provider Business Practice Location Address Fax Number'
	/*	plocpracline1 = 'Provider First Line Business Practice Location Address'
		plocpracline2 = 'Provider Second Line Business Practice Location Address' 
		plocpraccityname = 'Provider Business Practice Location Address City Name' 
		plocpracstatename = 'Provider Business Practice Location Address State Name' 
		plocpraczip = 'Provider Business Practice Location Address Postal Code' 
		plocpraccountry = 'Provider Business Practice Location Address Country Code (If outside U.S.)' 
		plocpractel = 'Provider Business Practice Location Address Telephone Number'
		plocpracfax = 'Provider Business Practice Location Address Fax Number' */
		penumdate = 'Provider Enumeration Date'
		lastupdate = 'Last Update Date'
		npideactreason = 'NPI Deactivation Reason Code'
		npideactdate = 'NPI Deactivation Date'
		npireactdate = 'NPI Reactivation Date'
		pgender = 'Provider Gender Code'
		aolname = 'Authorized Official Last Name'
		aofname = 'Authorized Official First Name'
		aomname = 'Authorized Official Middle Name'
		aotitle = 'Authorized Official Title or Position'
		aotelnum = 'Authorized Official Telephone Number'
		ptaxcode1 = 'Healthcare Provider Taxonomy Code 1'
		plicnum1 = 'Provider License Number 1'
		plicstate1 = 'Provider License Number State Code 1'
		pprimtax1 = 'Healthcare Provider Primary Taxonomy Switch 1'
		ptaxcode2 = 'Healthcare Provider Taxonomy Code 2'
		plicnum2 = 'Provider License Number 2'
		plicstate2 = 'Provider License Number State Code 2'
		pprimtax2 = 'Healthcare Provider Primary Taxonomy Switch 2'
		ptaxcode3 = 'Healthcare Provider Taxonomy Code 3'
		plicnum3 = 'Provider License Number 3'
		plicstate3 = 'Provider License Number State Code 3'
		pprimtax3 = 'Healthcare Provider Primary Taxonomy Switch 3'
		ptaxcode4 = 'Healthcare Provider Taxonomy Code 4'
		plicnum4 = 'Provider License Number 4'
		plicstate4 = 'Provider License Number State Code 4'
		pprimtax4 = 'Healthcare Provider Primary Taxonomy Switch 4'
		ptaxcode5 = 'Healthcare Provider Taxonomy Code 5'
		plicnum5 = 'Provider License Number 5'
		plicstate5 = 'Provider License Number State Code 5'
		pprimtax5 = 'Healthcare Provider Primary Taxonomy Switch 5'
		ptaxcode6 = 'Healthcare Provider Taxonomy Code 6'
		plicnum6 = 'Provider License Number 6'
		plicstate6 = 'Provider License Number State Code 6'
		pprimtax6 = 'Healthcare Provider Primary Taxonomy Switch 6'
		ptaxcode7 = 'Healthcare Provider Taxonomy Code 7'
		plicnum7 = 'Provider License Number 7'
		plicstate7 = 'Provider License Number State Code 7'
		pprimtax7 = 'Healthcare Provider Primary Taxonomy Switch 7'
		ptaxcode8 = 'Healthcare Provider Taxonomy Code 8'
		plicnum8 = 'Provider License Number 8'
		plicstate8 = 'Provider License Number State Code 8'
		pprimtax8 = 'Healthcare Provider Primary Taxonomy Switch 8'
		ptaxcode9 = 'Healthcare Provider Taxonomy Code 9'
		plicnum9 = 'Provider License Number 9'
		plicstate9 = 'Provider License Number State Code 9'
		pprimtax9 = 'Healthcare Provider Primary Taxonomy Switch 9'
		ptaxcode10 = 'Healthcare Provider Taxonomy Code 10'
		plicnum10 = 'Provider License Number 10'
		plicstate10 = 'Provider License Number State Code 10'
		pprimtax10 = 'Healthcare Provider Primary Taxonomy Switch 10'
		ptaxcode11 = 'Healthcare Provider Taxonomy Code 11'
		plicnum11 = 'Provider License Number 11'
		plicstate11 = 'Provider License Number State Code 11'
		pprimtax11 = 'Healthcare Provider Primary Taxonomy Switch 11'
		ptaxcode12 = 'Healthcare Provider Taxonomy Code 12'
		plicnum12 = 'Provider License Number 12'
		plicstate12 = 'Provider License Number State Code 12'
		pprimtax12 = 'Healthcare Provider Primary Taxonomy Switch 12'
		ptaxcode13 = 'Healthcare Provider Taxonomy Code 13'
		plicnum13 = 'Provider License Number 13'
		plicstate13 = 'Provider License Number State Code 13'
		pprimtax13 = 'Healthcare Provider Primary Taxonomy Switch 13'
		ptaxcode14 = 'Healthcare Provider Taxonomy Code 14'
		plicnum14 = 'Provider License Number 14'
		plicstate14 = 'Provider License Number State Code 14'
		pprimtax14 = 'Healthcare Provider Primary Taxonomy Switch 14'
		ptaxcode15 = 'Healthcare Provider Taxonomy Code 15'
		plicnum15 = 'Provider License Number 15'
		plicstate15 = 'Provider License Number State Code 15'
		pprimtax15 = 'Healthcare Provider Primary Taxonomy Switch 15'
		othpid1 = 'Other Provider Identifier 1'
		othpidty1 = 'Other Provider Identifier Type Code 1'
		othpidst1 = 'Other Provider Identifier State 1'
		othpidiss1 = 'Other Provider Identifier Issuer 1'
		othpid2 = 'Other Provider Identifier 2'
		othpidty2 = 'Other Provider Identifier Type Code 2'
		othpidst2 = 'Other Provider Identifier State 2'
		othpidiss2 = 'Other Provider Identifier Issuer 2'
		othpid3 = 'Other Provider Identifier 3'
		othpidty3 = 'Other Provider Identifier Type Code 3'
		othpidst3 = 'Other Provider Identifier State 3'
		othpidiss3 = 'Other Provider Identifier Issuer 3'
		othpid4 = 'Other Provider Identifier 4'
		othpidty4 = 'Other Provider Identifier Type Code 4'
		othpidst4 = 'Other Provider Identifier State 4'
		othpidiss4 = 'Other Provider Identifier Issuer 4'
		othpid5 = 'Other Provider Identifier 5'
		othpidty5 = 'Other Provider Identifier Type Code 5'
		othpidst5 = 'Other Provider Identifier State 5'
		othpidiss5 = 'Other Provider Identifier Issuer 5'
		othpid6 = 'Other Provider Identifier 6'
		othpidty6 = 'Other Provider Identifier Type Code 6'
		othpidst6 = 'Other Provider Identifier State 6'
		othpidiss6 = 'Other Provider Identifier Issuer 6'
		othpid7 = 'Other Provider Identifier 7'
		othpidty7 = 'Other Provider Identifier Type Code 7'
		othpidst7 = 'Other Provider Identifier State 7'
		othpidiss7 = 'Other Provider Identifier Issuer 7'
		othpid8 = 'Other Provider Identifier 8'
		othpidty8 = 'Other Provider Identifier Type Code 8'
		othpidst8 = 'Other Provider Identifier State 8'
		othpidiss8 = 'Other Provider Identifier Issuer 8'
		othpid9 = 'Other Provider Identifier 9'
		othpidty9 = 'Other Provider Identifier Type Code 9'
		othpidst9 = 'Other Provider Identifier State 9'
		othpidiss9 = 'Other Provider Identifier Issuer 9'
		othpid10 = 'Other Provider Identifier 10'
		othpidty10 = 'Other Provider Identifier Type Code 10'
		othpidst10 = 'Other Provider Identifier State 10'
		othpidiss10 = 'Other Provider Identifier Issuer 10'
		othpid11 = 'Other Provider Identifier 11'
		othpidty11 = 'Other Provider Identifier Type Code 11'
		othpidst11 = 'Other Provider Identifier State 11'
		othpidiss11 = 'Other Provider Identifier Issuer 11'
		othpid12 = 'Other Provider Identifier 12'
		othpidty12 = 'Other Provider Identifier Type Code 12'
		othpidst12 = 'Other Provider Identifier State 12'
		othpidiss12 = 'Other Provider Identifier Issuer 12'
		othpid13 = 'Other Provider Identifier 13'
		othpidty13 = 'Other Provider Identifier Type Code 13'
		othpidst13 = 'Other Provider Identifier State 13'
		othpidiss13 = 'Other Provider Identifier Issuer 13'
		othpid14 = 'Other Provider Identifier 14'
		othpidty14 = 'Other Provider Identifier Type Code 14'
		othpidst14 = 'Other Provider Identifier State 14'
		othpidiss14 = 'Other Provider Identifier Issuer 14'
		othpid15 = 'Other Provider Identifier 15'
		othpidty15 = 'Other Provider Identifier Type Code 15'
		othpidst15 = 'Other Provider Identifier State 15'
		othpidiss15 = 'Other Provider Identifier Issuer 15'
		othpid16 = 'Other Provider Identifier 16'
		othpidty16 = 'Other Provider Identifier Type Code 16'
		othpidst16 = 'Other Provider Identifier State 16'
		othpidiss16 = 'Other Provider Identifier Issuer 16'
		othpid17 = 'Other Provider Identifier 17'
		othpidty17 = 'Other Provider Identifier Type Code 17'
		othpidst17 = 'Other Provider Identifier State 17'
		othpidiss17 = 'Other Provider Identifier Issuer 17'
		othpid18 = 'Other Provider Identifier 18'
		othpidty18 = 'Other Provider Identifier Type Code 18'
		othpidst18 = 'Other Provider Identifier State 18'
		othpidiss18 = 'Other Provider Identifier Issuer 18'
		othpid19 = 'Other Provider Identifier 19'
		othpidty19 = 'Other Provider Identifier Type Code 19'
		othpidst19 = 'Other Provider Identifier State 19'
		othpidiss19 = 'Other Provider Identifier Issuer 19'
		othpid20 = 'Other Provider Identifier 20'
		othpidty20 = 'Other Provider Identifier Type Code 20'
		othpidst20 = 'Other Provider Identifier State 20'
		othpidiss20 = 'Other Provider Identifier Issuer 20'
		othpid21 = 'Other Provider Identifier 21'
		othpidty21 = 'Other Provider Identifier Type Code 21'
		othpidst21 = 'Other Provider Identifier State 21'
		othpidiss21 = 'Other Provider Identifier Issuer 21'
		othpid22 = 'Other Provider Identifier 22'
		othpidty22 = 'Other Provider Identifier Type Code 22'
		othpidst22 = 'Other Provider Identifier State 22'
		othpidiss22 = 'Other Provider Identifier Issuer 22'
		othpid23 = 'Other Provider Identifier 23'
		othpidty23 = 'Other Provider Identifier Type Code 23'
		othpidst23 = 'Other Provider Identifier State 23'
		othpidiss23 = 'Other Provider Identifier Issuer 23'
		othpid24 = 'Other Provider Identifier 24'
		othpidty24 = 'Other Provider Identifier Type Code 24'
		othpidst24 = 'Other Provider Identifier State 24'
		othpidiss24 = 'Other Provider Identifier Issuer 24'
		othpid25 = 'Other Provider Identifier 25'
		othpidty25 = 'Other Provider Identifier Type Code 25'
		othpidst25 = 'Other Provider Identifier State 25'
		othpidiss25 = 'Other Provider Identifier Issuer 25'
		othpid26 = 'Other Provider Identifier 26'
		othpidty26 = 'Other Provider Identifier Type Code 26'
		othpidst26 = 'Other Provider Identifier State 26'
		othpidiss26 = 'Other Provider Identifier Issuer 26'
		othpid27 = 'Other Provider Identifier 27'
		othpidty27 = 'Other Provider Identifier Type Code 27'
		othpidst27 = 'Other Provider Identifier State 27'
		othpidiss27 = 'Other Provider Identifier Issuer 27'
		othpid28 = 'Other Provider Identifier 28'
		othpidty28 = 'Other Provider Identifier Type Code 28'
		othpidst28 = 'Other Provider Identifier State 28'
		othpidiss28 = 'Other Provider Identifier Issuer 28'
		othpid29 = 'Other Provider Identifier 29'
		othpidty29 = 'Other Provider Identifier Type Code 29'
		othpidst29 = 'Other Provider Identifier State 29'
		othpidiss29 = 'Other Provider Identifier Issuer 29'
		othpid30 = 'Other Provider Identifier 30'
		othpidty30 = 'Other Provider Identifier Type Code 30'
		othpidst30 = 'Other Provider Identifier State 30'
		othpidiss30 = 'Other Provider Identifier Issuer 30'
		othpid31 = 'Other Provider Identifier 31'
		othpidty31 = 'Other Provider Identifier Type Code 31'
		othpidst31 = 'Other Provider Identifier State 31'
		othpidiss31 = 'Other Provider Identifier Issuer 31'
		othpid32 = 'Other Provider Identifier 32'
		othpidty32 = 'Other Provider Identifier Type Code 32'
		othpidst32 = 'Other Provider Identifier State 32'
		othpidiss32 = 'Other Provider Identifier Issuer 32'
		othpid33 = 'Other Provider Identifier 33'
		othpidty33 = 'Other Provider Identifier Type Code 33'
		othpidst33 = 'Other Provider Identifier State 33'
		othpidiss33 = 'Other Provider Identifier Issuer 33'
		othpid34 = 'Other Provider Identifier 34'
		othpidty34 = 'Other Provider Identifier Type Code 34'
		othpidst34 = 'Other Provider Identifier State 34'
		othpidiss34 = 'Other Provider Identifier Issuer 34'
		othpid35 = 'Other Provider Identifier 35'
		othpidty35 = 'Other Provider Identifier Type Code 35'
		othpidst35 = 'Other Provider Identifier State 35'
		othpidiss35 = 'Other Provider Identifier Issuer 35'
		othpid36 = 'Other Provider Identifier 36'
		othpidty36 = 'Other Provider Identifier Type Code 36'
		othpidst36 = 'Other Provider Identifier State 36'
		othpidiss36 = 'Other Provider Identifier Issuer 36'
		othpid37 = 'Other Provider Identifier 37'
		othpidty37 = 'Other Provider Identifier Type Code 37'
		othpidst37 = 'Other Provider Identifier State 37'
		othpidiss37 = 'Other Provider Identifier Issuer 37'
		othpid38 = 'Other Provider Identifier 38'
		othpidty38 = 'Other Provider Identifier Type Code 38'
		othpidst38 = 'Other Provider Identifier State 38'
		othpidiss38 = 'Other Provider Identifier Issuer 38'
		othpid39 = 'Other Provider Identifier 39'
		othpidty39 = 'Other Provider Identifier Type Code 39'
		othpidst39 = 'Other Provider Identifier State 39'
		othpidiss39 = 'Other Provider Identifier Issuer 39'
		othpid40 = 'Other Provider Identifier 40'
		othpidty40 = 'Other Provider Identifier Type Code 40'
		othpidst40 = 'Other Provider Identifier State 40'
		othpidiss40 = 'Other Provider Identifier Issuer 40'
		othpid41 = 'Other Provider Identifier 41'
		othpidty41 = 'Other Provider Identifier Type Code 41'
		othpidst41 = 'Other Provider Identifier State 41'
		othpidiss41 = 'Other Provider Identifier Issuer 41'
		othpid42 = 'Other Provider Identifier 42'
		othpidty42 = 'Other Provider Identifier Type Code 42'
		othpidst42 = 'Other Provider Identifier State 42'
		othpidiss42 = 'Other Provider Identifier Issuer 42'
		othpid43 = 'Other Provider Identifier 43'
		othpidty43 = 'Other Provider Identifier Type Code 43'
		othpidst43 = 'Other Provider Identifier State 43'
		othpidiss43 = 'Other Provider Identifier Issuer 43'
		othpid44 = 'Other Provider Identifier 44'
		othpidty44 = 'Other Provider Identifier Type Code 44'
		othpidst44 = 'Other Provider Identifier State 44'
		othpidiss44 = 'Other Provider Identifier Issuer 44'
		othpid45 = 'Other Provider Identifier 45'
		othpidty45 = 'Other Provider Identifier Type Code 45'
		othpidst45 = 'Other Provider Identifier State 45'
		othpidiss45 = 'Other Provider Identifier Issuer 45'
		othpid46 = 'Other Provider Identifier 46'
		othpidty46 = 'Other Provider Identifier Type Code 46'
		othpidst46 = 'Other Provider Identifier State 46'
		othpidiss46 = 'Other Provider Identifier Issuer 46'
		othpid47 = 'Other Provider Identifier 47'
		othpidty47 = 'Other Provider Identifier Type Code 47'
		othpidst47 = 'Other Provider Identifier State 47'
		othpidiss47 = 'Other Provider Identifier Issuer 47'
		othpid48 = 'Other Provider Identifier 48'
		othpidty48 = 'Other Provider Identifier Type Code 48'
		othpidst48 = 'Other Provider Identifier State 48'
		othpidiss48 = 'Other Provider Identifier Issuer 48'
		othpid49 = 'Other Provider Identifier 49'
		othpidty49 = 'Other Provider Identifier Type Code 49'
		othpidst49 = 'Other Provider Identifier State 49'
		othpidiss49 = 'Other Provider Identifier Issuer 49'
		othpid50 = 'Other Provider Identifier 50'
		othpidty50 = 'Other Provider Identifier Type Code 50'
		othpidst50 = 'Other Provider Identifier State 50'
		othpidiss50 = 'Other Provider Identifier Issuer 50'
		soleprop = 'Is Sole Proprietor'
		orgsubpart = 'Is Organization Subpart'
		parent_org_lbn = 'Parent Organization Legal Business Name'
		parent_org_tin = 'Parent Organization TIN'
		aoname_prefix = 'Authorized Official Name Prefix Text'
		aoname_suffix = 'Authorized Official Name Suffix Text'
		aocredential = 'Authorized Official Credential Text'
		ptaxgroup1 = 'Healthcare Provider Taxonomy Group 1'
		ptaxgroup2 = 'Healthcare Provider Taxonomy Group 2'
		ptaxgroup3 = 'Healthcare Provider Taxonomy Group 3'
		ptaxgroup4 = 'Healthcare Provider Taxonomy Group 4'
		ptaxgroup5 = 'Healthcare Provider Taxonomy Group 5'
		ptaxgroup6 = 'Healthcare Provider Taxonomy Group 6'
		ptaxgroup7 = 'Healthcare Provider Taxonomy Group 7'
		ptaxgroup8 = 'Healthcare Provider Taxonomy Group 8'
		ptaxgroup9 = 'Healthcare Provider Taxonomy Group 9'
		ptaxgroup10 = 'Healthcare Provider Taxonomy Group 10'
		ptaxgroup11 = 'Healthcare Provider Taxonomy Group 11'
		ptaxgroup12 = 'Healthcare Provider Taxonomy Group 12'
		ptaxgroup13 = 'Healthcare Provider Taxonomy Group 13'
		ptaxgroup14 = 'Healthcare Provider Taxonomy Group 14'
		ptaxgroup15 = 'Healthcare Provider Taxonomy Group 15'
		certification_date = 'Certification Date'
	;
	if _ERROR_ then call symputx('_EFIERR_',1);
run;


/* Practice Location Reference File */
data pstore.npi_pl_ref_2020_05 ;
	%let _EFIERR_ = 0;
	infile "&source_pl_ref" delimiter=',' DSD missover firstobs=2;
	informat npi $10. pseclocline1 $55. pseclocline2 $55. psecloccityname $40. pseclocstatename $40.
		psecloczip $20. psecloccountry $2. psecloctel $20. psecloctelex $5. pseclocfax $20.  ;
	format npi $10. pseclocline1 $55. pseclocline2 $55. psecloccityname $40. pseclocstatename $40.
		psecloczip $20. psecloccountry $2. psecloctel $20. psecloctelex $5. pseclocfax $20.  ;
	input npi $ pseclocline1 $ pseclocline2 $ psecloccityname $ pseclocstatename $
		psecloczip $ psecloccountry $ psecloctel $ psecloctelex $ pseclocfax $  ; 
	label
		npi = 'NPI' 
		pseclocline1 = 'Provider Secondary Practice Location Address- Address Line 1'
		pseclocline2 = 'Provider Secondary Practice Location Address- Address Line 2' 
		psecloccityname = 'Provider Secondary Practice Location Address- City Name'
		pseclocstatename = 'Provider Secondary Practice Location Address- State Name'
		psecloczip = 'Provider Secondary Practice Location Address- Postal Code'
		psecloccountry = 'Provider Secondary Practice Location Address- Country Code (If outside U.S.)'
		psecloctel = 'Provider Secondary Practice Location Address- Telephone Number'
		psecloctelex = 'Provider Secondary Practice Location Address- Telephone Extension'
		pseclocfax = 'Provider Secondary Practice Location Address- Fax Number'
	;
	if _ERROR_ then call symputx('_EFIERR_',1);
run;


/* Other Name Reference File */
data pstore.npi_othname_ref_2020_05 ;
	%let _EFIERR_ = 0;
	infile "&source_othname_ref" delimiter=',' DSD missover firstobs=2;
	informat npi $10. porgnameoth $120. porgnameothcode $1. ;
	format npi $10. porgnameoth $120. porgnameothcode $1. ;
	input npi $ porgnameoth $ porgnameothcode $ ;
	label
		npi = 'NPI' 
		porgnameoth = 'Provider Other Organization Name'
		porgnameothcode = 'Provider Other Organization Name Type Code'
	;
	if _ERROR_ then call symputx('_EFIERR_',1);
run;

