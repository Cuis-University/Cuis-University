'From Cuis 6.0 [latest update: #5399] on 23 July 2022 at 7:09:06 pm'!
'Description System Category auto saving added as requirement'!
!provides: 'CuisUniversity' 1 9!
!requires: 'TDDGuru' 1 50 nil!
!requires: 'SystemCategoryAutoSaving' 1 0 nil!
!requires: 'Morphic-Widgets-Extras' 1 38 nil!
!requires: 'CodeCoverage' 1 32 nil!
!requires: 'DenotativeObject' 1 97 nil!
!requires: 'Tools-Finder' 1 49 nil!
!requires: 'ComplexRefactorings' 1 0 nil!
!requires: 'Chalten' 1 18 nil!
SystemOrganization addCategory: 'CuisUniversity-Model'!
SystemOrganization addCategory: 'CuisUniversity-Tests'!


!classDefinition: #ParseNodeTest category: 'CuisUniversity-Tests'!
TestCase subclass: #ParseNodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CuisUniversity-Tests'!
!classDefinition: 'ParseNodeTest class' category: 'CuisUniversity-Tests'!
ParseNodeTest class
	instanceVariableNames: ''!

!classDefinition: #BlockNodeTest category: 'CuisUniversity-Tests'!
ParseNodeTest subclass: #BlockNodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CuisUniversity-Tests'!
!classDefinition: 'BlockNodeTest class' category: 'CuisUniversity-Tests'!
BlockNodeTest class
	instanceVariableNames: ''!

!classDefinition: #MessageNodeTest category: 'CuisUniversity-Tests'!
ParseNodeTest subclass: #MessageNodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CuisUniversity-Tests'!
!classDefinition: 'MessageNodeTest class' category: 'CuisUniversity-Tests'!
MessageNodeTest class
	instanceVariableNames: ''!

!classDefinition: #VariableNodeTest category: 'CuisUniversity-Tests'!
ParseNodeTest subclass: #VariableNodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CuisUniversity-Tests'!
!classDefinition: 'VariableNodeTest class' category: 'CuisUniversity-Tests'!
VariableNodeTest class
	instanceVariableNames: ''!

!classDefinition: #StringCuisUniversityExtentionsTest category: 'CuisUniversity-Tests'!
TestCase subclass: #StringCuisUniversityExtentionsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CuisUniversity-Tests'!
!classDefinition: 'StringCuisUniversityExtentionsTest class' category: 'CuisUniversity-Tests'!
StringCuisUniversityExtentionsTest class
	instanceVariableNames: ''!

!classDefinition: #CuisUniversityInstallation category: 'CuisUniversity-Model'!
Object subclass: #CuisUniversityInstallation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CuisUniversity-Model'!
!classDefinition: 'CuisUniversityInstallation class' category: 'CuisUniversity-Model'!
CuisUniversityInstallation class
	instanceVariableNames: ''!


!ParseNodeTest methodsFor: 'parse nodes helpers' stamp: 'RNG 1/19/2018 21:09:10'!
message: aSelector to: aVariableName

	| variableNode selectorNode |
	variableNode _ VariableNode named: aVariableName.
	selectorNode _ SelectorNode new key: aSelector code: 34.
	^ MessageNode new
		receiver: variableNode
		selector: selectorNode
		arguments: #()
		precedence: 1! !

