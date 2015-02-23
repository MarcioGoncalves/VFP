**********************************************************************
DEFINE CLASS Contido_Test as FxuTestCase OF FxuTestCase.prg
**********************************************************************
	#IF .f.
	*
	*  this LOCAL declaration enabled IntelliSense for
	*  the THIS object anywhere in this class
	*
	LOCAL THIS AS Contido_Test OF Contido_Test.PRG
	#ENDIF
	
	*  
	*  declare properties here that are used by one or
	*  more individual test methods of this class
	*
	*  for example, if you create an object to a custom
	*  THIS.Property in THIS.Setup(), estabish the property
	*  here, where it will be available (to IntelliSense)
	*  throughout:
	*
*!*		ioObjectToBeTested = .NULL.
*!*		icSetClassLib = SPACE(0)


	* the icTestPrefix property in the base FxuTestCase class defaults
	* to "TEST" (not case sensitive). There is a setting on the interface
	* tab of the options form (accessible via right-clicking on the
	* main FoxUnit form and choosing the options item) labeld as
	* "Load and run only tests with the specified icTestPrefix value in test classes"
	*
	* If this is checked, then only tests in any test class that start with the
	* prefix specified with the icTestPrefix property value will be loaded
	* into FoxUnit and run. You can override this prefix on a per-class basis.
	*
	* This makes it possible to create ancillary methods in your test classes
	* that can be shared amongst other test methods without being run as
	* tests themselves. Additionally, this means you can quickly and easily 
	* disable a test by modifying it and changing it's test prefix from
	* that specified by the icTestPrefix property
	
	* Additionally, you could set this in the INIT() method of your derived class
	* but make sure you dodefault() first. When the option to run only
	* tests with the icTestPrefix specified is checked in the options form,
	* the test classes are actually all instantiated individually to pull
	* the icTestPrefix value.

*!*		icTestPrefix = "<Your preferred prefix here>"
	
	********************************************************************
	FUNCTION Setup
	*
	*  put common setup code here -- this method is called
	*  whenever THIS.Run() (inherited method) to run each
	*  of the custom test methods you add, specific test
	*  methods that are not inherited from FoxUnit
	*
	*  do NOT call THIS.Assert..() methods here -- this is
	*  NOT a test method
	*
    *  for example, you can instantiate all the object(s)
    *  you will be testing by the custom test methods of 
    *  this class:
*!*		THIS.icSetClassLib = SET("CLASSLIB")
*!*		SET CLASSLIB TO MyApplicationClassLib.VCX ADDITIVE
*!*		THIS.ioObjectToBeTested = CREATEOBJECT("MyNewClassImWriting")

	********************************************************************
	ENDFUNC
	********************************************************************
	
	********************************************************************
	FUNCTION TearDown
	********************************************************************
	*
	*  put common cleanup code here -- this method is called
	*  whenever THIS.Run() (inherited method) to run each
	*  of the custom test methods you add, specific test
	*  methods that are not inherited from FoxUnit
	*
	*  do NOT call THIS.Assert..() methods here -- this is
	*  NOT a test method
	*
    *  for example, you can release  all the object(s)
    *  you will be testing by the custom test methods of 
    *  this class:
*!*	    THIS.ioObjectToBeTested = .NULL.
*!*		LOCAL lcSetClassLib
*!*		lcSetClassLib = THIS.icSetClassLib
*!*		SET CLASSLIB TO &lcSetClassLib        
	ENDFUNC

	********************************************************************	
	*
	*  test methods can use any method name not already used by
	*  the parent FXUTestCase class
	*    MODIFY COMMAND FXUTestCase
	*  DO NOT override any test methods except for the abstract 
	*  test methods Setup() and TearDown(), as described above
	*
	*  the three important inherited methods that you call
	*  from your test methods are:
	*    THIS.AssertTrue("Failure message",<Expression>)
	*    THIS.AssertEquals("Failure message",<ExpectedValue>,<Expression>)
	*    THIS.AssertNotNull("Failure message",<Expression>)
	*  all test methods either pass or fail -- the assertions
	*  either succeed or fail
    
	*
	*  here's a simple AssertNotNull example test method
	*
*!*		*********************************************************************
*!*		FUNCTION TestObjectWasCreated
*!*		*********************************************************************
*!*		THIS.AssertNotNull("Object was not instantiated during Setup()", ;
*!*			               THIS.ioObjectToBeTested)
*!*		*********************************************************************
*!*		ENDFUNC
*!*		*********************************************************************

	*
	*  here's one for AssertTrue
	*
*!*		*********************************************************************
*!*		FUNCTION TestObjectCustomMethod 
*!*		*********************************************************************
*!*		THIS.AssertTrue("Object.CustomMethod() failed", ;
*!*			            THIS.ioObjectToBeTested.CustomMethod())
*!*		*********************************************************************
*!*		ENDFUNC
*!*		*********************************************************************

	*
	*  and one for AssertEquals
	*
