﻿601,100
562,"VIEW"
586,"myCube"
585,"myCube"
564,
565,"ispF[[xcIaasqIpax^dnTjG9OU9IooI=0K[SeG7N8Z;u;LWsi92hs;yKZ@^T[[l[[DamYh>=PZShKajAwzXNqOCRJP<eqNudz8hn2kT[41^4iq2>Eyg`veCT1v@>5hWlS>fwAduJbX?M0C?WzBtqAl>`jGEfHUSf=Cs9YdF^79FEih6WV>Nhrfadj6SwWG`W[BM:K@xB"
559,1
928,0
593,
594,
595,
597,
598,
596,
800,
801,
566,0
567,","
588,"."
589,
568,""""
570,z_TI_View
571,
569,0
592,0
599,1000
560,8
pCube
pDimension
pSourceElement
pTargetElement
pSkipRules
pZeroTarget
pZeroSource
pDebug
561,8
2
2
2
2
1
1
1
1
590,8
pCube,""
pDimension,""
pSourceElement,""
pTargetElement,""
pSkipRules,1.
pZeroTarget,1.
pZeroSource,0.
pDebug,0.
637,8
pCube,Cube
pDimension,Dimension to Copy Data
pSourceElement,Source Element
pTargetElement,Target Element
pSkipRules,Skip Rule Values? (1=Skip)
pZeroTarget,Zero out Target Element PRIOR to Copy? (Boolean 1=True)
pZeroSource,Zero out Source Element AFTER Copy? (Boolean 1=True)
pDebug,Debug Mode
577,25
v1
v2
v3
v4
v5
v6
v7
v8
v9
v10
v11
v12
v13
v14
v15
v16
v17
v18
v19
v20
v21
v22
v23
v24
v25
578,25
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
579,25
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
580,25
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
581,25
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
582,25
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
VarType=32€ColType=827€
572,250



#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################

# This TI is designed to copy all data in a given cube
# from one element to another, typically this would be within a
# version dimension but could equally well be used to copy data
# from one product to another or one week to another or on monthly basis.

# Note:
# - As this TI has a view as a data source it requires the implicit variables NValue, SValue and Value_is_String
# - To edit this TI without VIZIER either a temp cube with 24 dims is needed as the preview data source or set the data
#   source to ASCII and manually edit the TI in notepad after saving to add back the required implicit view variables


### Constants ###

cProcess = 'Bedrock.Cube.Data.Copy';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
cDebugFile = GetProcessErrorFileDirectory | cProcess | '.' | cTimeStamp | '.';


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Prolog.debug';

  # Log start time
  AsciiOutput( sDebugFile, 'Process Started: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

  # Log parameters
  AsciiOutput( sDebugFile, 'Parameters: pCube          : ' | pCube );
  AsciiOutput( sDebugFile, '            pDimension     : ' | pDimension );
  AsciiOutput( sDebugFile, '            pSourceElement : ' | pSourceElement );
  AsciiOutput( sDebugFile, '            pTargetElement : ' | pTargetElement );
  AsciiOutput( sDebugFile, '            pSkipRules     : ' | NumberToString( pSkipRules ) );
  AsciiOutput( sDebugFile, '            pZeroTarget    : ' | NumberToString( pZeroTarget ) );
  AsciiOutput( sDebugFile, '            pZeroSource    : ' | NumberToString( pZeroSource ) );

EndIf;


### Validate Parameters ###

nErrors = 0;

# If a valid cube has not been specified then terminate process
If( CubeExists( pCube ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid source cube specified: ' | pCube;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# If a valid source dimenion has not been specified then terminate process
If( DimensionExists( pDimension ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid dimension specified: ' | pDimension;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# If a valid source dimenion element has not been specified then terminate process
If( DimIx( pDimension, pSourceElement ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid source element specified: ' | pSourceElement;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# If a valid target dimenion element has not been specified then terminate process
If( DimIx( pDimension, pTargetElement ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid target element specified: ' | pTargetElement;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;


### Determine number of dims in source cube & check that specified dimension exists in cube ###

nDimensionCount = 0;
sDimension = TabDim( pCube, nDimensionCount + 1 );
nDimensionIndex = 0;
While( sDimension @<> '' );
  nDimensionCount = nDimensionCount + 1;
  If( sDimension @= pDimension );
    nDimensionIndex = nDimensionCount;
  EndIf;
  sDimension = TabDim( pCube, nDimensionCount + 1 );
End;

# If specified dim does not exist in cube then terminate process
If( nDimensionIndex = 0 );
  nErrors = 1;
  sMessage = 'Specified dimension: ' | pDimension | ' is not a component of the cube: ' | pCube;
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

# If dimension count exceeds the current maximum then terminate process
If( nDimensionCount > 24 );
  nErrors = 1;
  sMessage = 'Cube has too many dimensions: ' | pCube | '. Max 24 dims catered for, TI must be altered to accomodate.';
  If( pDebug >= 1 );
    AsciiOutput( sDebugFile, sMessage );
  EndIf;
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;


### Debug ###

If( pDebug >= 1 );
  AsciiOutput( sDebugFile, 'Dimension "' | pDimension | '" index: ' | NumberToString( nDimensionIndex ) );
  AsciiOutput( sDebugFile, 'Number of dimensions in ' | pCube | ' cube: ' | NumberToString( nDimensionCount ) );
  AsciiOutput( sDebugFile, 'Source element: ' | pSourceElement );
  AsciiOutput( sDebugFile, 'Target element: ' | pTargetElement );
EndIf;


### Determine dimensions in source cube ###

sDim1 = TabDim( pCube, 1 );
sDim2 = TabDim( pCube, 2 );
sDim3 = TabDim( pCube, 3 );
sDim4 = TabDim( pCube, 4 );
sDim5 = TabDim( pCube, 5 );
sDim6 = TabDim( pCube, 6 );
sDim7 = TabDim( pCube, 7 );
sDim8 = TabDim( pCube, 8 );
sDim9 = TabDim( pCube, 9 );
sDim10 = TabDim( pCube, 10 );
sDim11 = TabDim( pCube, 11 );
sDim12 = TabDim( pCube, 12 );
sDim13 = TabDim( pCube, 13 );
sDim14 = TabDim( pCube, 14 );
sDim15 = TabDim( pCube, 15 );
sDim16 = TabDim( pCube, 16 );
sDim17 = TabDim( pCube, 17 );
sDim18 = TabDim( pCube, 18 );
sDim19 = TabDim( pCube, 19 );
sDim20 = TabDim( pCube, 20 );
sDim21 = TabDim( pCube, 21 );
sDim22 = TabDim( pCube, 22 );
sDim23 = TabDim( pCube, 23 );
sDim24 = TabDim( pCube, 24 );


If( pDebug <= 1 );

  ### Turn off logging ###
  nOldCubeLogChanges = CubeGetLogChanges( pCube );
  CubeSetLogChanges( pCube, 0 );


  ### Zero Out target version ###

  If( pZeroTarget = 1 );

    cTempViewTo = '}' | cProcess | '.' | NumberToString( Round( Rand * 100000 ) );
    cTempSubTo = cTempViewTo;

    If( ViewExists( pCube, cTempViewTo ) = 1 );
      # It is highly unlikely that the view already exists as the view name contains
      # a random number. However it is included in case two seperate calls generate
      # the same random number.
      ViewDestroy( pCube, cTempViewTo );
    EndIf;
    ViewCreate( pCube, cTempViewTo );

    If( SubsetExists( pDimension, cTempSubTo ) = 1 );
      # It is highly unlikely that the subset already exists as the subset name contains
      # a random number. However it is included in case two seperate calls generate
      # the same random number.
      SubsetDestroy( pDimension, cTempSubTo );
    EndIf;
    SubsetCreate( pDimension, cTempSubTo );
    SubsetElementInsert( pDimension, cTempSubTo, pTargetElement, 1 );

    ViewSubsetAssign( pCube, cTempViewTo, pDimension, cTempSubTo );
    ViewExtractSkipCalcsSet( pCube, cTempViewTo, 1 );
    ViewExtractSkipRuleValuesSet( pCube, cTempViewTo, 1 );
    ViewExtractSkipZeroesSet( pCube, cTempViewTo, 1 );

    ViewZeroOut( pCube, cTempViewTo );

  EndIf;

EndIf;

### Create Processing View for source version ###

cTempViewFrom = '}' | cProcess | '.' | NumberToString( Round( Rand * 100000 ) );
cTempSubFrom = cTempViewFrom;

If( ViewExists( pCube, cTempViewFrom ) = 0 );
  # It is highly unlikely that the view already exists as the view name contains
  # a random number. However it is included in case two seperate calls generate
  # the same random number.
  ViewCreate( pCube, cTempViewFrom );
EndIf;
If( SubsetExists( pDimension, cTempSubFrom ) = 0 );
  SubsetCreate( pDimension, cTempSubFrom );
Else;
  SubsetDeleteAllElements( pDimension, cTempSubFrom );
EndIf;
SubsetElementInsert( pDimension, cTempSubFrom, pSourceElement, 1 );
ViewSubsetAssign( pCube, cTempViewFrom, pDimension, cTempSubFrom );

# If skip rules not 0 or 1 then set to 1 (skip)
If( pSkipRules <> 0 & pSkipRules <> 1 );
  pSkipRules = 1;
EndIf;

ViewExtractSkipCalcsSet( pCube, cTempViewFrom, 1 );
ViewExtractSkipRuleValuesSet( pCube, cTempViewFrom, pSkipRules );
ViewExtractSkipZeroesSet( pCube, cTempViewFrom, 1 );


### Assign Datasource ###

DataSourceType = 'VIEW';
DatasourceNameForServer = pCube;
DatasourceNameForClient = pCube;
DatasourceCubeView = cTempViewFrom;


### End Prolog ###
573,2


574,293



#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################


### Check for error in prolog ###

If( nErrors > 0 );
  ProcessBreak;
EndIf;


### Determine version dimension SubStitution ###

If( nDimensionIndex = 1 );
  v1 = pTargetElement;
ElseIf( nDimensionIndex = 2 );
  v2 = pTargetElement;
ElseIf( nDimensionIndex = 3 );
  v3 = pTargetElement;
ElseIf( nDimensionIndex = 4 );
  v4 = pTargetElement;
ElseIf( nDimensionIndex = 5 );
  v5 = pTargetElement;
ElseIf( nDimensionIndex = 6 );
  v6 = pTargetElement;
ElseIf( nDimensionIndex = 7 );
  v7 = pTargetElement;
ElseIf( nDimensionIndex = 8 );
  v8 = pTargetElement;
ElseIf( nDimensionIndex = 9 );
  v9 = pTargetElement;
ElseIf( nDimensionIndex = 10 );
  v10 = pTargetElement;
ElseIf( nDimensionIndex = 11 );
  v11 = pTargetElement;
ElseIf( nDimensionIndex = 12 );
  v12 = pTargetElement;
ElseIf( nDimensionIndex = 13 );
  v13 = pTargetElement;
ElseIf( nDimensionIndex = 14 );
  v14 = pTargetElement;
ElseIf( nDimensionIndex = 15 );
  v15 = pTargetElement;
ElseIf( nDimensionIndex = 16 );
  v16 = pTargetElement;
ElseIf( nDimensionIndex = 17 );
  v17 = pTargetElement;
ElseIf( nDimensionIndex = 18 );
  v18 = pTargetElement;
ElseIf( nDimensionIndex = 19 );
  v19 = pTargetElement;
ElseIf( nDimensionIndex = 20 );
  v20 = pTargetElement;
ElseIf( nDimensionIndex = 21 );
  v21 = pTargetElement;
ElseIf( nDimensionIndex = 22 );
  v22 = pTargetElement;
ElseIf( nDimensionIndex = 23 );
  v23 = pTargetElement;
ElseIf( nDimensionIndex = 24 );
  v24 = pTargetElement;
EndIf;


### Write data from source version to target version ###

# Selects the correct CellPut formula depending upon the number of dimensions in the cube
# and whether the value is numeric or string ( max 24 dims catered for in this code )
# value type determined by element type of last dimension in cube
# could have used Value_is_String = 1 and NValue/SValue but this works just as well

If( pDebug <= 1 );
  If( nDimensionCount = 2 );
    If( CellIsUpdateable( pCube, v1, v2 ) = 1 );
      sElType = DType( sDim2, v2 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v3 ), pCube, v1, v2 );
      Else;
        CellPutS( v3, pCube, v1, v2 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 3 );
    If( CellIsUpdateable( pCube, v1, v2, v3 ) = 1 );
      sElType = DType( sDim3, v3 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v4 ), pCube, v1, v2, v3 );
      Else;
        CellPutS( v4, pCube, v1, v2, v3 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 4 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4 ) = 1 );
      sElType = DType( sDim4, v4 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v5 ), pCube, v1, v2, v3, v4 );
      Else;
        CellPutS( v5, pCube, v1, v2, v3, v4 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 5 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5 ) = 1 );
      sElType = DType( sDim5, v5 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v6 ), pCube, v1, v2, v3, v4, v5 );
      Else;
        CellPutS( v6, pCube, v1, v2, v3, v4, v5 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 6 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6 ) = 1 );
      sElType = DType( sDim6, v6 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v7 ), pCube, v1, v2, v3, v4, v5, v6 );
      Else;
        CellPutS( v7, pCube, v1, v2, v3, v4, v5, v6 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 7 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7 ) = 1 );
      sElType = DType( sDim7, v7 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v8 ), pCube, v1, v2, v3, v4, v5, v6, v7 );
      Else;
        CellPutS( v8, pCube, v1, v2, v3, v4, v5, v6, v7 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 8 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8 ) = 1 );
      sElType = DType( sDim8, v8 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v9 ), pCube, v1, v2, v3, v4, v5, v6, v7, v8 );
      Else;
        CellPutS( v9, pCube, v1, v2, v3, v4, v5, v6, v7, v8 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 9 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9 ) = 1 );
      sElType = DType( sDim9, v9 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v10 ), pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9 );
      Else;
        CellPutS( v10, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 10 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 ) = 1 );
      sElType = DType( sDim10, v10 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v11 ), pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 );
      Else;
        CellPutS( v11, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 11 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 ) = 1 );
      sElType = DType( sDim11, v11 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v12 ), pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 );
      Else;
        CellPutS( v12, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 12 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 ) = 1 );
      sElType = DType( sDim12, v12 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v13 ), pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 );
      Else;
        CellPutS( v13, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 13 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 ) = 1 );
      sElType = DType( sDim13, v13 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v14 ), pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 );
      Else;
        CellPutS( v14, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 14 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 ) = 1 );
      sElType = DType( sDim14, v14 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v15 ), pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 );
      Else;
        CellPutS( v15, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 15 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 ) = 1 );
      sElType = DType( sDim15, v15 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v16 ), pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 );
      Else;
        CellPutS( v16, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 16 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 ) = 1 );
      sElType = DType( sDim16, v16 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v17 ), pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 );
      Else;
        CellPutS( v17, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 17 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 ) = 1 );
      sElType = DType( sDim17, v17 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v18 ), pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 );
      Else;
        CellPutS( v18, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 18 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 ) = 1 );
      sElType = DType( sDim18, v18 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v19 ), pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 );
      Else;
        CellPutS( v19, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 19 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v19 ) = 1 );
      sElType = DType( sDim19, v19 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v20 ), pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 );
      Else;
        CellPutS( v20, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 20 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v19, v20 ) = 1 );
      sElType = DType( sDim20, v20 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v21 ), pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 );
      Else;
        CellPutS( v21, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 21 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v19, v20, v21 ) = 1 );
      sElType = DType( sDim21, v21 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v22 ), pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 );
      Else;
        CellPutS( v22, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 22 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v19, v20, v21, v22 ) = 1 );
      sElType = DType( sDim22, v22 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v23 ), pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 );
      Else;
        CellPutS( v23, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 23 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v19, v20, v21, v22,
    v23 ) = 1 );
      sElType = DType( sDim23, v23 );
      If( sElType @<> 'S' );
        CellPutN( Numbr( v24 ), pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
         v23 );
      Else;
        CellPutS( v24, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23 );
      EndIf;
    EndIf;
  ElseIf( nDimensionCount = 24 );
    If( CellIsUpdateable( pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v19, v20, v21, v22,
    v23, v24 ) = 1 );
      sElType = DType( sDim24, v24 );
      If( sElType @<> 'S' );
         CellPutN( Numbr( v25 ), pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
         v23, v24 );
      Else;
        CellPutS( v25, pCube, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24 );
      EndIf;
    EndIf;
  EndIf;

EndIf;


### End Data ###
575,57



#####################################################################################
##~~Copyright bedrocktm1.org 2011 www.bedrocktm1.org/how-to-licence.php Ver 1.0.0~~##
#####################################################################################


### Initialise Debug ###

If( pDebug >= 1 );

  # Set debug file name
  sDebugFile = cDebugFile | 'Epilog.debug';

EndIf;


If( nErrors = 0 & pDebug <= 1 );

  ### Zero out source data ###

  If( pZeroSource = 1 );
    ViewZeroOut( pCube, cTempViewFrom );
  EndIf;


  ### Restore logging ###

  CubeSetLogChanges( pCube, nOldCubeLogChanges );

EndIf;


### Finalise Debug ###

If( pDebug >= 1 );

  # Log errors
  If( nErrors <> 0 );
    AsciiOutput( sDebugFile, 'Errors Occurred' );
  EndIf;

  # Log finish time
  AsciiOutput( sDebugFile, 'Process Finished: ' | TimSt( Now, '\d-\m-\Y \h:\i:\s' ) );

EndIf;


### If errors occurred terminate process with a major error status ###

If( nErrors <> 0 );
  ProcessQuit;
EndIf;


### End Epilog ###
576,CubeAction=1511€DataAction=1503€CubeLogChanges=0€
638,1
804,0
1217,1
900,
901,
902,
903,
906,
929,
907,
908,
904,0
905,0
909,0
911,
912,
913,
914,
915,
916,
917,1
918,1
919,0
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""