!BlockNodeTest methodsFor: 'detecting self recursion' stamp: 'RNG 1/19/2018 21:05:22'!
testItDoesNotSendsAGivenMessageToSelfWhenTheBlockIsEmpty

	| anEmptyBlock |
	anEmptyBlock _ BlockNode empty.

	self deny: (anEmptyBlock sendsMessageToSelf: #myMethod)! !

!BlockNodeTest methodsFor: 'detecting self recursion' stamp: 'RNG 1/19/2018 21:08:08'!
testItSendsAGivenMessageToSelfWhenItContainsAnStatementWithAMessageSendToSelf

	| anEmptyBlock |
	anEmptyBlock _ BlockNode withJust: (self message: #myMethod to: 'self').

	self assert: (anEmptyBlock sendsMessageToSelf: #myMethod)! !

!MessageNodeTest methodsFor: 'detecting self recursion' stamp: 'RNG 1/19/2018 21:02:30'!
testItDoesNotSendTheMessageToSelfWhenTheReceiverIsNotSelf

	| messageNode |
	messageNode _ self message: #myMethod to: 'super'.

	self deny: (messageNode sendsMessageToSelf: #myMethod)! !

!MessageNodeTest methodsFor: 'detecting self recursion' stamp: 'RNG 1/19/2018 21:02:19'!
testItDoesNotSendTheMessageToSelfWhenTheReceiverIsSelfButTheSelectorIsDifferent

	| messageNode |
	messageNode _ self message: #myMethod to: 'self'.

	self deny: (messageNode sendsMessageToSelf: #otherMethod)! !

!MessageNodeTest methodsFor: 'detecting self recursion' stamp: 'RNG 1/19/2018 21:01:10'!
testItSendsTheMessageToSelfWhenTheReceiverIsSelf

	| messageNode |
	messageNode _ self message: #myMethod to: 'self'.

	self assert: (messageNode sendsMessageToSelf: #myMethod)! !

!VariableNodeTest methodsFor: 'references to self' stamp: 'RNG 1/19/2018 20:51:09'!
testItDoesNotReferencesSelfWhenTheVariableNameIsNotSelf

	| variableNode |
	variableNode _ VariableNode named: 'abc'.

	self deny: variableNode referencesSelf! !

!VariableNodeTest methodsFor: 'references to self' stamp: 'RNG 1/19/2018 20:50:13'!
testItReferencesSelfWhenTheVariableNameIsSelf

	| variableNode |
	variableNode _ VariableNode named: 'self'.

	self assert: variableNode referencesSelf! !

!StringCuisUniversityExtentionsTest methodsFor: 'tests' stamp: 'HAW 11/27/2021 11:25:44'!
test01_IfBeginsWith_a_AndContinuesWithUppercase_RemovesTheA

	self assert: 'dog' equals: 'aDog' asInstanceVariableName.
	! !

!StringCuisUniversityExtentionsTest methodsFor: 'tests' stamp: 'HAW 11/27/2021 11:27:51'!
test02_IfBeginsWith_a_AndContinuesWithLowercase_Adds_CHANGE_ME

	self assert: 'adog_CHANGE_ME' equals: 'adog' asInstanceVariableName.
	! !

!StringCuisUniversityExtentionsTest methodsFor: 'tests' stamp: 'HAW 11/27/2021 11:26:33'!
test03_IfBeginsWith_an_AndContinuesWithUppercase_RemovesTheAn

	self assert: 'abc' equals: 'anAbc' asInstanceVariableName.
	! !

!StringCuisUniversityExtentionsTest methodsFor: 'tests' stamp: 'HAW 11/27/2021 11:27:07'!
test04_IfBeginsWith_an_AndContinuesWithLowercase_Adds_CHANGE_ME

	self assert: 'anabc_CHANGE_ME' equals: 'anabc' asInstanceVariableName.
	! !

!StringCuisUniversityExtentionsTest methodsFor: 'tests' stamp: 'HAW 11/27/2021 11:28:11'!
test05_IfBeginsWith_un_AndContinuesWithUppercase_RemovesThe_un

	"Spanish support - Hernan"
	self assert: 'perro' equals: 'unPerro' asInstanceVariableName.
	! !

!StringCuisUniversityExtentionsTest methodsFor: 'tests' stamp: 'HAW 11/27/2021 11:28:45'!
test06_IfBeginsWith_un_AndContinuesWithLowercase_Adds_CHANGE_ME

	"Spanish support - Hernan"
	self assert: 'unperro_CHANGE_ME' equals: 'unperro' asInstanceVariableName.
	! !

!StringCuisUniversityExtentionsTest methodsFor: 'tests' stamp: 'HAW 11/27/2021 11:29:07'!
test07_IfBeginsWith_una_AndContinuesWithUppercase_RemovesThe_una

	"Spanish support - Hernan"
	self assert: 'mesa' equals: 'unaMesa' asInstanceVariableName.
	! !

!StringCuisUniversityExtentionsTest methodsFor: 'tests' stamp: 'HAW 11/27/2021 11:29:39'!
test08_IfBeginsWith_una_AndContinuesWithLowercase_Adds_CHANGE_ME

	"Spanish support - Hernan"
	self assert: 'unamesa_CHANGE_ME' equals: 'unamesa' asInstanceVariableName.
	! !

!StringCuisUniversityExtentionsTest methodsFor: 'tests' stamp: 'HAW 11/27/2021 11:29:47'!
test08_IfItIsNotTheOtherCases_Add_CHANGE_ME

	self assert: 'name_CHANGE_ME' equals: 'name' asInstanceVariableName.
	! !

!CuisUniversityInstallation class methodsFor: 'initialization' stamp: 'HAW 7/11/2022 19:59:12'!
initialize

	UnitsTestResource  installUnitsAsGlobals.
	TimeUnits installUnitsAsGlobals.
	StackSizeWatcher startWatchingWithDefaults.
	DenotativeObjectLightTheme beCurrent.
	Preferences name: #autoNumberUserChanges category: #system value: false.
	Preferences name: #logDebuggerStackToFile category: #programming value: false.
	Preferences name: #checkLostChangesOnStartUp category: #system value: true.
	Preferences name: #methodAnnotations category: #programming value: #(timeStamp messageCategory packages changeSets).
	Preferences name: #classAnnotations category: #programming value: #(instanceMethodsCount classMethodsCount).
	Preferences name: #systemCategoryAnnotations category: #programming value: #(classCount instanceMethodsCount classMethodsCount).
	
	
	! !

!CuisUniversityInstallation class methodsFor: 'initialization' stamp: 'HAW 3/6/2021 18:44:01'!
initializeWithLiveTypingVM

	self 
		"runAllTests;"
		removeSystemChangesFromChangeSet;
		openWelcomeWindow.

	TranscriptWindow allInstancesDo: [:aTranscriptWindow | aTranscriptWindow delete ].
! !

!CuisUniversityInstallation class methodsFor: 'welcome window' stamp: 'HAW 3/28/2018 19:59:40'!
openWelcomeWindow

	| welcomeWindow |
	
	welcomeWindow := SystemWindow editText: (TextModel withText: (self welcomeWindowContents)) label: '¡Bienvenidos a CuisUniversity!!' wrap: true.
	welcomeWindow resize: (Rectangle origin: 45@40 extent: 910@435)! !

!CuisUniversityInstallation class methodsFor: 'welcome window' stamp: 'HAW 2/28/2019 19:51:03'!
welcomeWindowContents

	^Compiler evaluate:  '(Text string: ''CuisUniversity

Este es un ambiente creado especialmente para la enseñanza de la Programación Orientada a Objetos, usando Smalltalk como herramienta y en particular la implementación Argentina de Smalltalk denominada Cuis.

El objetivo es que los interesados empiecen aprendiendo qué significa trabajar con objetos concretos (denotative objects) para luego pasar a implementaciones más complejas del paradigma.

Para trabajar con objetos concretos, solo basta elegir la opcion "DenotativeObject Browser" del menú principal.
Para videos que muestran cómo usar CuisUniversity ir a: https://www.youtube.com/playlist?list=PLMkq_h36PcLCQiU5gxNmedxdXbl10JYeV

Este ambiente viene con los siguientes paquetes instalados:
- LiveTyping: Una VM especial con un ambiente de objetos extendido que anota los tipos de las variables
  a medida que el sistema ejecuta. Mejora muchisimo la experiencia del programador.
- DenotativeObject: Herramienta que permite trabajar con Objetos sin Clases.
- Refactoring: Implementacion de refactorings automatizados para Cuis.
- Aconcagua: Posibilita trabajar con medidas 
- Chalten: Implementación del Calendario Gregoriano. Usa Aconcagua
- Themes: Package que permite seleccionar distintos temas (colores), como Dark. Ir a "Preferences -> Themes"
  (Usar preferentemente DenotativeObjectTheme y DenotativeObjectDarkTheme)

Implementadores:
- Hernán Wilkinson, Máximo Prieto, Juan Manuel Vuletich

Colaboradores
- Nahuel Garbezza, Gastón Caruso, Angeles Tella Arena, Matias Melendi

Sponsors:
- 10Pines SRL: Este ambiente no sería posible sin la horas de trabajo cedidas por 10Pines para hacerlo.'' runs: (RunArray runs: #(14 1 1605 ) values: ((Array new: 3) at: 1 put: ((Array new: 4) at: 1 put: (TextFontFamilyAndSize basicNew instVarAt: 1 put: ''DejaVu''; instVarAt: 2 put: 22; yourself); at: 2 put: (TextEmphasis basicNew instVarAt: 1 put: 1; yourself); at: 3 put: (TextColor basicNew instVarAt: 1 put: (Color r: 0.000 g: 0.000 b: 1.000); yourself); at: 4 put: (TextAlignment basicNew instVarAt: 1 put: 2; yourself); yourself); at: 2 put: ((Array new: 1) at: 1 put: (TextAlignment basicNew instVarAt: 1 put: 2; yourself); yourself); at: 3 put: #(); yourself)))'! !

!CuisUniversityInstallation class methodsFor: 'initialization - private' stamp: 'HAW 2/28/2019 22:14:55'!
removeSystemChangesFromChangeSet

	ChangeSet allChangeSets 
		select: [ :aChangeSet | aChangeSet isForBaseSystem ] 
		thenDo: [ :aChangeSet | ChangeSet removeChangeSet: aChangeSet ]! !

!CuisUniversityInstallation class methodsFor: 'initialization - private' stamp: 'HAW 2/28/2019 22:14:40'!
runAllTests

	| testClasses testSuite |
	
	testClasses := TestCase allSubclasses reject: [:cls | cls isAbstract or: [ cls = DecompilerTests ]].
	testSuite := TestSuite new.
	testClasses do: [ :aTestClass | aTestClass addToSuiteFromSelectors: testSuite ].
	
	testSuite run.
	
	MenuMorph allInstances do: [:aMorph | aMorph delete ].
	SystemWindow allInstances select: [ :aSystemWindow | aSystemWindow label = 'old instance' ] thenDo: [:aMorph | aMorph delete ].! !

!CuisUniversityInstallation class methodsFor: 'browser menues' stamp: 'HAW 5/7/2022 11:22:02'!
systemCategoryMenuOptions

	^{ 
		{
				#itemGroup	 		-> 	50.
				#itemOrder 			-> 	15.
				#label 			-> 	'change new line encode...'.
				#object 			-> 	#model.
				#selector 			-> 	#changeNewLineEncode.
				#icon 			-> 	#updateIcon
		} asDictionary.
		{
				#itemGroup  			->	80.
				#itemOrder  			->	10.
				#label  			-> 	'create package'.
				#icon  			-> 	#packageIcon.
				#object  			-> 	#model.
				#selector  			->	#createPackage.
		} asDictionary.
	}! !

!ProtoObject methodsFor: '*CuisUniversity' stamp: 'HAW 1/28/2022 19:25:26'!
forceBecome: anotherObject

	^[ self become: anotherObject ]
		on: MethodInCallStackToBecomeInvalid
		do: [ :error | error resume ]  ! !

!Object methodsFor: '*CuisUniversity-Model' stamp: 'HAW 3/24/2020 17:10:28'!
informBlockingUI: aStringToShow
	"Display aString blocking the UI"

	aStringToShow isEmptyOrNil ifFalse: [PopUpMenu informBlockingUI: aStringToShow]! !

!Browser methodsFor: '*CuisUniversity-Model' stamp: 'HAW 12/5/2021 11:19:13'!
changeNewLineEncode
	
	| index |
	
	selectedSystemCategory ifNil: [ ^ self]. 
	
	index := self selectEncodeToConvert.					
	(index between: 1 and: 3) ifTrue: [ self convertToEncode: index ].
	! !

!Browser methodsFor: '*CuisUniversity-Model' stamp: 'HAW 12/5/2021 11:18:55'!
convertToEncode: encondeNumber 

	| categorySubclasses class newSourceCode sourceCode |
	
	categorySubclasses := SystemOrganization listAtCategoryNamed: selectedSystemCategory.
		
	categorySubclasses do: [:aClassName | 
		class := Smalltalk classNamed: aClassName.
		{ class. class class } do: [ :aClass | aClass selectors do: [:aMethod |
			sourceCode := (aClass compiledMethodAt: aMethod) sourceCode.
			encondeNumber = 1 ifTrue: [ newSourceCode := sourceCode withCuisLineEndings. ].
			encondeNumber = 2 ifTrue: [ newSourceCode := sourceCode withLineEndings: String crString. ].
			encondeNumber = 3 ifTrue: [ newSourceCode := sourceCode withLineEndings: String crlfString. ].
			aClass compile: newSourceCode ]]]! !

!Browser methodsFor: '*CuisUniversity-Model' stamp: 'HAW 5/7/2022 11:24:21'!
createPackage

	selectedSystemCategory ifNotNil: [ :categoryName |
		CodePackage 
			named: categoryName 	
			createIfAbsent: true 
			registerIfNew: true ]
	 ! !

!Browser methodsFor: '*CuisUniversity-Model' stamp: 'HAW 8/25/2021 11:40:52'!
selectEncodeToConvert

	^(PopUpMenu 
		labelArray: {'LF (Cuis default)'. 'CR'. 'CRLF'. 'Cancel'}
		lines: #()
		icons: #(updateIcon updateIcon updateIcon cancelIcon) ) 
		startUpWithCaption: 'To which binary encode would you like to change the code?'.! !

!Debugger methodsFor: '*CuisUniversity-Model' stamp: 'HAW 11/24/2019 18:38:07'!
argumentNamesOf: aMessage sentIn: aContext
		
	| argumentNames cantDeduceNameCounter |
	
	cantDeduceNameCounter := 0.
	aContext methodNode nodesDo: [ :aNode |
		(aNode isMessageNode and: [ aNode selectorSymbol = aMessage selector ]) 
			ifTrue: [ argumentNames := aNode arguments collect: [ :argument | 
					argument isVariableNode 
						ifTrue: [ argument name ] 
						ifFalse: [ 
							cantDeduceNameCounter := cantDeduceNameCounter + 1.
							'aRenameMe',cantDeduceNameCounter printString ]]]].
		
	^argumentNames 

! !

!Debugger methodsFor: '*CuisUniversity-Model' stamp: 'HAW 10/10/2019 08:18:02'!
compileInitilizationMessage: aMessage in: aCategory fromClass: aClass context: aContext 
	
	| argumentNames realCategory initializationMethodSourceCode |
	
	argumentNames := self argumentNamesOf: aMessage sentIn: aContext sender.
		
	"Just in case something went wrong... - Hernan"
	argumentNames ifNil: [ ^self compileMessage: aMessage inCategory: aCategory fromClass: aClass context: aContext ].
	
	realCategory := aCategory = Categorizer default ifTrue: [ Categorizer initialization ]  ifFalse: [ aCategory ].
	initializationMethodSourceCode := aMessage 
		createInitializeMessageWith: argumentNames 
		forEachInstVarNameDo: [ :anInstVarName |  
			(aClass definesInstanceVariableNamedInHierarchy: anInstVarName) ifFalse: [ aClass addInstVarName: anInstVarName ]].
		
	aClass
		compile: initializationMethodSourceCode
		classified: realCategory
		! !

!Debugger methodsFor: '*CuisUniversity-Model' stamp: 'HAW 10/7/2019 14:43:50'!
compileInstanceCreationMessage: aMessage in: aCategory fromClass: aClass context: aContext 
	
	aClass
		compile: (aMessage createInstanceCreationMessageFor: aClass)
		classified: aCategory
! !

!Debugger methodsFor: '*CuisUniversity-Model' stamp: 'HAW 10/7/2019 14:39:43'!
compileMessage: aMessage inCategory: aCategory fromClass: aClass context: aContext 
	
	aClass
		compile: (aMessage createStubMethodFor: aClass)
		classified: aCategory! !

!Debugger methodsFor: '*CuisUniversity-Model' stamp: 'HAW 10/10/2019 11:08:45'!
implement: aMessage inCategory: aCategory fromClass: aClass context: aContext

	[ (aClass isMeta and: [ aCategory = Categorizer instanceCreation]) 
		ifTrue: [ self compileInstanceCreationMessage: aMessage in: aCategory fromClass: aClass context: aContext ]
		ifFalse: [ aMessage isInitializer 
			ifTrue: [ self compileInitilizationMessage: aMessage in: aCategory fromClass: aClass context: aContext ]
			ifFalse: [ self compileMessage: aMessage inCategory: aCategory fromClass: aClass context: aContext ]].
		
	aContext privRefreshWith: (aClass lookupSelector: aMessage selector).
	aMessage arguments withIndexDo: [ :arg :index | aContext tempAt: index put: arg ].
	self resetContext: aContext ]
		on: RecompilationFailure
		do: [ :aFailure | 
			self inform: 'There was a problem compiling ', aClass name, '>>#',aMessage selector,
				' because:', String newLineString ,aFailure messageText.
			self down; restart ]
! !

!Message methodsFor: '*CuisUniversity-Model' stamp: 'HAW 10/8/2019 16:04:23'!
createInitializationMessageAssigmentsIn: stream with: argumentNames forEachInstVarNameDo: instVarNameBlock  

	| instVarName |
	
	argumentNames do: [ :anArgumentName | 
		instVarName := anArgumentName asInstanceVariableName.
		instVarNameBlock value: instVarName.
		stream
			newLine;tab;
			nextPutAll: instVarName;
			nextPutAll: ' := ';
			nextPutAll: anArgumentName;
			nextPut: $. ].		
! !

!Message methodsFor: '*CuisUniversity-Model' stamp: 'HAW 11/12/2019 09:05:37'!
createInitializeMessageDefinitionIn: stream with: argumentNames

	self selector isUnary 
		ifTrue: [ stream nextPutAll: self selector ]
		ifFalse: [ 
			self selector keywords withIndexDo: [ :keyword :index | 
				stream 
					nextPutAll: keyword;
					space;
					nextPutAll: (argumentNames at: index);
					space ]]
! !

!Message methodsFor: '*CuisUniversity-Model' stamp: 'HAW 10/8/2019 16:05:36'!
createInitializeMessageWith: argumentNames forEachInstVarNameDo: instVarNameBlock 

	^ String streamContents: [ :stream |
		self createInitializeMessageDefinitionIn: stream with: argumentNames.
		stream newLine;tab.		
		self writeShouldBeImplementedOn: stream.
		self createInitializationMessageAssigmentsIn: stream with: argumentNames forEachInstVarNameDo: instVarNameBlock ]! !

!Message methodsFor: '*CuisUniversity-Model' stamp: 'HAW 10/8/2019 15:28:48'!
createInstanceCreationMessageFor: aClass

	| instanceCreationMessageString |
	
	^ String streamContents: [ :stream |
		self writeMessageNameOn: stream.
		instanceCreationMessageString := stream contents.
		stream newLine; tab; nextPutAll: '"DO NOT FORGET TO RENAME COLLABORATORS AND REMOVE THIS COMMENT!!!!"';newLine; tab.
		self writeShouldBeImplementedOn: stream.
		stream
			newLine; tab;
			nextPutAll: '^self new initialize', instanceCreationMessageString capitalized ]! !

!Message methodsFor: '*CuisUniversity-Model' stamp: 'HAW 10/7/2019 14:49:23'!
isInitializer 

	^selector beginsWith: 'initialize'.! !

!String methodsFor: '*CuisUniversity-Model' stamp: 'HAW 11/27/2021 11:37:20'!
asInstanceVariableName
	
	self hasAnPrefix ifTrue: [ ^self uncapitalizedRemovingFirst: 2 ].
	self hasAPrefix ifTrue: [ ^self uncapitalizedRemovingFirst: 1 ].
	self hasUnPrefix ifTrue: [ ^self uncapitalizedRemovingFirst: 2 ].
	self hasUnaPrefix ifTrue: [ ^self uncapitalizedRemovingFirst: 3 ].
	
	^self asInstanceVariableNameUncapitilized 
	! !

!String methodsFor: '*CuisUniversity-Model' stamp: 'HAW 10/8/2019 15:42:10'!
asInstanceVariableNameUncapitilized 

	| instVarName |
	
	instVarName := self uncapitalized.
	^self = instVarName 
		ifTrue: [ instVarName, '_CHANGE_ME' ]
		ifFalse: [ instVarName ]! !

!String methodsFor: '*CuisUniversity-Model' stamp: 'HAW 11/27/2021 11:33:36'!
continuesWithUppercaseAfterPrefix: aPrefix
	
	^(self beginsWith: aPrefix) and: [ self size > aPrefix size and: [ (self at: aPrefix size + 1) isUppercase ]]! !

!String methodsFor: '*CuisUniversity-Model' stamp: 'HAW 11/27/2021 11:33:36'!
hasAPrefix
	
	^self continuesWithUppercaseAfterPrefix: 'a'! !

!String methodsFor: '*CuisUniversity-Model' stamp: 'HAW 11/27/2021 11:33:51'!
hasAnPrefix
	
	^self continuesWithUppercaseAfterPrefix: 'an'! !

!String methodsFor: '*CuisUniversity-Model' stamp: 'HAW 11/27/2021 11:34:00'!
hasUnPrefix

	^self continuesWithUppercaseAfterPrefix: 'un'! !

!String methodsFor: '*CuisUniversity-Model' stamp: 'HAW 11/27/2021 11:34:08'!
hasUnaPrefix
	
	^self continuesWithUppercaseAfterPrefix: 'una'! !

!String methodsFor: '*CuisUniversity-Model' stamp: 'HAW 11/27/2021 11:36:54'!
uncapitalizedRemovingFirst: numberOfChars
	
	^(self allButFirst: numberOfChars) uncapitalized ! !

!Parser methodsFor: '*CuisUniversity-Model' stamp: 'HAW 12/23/2019 12:22:55'!
performInteractiveChecks: aMethodNode

	self
		warnIfPossibilityOfSelfRecursion: aMethodNode;
		declareUndeclaredTemps: aMethodNode;
		removeUnusedTempsOf: aMethodNode ! !

!Parser methodsFor: '*CuisUniversity-Model' stamp: 'RNG 1/19/2018 20:46:19'!
possibleSelfRecursionWarningMessage: aSelector

	^ 'Warning: possibility of infinite recursion.'
	, String crString ,
	'Sending ' , aSelector printString
	, ' to self inside the method body'! !

!Parser methodsFor: '*CuisUniversity-Model' stamp: 'HAW 1/7/2019 15:02:24'!
warnIfPossibilityOfSelfRecursion: aMethodNode

	^ aMethodNode sendsRecursivelyToSelf ifTrue: [
		| answer |
		answer := PopUpMenu
			confirm: (self possibleSelfRecursionWarningMessage: aMethodNode selector)
			trueChoice: 'Ignore and continue'
			falseChoice: 'Change'
			 icons: #(acceptIcon cancelIcon).
		answer ifFalse: [ self fail ]
	]! !

!ParseNode methodsFor: '*CuisUniversity-Model' stamp: 'RNG 12/31/2017 19:10:30'!
sendsMessageToSelf: aSelector

	^ false! !

!ParseNode methodsFor: '*CuisUniversity-Model' stamp: 'RNG 12/31/2017 19:06:07'!
sendsRecursivelyToSelf

	^ false! !

!BlockNode methodsFor: '*CuisUniversity-Model' stamp: 'RNG 12/31/2017 19:11:55'!
sendsMessageToSelf: aSelector

	^ self statements anySatisfy: [ :statementNode | statementNode sendsMessageToSelf: aSelector ]! !

!MethodNode methodsFor: '*CuisUniversity-Model' stamp: 'RNG 12/31/2017 19:10:04'!
sendsRecursivelyToSelf

	^ self body sendsMessageToSelf: self selector! !

!VariableNode class methodsFor: '*CuisUniversity-Model' stamp: 'RNG 1/19/2018 20:50:48'!
named: aString 

	^ self new name: aString; yourself! !

!MessageNode methodsFor: '*CuisUniversity-Model' stamp: 'HAW 3/14/2019 11:13:47'!
sendsMessageToSelf: aSelector

	^ self receiver referencesSelf and: [ self selector isNamed: aSelector ]! !

!PopUpMenu class methodsFor: '*CuisUniversity-Model' stamp: 'HAW 3/24/2020 17:10:15'!
informBlockingUI: aStringToShow

	(self labels: ' OK ' icons: #(emblemImportantIcon)) startUpWithCaption: aStringToShow ! !
CuisUniversityInstallation initialize!