*!*		*********************************************************************
*!*		FUNCTION TestObjectCustomMethod100ReturnValue 
*!*
*!*		* Please note that string Comparisons with AssertEquals are
*!*		* case sensitive. 
*!*
*!*		THIS.AssertEquals("Object.CustomMethod100() did not return 'John Smith'", ;
*!*		                "John Smith", ;
*!*			            THIS.ioObjectToBeTested.Object.CustomMethod100())
*!*		*********************************************************************
*!*		ENDFUNC

	**********************************************
	FUNCTION ContidoEmUmValorPontual
		This.AssertTrue(Contido('11100', '11100'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION ContidoEmUmValorPontualComProcuradoNumerico
		This.AssertTrue(Contido(2, '2'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION ContidoEmUmValorPontualComDif
		This.AssertTrue(Contido('11200', 'DIF: 11100'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION NãoContidoEmUmValorPontual
		This.AssertTrue(NOT Contido('11100', '11200'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION NãoContidoEmUmValorPontualComDif
		This.AssertTrue(NOT Contido('11100', 'DIF: 11100'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION NãoContidoEmUmValorEmBranco
		This.AssertTrue(NOT Contido('11100', ''), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION NãoContidoEmUmValorPontualSeProcuradoEmBranco
		This.AssertTrue(NOT Contido('', '10000'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION ContidoEmUmValorPontualComDifSeProcuradoEmBranco
		This.AssertTrue(Contido('', 'DIF: 10000'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION NãoContidoEmUmValorPontualSeProcuradoComTamanhoDiferente
		This.AssertTrue(NOT Contido('10', '10000'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION ContidoEmUmValorPontualComDifSeProcuradoComTamanhoDiferente
		This.AssertTrue(Contido('10', 'DIF: 10000'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION ContidoEmValoresPontuais
		This.AssertTrue(Contido('11100', '10000;11100'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION ContidoEmValoresPontuaisComProcuradoNumerico
		This.AssertTrue(Contido(2, '1;2;3'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION ContidoEmValoresPontuaisComDif
		This.AssertTrue(Contido('11100', 'DIF: 10000;11200'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION NãoContidoEmValoresPontuais
		This.AssertTrue(NOT Contido('11100', '10000;11200'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION NãoContidoEmValoresPontuaisComDif
		This.AssertTrue(NOT Contido('11100', 'DIF: 11100;11200'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION ContidoEmUmaFaixaDeValores
		This.AssertTrue(Contido('11100', '10000-19000'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION ContidoEmUmaFaixaDeValoresComProcuradoNumerico
		This.AssertTrue(Contido(2, '1-10'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION ContidoEmUmaFaixaDeValoresComDif
		This.AssertTrue(Contido('11100', 'DIF: 20000-29999'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION NãoContidoEmUmaFaixaDeValores
		This.AssertTrue(NOT Contido('21100', '10000-19000'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION NãoContidoEmUmaFaixaDeValoresComDif
		This.AssertTrue(NOT Contido('21100', 'DIF: 20000-29000'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION NãoContidoEmUmaFaixaDeValoresSeProcuradoEmBranco
		This.AssertTrue(NOT Contido('', '10000-19000'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION ContidoEmUmaFaixaDeValoresComDifSeProcuradoEmBranco
		This.AssertTrue(Contido('', 'DIF: 10000-19000'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION ContidoEmUmaFaixaDeValoresSeProcuradoComTamanhoDiferente
		This.AssertTrue(Contido('22', '1-300'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION NãoContidoEmUmaFaixaDeValoresSeProcuradoComTamanhoDiferente
		This.AssertTrue(NOT Contido('11', '10000-19000'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION ContidoEmUmaFaixaDeValoresComDifSeProcuradoComTamanhoDiferente
		This.AssertTrue(Contido('11', 'DIF: 10000-19000'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION ContidoEmValoresPontuaisMescladosComFaixasDeValores
		This.AssertTrue(Contido('11100', '00000;10000-19000;21100;30000-39999'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION ContidoEmValoresPontuaisMescladosComFaixasDeValoresComDif
		This.AssertTrue(Contido('41100', 'DIF: 00000;10000-19000;21100;30000-39999'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION NãoContidoEmValoresPontuaisMescladosComFaixasDeValores
		This.AssertTrue(NOT Contido('21200', '00000;10000-19000;21100;30000-39999'), 'Falha')
	ENDFUNC 

	**********************************************
	FUNCTION NãoContidoEmValoresPontuaisMescladosComFaixasDeValoresComDif
		This.AssertTrue(NOT Contido('21200', 'DIF: 00000;10000-19000;21200;30000-39999'), 'Falha')
	ENDFUNC 

ENDDEFINE