'From Cuis7.1 [latest update: #6578] on 10 August 2024 at 4:33:48 pm'!
'Description Udated to Cuis 7.1'!
!provides: 'CuisUniversity' 1 31!
!requires: 'SystemCategoryAutoSaving' 1 0 nil!
!requires: 'TDDGuru' 1 50 nil!
!requires: 'Morphic-Widgets-Extras' 1 38 nil!
!requires: 'DenotativeObject' 1 97 nil!
!requires: 'Tools-Finder' 1 49 nil!
!requires: 'ComplexRefactorings' 1 0 nil!
!requires: 'MoveInstanceVariableRefactoring' 1 30 nil!
!requires: 'Chalten' 1 18 nil!
SystemOrganization addCategory: #'CuisUniversity-Model'!
SystemOrganization addCategory: #'CuisUniversity-Tests'!


!classDefinition: #CuisUniversityInstallation category: #'CuisUniversity-Model'!
Object subclass: #CuisUniversityInstallation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CuisUniversity-Model'!
!classDefinition: 'CuisUniversityInstallation class' category: #'CuisUniversity-Model'!
CuisUniversityInstallation class
	instanceVariableNames: ''!

!classDefinition: #StringCuisUniversityExtentionsTest category: #'CuisUniversity-Tests'!
TestCase subclass: #StringCuisUniversityExtentionsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CuisUniversity-Tests'!
!classDefinition: 'StringCuisUniversityExtentionsTest class' category: #'CuisUniversity-Tests'!
StringCuisUniversityExtentionsTest class
	instanceVariableNames: ''!


!CuisUniversityInstallation class methodsFor: 'initialization' stamp: 'HAW 8/10/2024 16:33:25'!
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
	Preferences name: #showAssignmentAsLeftArrow category: #programming value: false.
	Preferences name: #spaceTabOpensAutoCompletion category: #gui value: true.
	
	BrowserWindow at: #systemCategoriesListMenuSpec registerMenuAndShortcutsSpecProvider:
		(MessageSend receiver: CuisUniversityInstallation selector: #systemCategoriesListMenuSpec).! !

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

!CuisUniversityInstallation class methodsFor: 'welcome window' stamp: 'HAW 11/3/2023 18:12:35'!
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
- 10Pines SRL: Este ambiente no sería posible sin la horas de trabajo cedidas por 10Pines para hacerlo.'' runs: (RunArray runs: #(14 1 1605 ) values: ((Array new: 3) at: 1 put: ((Array new: 4) at: 1 put: (TextFontFamily basicNew instVarAt: 1 put: ''DejaVu''; yourself); at: 2 put: (TextEmphasis basicNew instVarAt: 1 put: 1; yourself); at: 3 put: (TextColor basicNew instVarAt: 1 put: (Color r: 0.000 g: 0.000 b: 1.000); yourself); at: 4 put: (TextAlignment basicNew instVarAt: 1 put: 2; yourself); yourself); at: 2 put: ((Array new: 1) at: 1 put: (TextAlignment basicNew instVarAt: 1 put: 2; yourself); yourself); at: 3 put: #(); yourself)))'! !

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

!CuisUniversityInstallation class methodsFor: 'menu & kbd shortcuts' stamp: 'jmv 7/30/2024 15:36:02'!
systemCategoriesListMenuSpec
	"
	BrowserWindow at: #systemCategoriesListMenuSpec registerMenuAndShortcutsSpecProvider:
		(MessageSend receiver: CuisUniversityInstallation selector: #systemCategoriesListMenuSpec).
	Do this in CuisUniversityInstallation class >> initialize
	"
	^#(
		#(121		'change new line encode...' 							nil 	model 			changeNewLineEncode 								updateIcon)
		#(300 		'-----')
		#(310		'create package' 							nil 	model 			createPackage 								packageIcon)
	)! !

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

!ProtoObject methodsFor: '*CuisUniversity' stamp: 'HAW 2/28/2024 15:59:37'!
forceBecome: anotherObject

	^{ self } elementsExchangeIdentityWith: { anotherObject }! !

!Object methodsFor: '*CuisUniversity-Model' stamp: 'HAW 3/24/2020 17:10:28'!
informBlockingUI: aStringToShow
	"Display aString blocking the UI"

	aStringToShow isEmptyOrNil ifFalse: [PopUpMenu informBlockingUI: aStringToShow]! !

!CharacterSequence methodsFor: '*CuisUniversity-Model' stamp: 'HAW 1/13/2023 10:09:44'!
asInstanceVariableName
	
	self hasAnPrefix ifTrue: [ ^self uncapitalizedRemovingFirst: 2 ].
	self hasAPrefix ifTrue: [ ^self uncapitalizedRemovingFirst: 1 ].
	self hasUnPrefix ifTrue: [ ^self uncapitalizedRemovingFirst: 2 ].
	self hasUnaPrefix ifTrue: [ ^self uncapitalizedRemovingFirst: 3 ].
	
	^self asInstanceVariableNameUncapitilized 
	! !

!CharacterSequence methodsFor: '*CuisUniversity-Model' stamp: 'HAW 1/13/2023 10:09:50'!
asInstanceVariableNameUncapitilized 

	| instVarName |
	
	instVarName := self uncapitalized.
	^self = instVarName 
		ifTrue: [ instVarName, '_CHANGE_ME' ]
		ifFalse: [ instVarName ]! !

!CharacterSequence methodsFor: '*CuisUniversity-Model' stamp: 'HAW 1/13/2023 10:09:55'!
continuesWithUppercaseAfterPrefix: aPrefix
	
	^(self beginsWith: aPrefix) and: [ self size > aPrefix size and: [ (self at: aPrefix size + 1) isUppercase ]]! !

!CharacterSequence methodsFor: '*CuisUniversity-Model' stamp: 'HAW 1/13/2023 10:10:01'!
hasAPrefix
	
	^self continuesWithUppercaseAfterPrefix: 'a'! !

!CharacterSequence methodsFor: '*CuisUniversity-Model' stamp: 'HAW 1/13/2023 10:10:07'!
hasAnPrefix
	
	^self continuesWithUppercaseAfterPrefix: 'an'! !

!CharacterSequence methodsFor: '*CuisUniversity-Model' stamp: 'HAW 1/13/2023 10:10:13'!
hasUnPrefix

	^self continuesWithUppercaseAfterPrefix: 'un'! !

!CharacterSequence methodsFor: '*CuisUniversity-Model' stamp: 'HAW 1/13/2023 10:10:18'!
hasUnaPrefix
	
	^self continuesWithUppercaseAfterPrefix: 'una'! !

!CharacterSequence methodsFor: '*CuisUniversity-Model' stamp: 'HAW 1/13/2023 10:10:24'!
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

!ParseNode methodsFor: '*CuisUniversity-Model' stamp: 'RNG 12/31/2017 19:06:07'!
sendsRecursivelyToSelf

	^ false! !

!MethodNode methodsFor: '*CuisUniversity-Model' stamp: 'RNG 12/31/2017 19:10:04'!
sendsRecursivelyToSelf

	^ self body sendsMessageToSelf: self selector! !

!VariableNode methodsFor: '*CuisUniversity-Model' stamp: 'HAW 3/30/2024 19:31:20'!
argumentNameForNewMessageSentFrom: aSender toImplementIn: aClass 

	| argumentName |
	
	argumentName := self isPseudoVariable
		ifTrue: [ self pseudoVariableNameIn: aSender ]
		ifFalse: [ self name ].
	
	^ (aClass definesInstanceVariableNamedInHierarchy: argumentName) 
		ifTrue: [ argumentName article, argumentName capitalized ]
		ifFalse: [ argumentName ]
	! !

!VariableNode methodsFor: '*CuisUniversity-Model' stamp: 'HAW 11/30/2022 18:23:27'!
isPseudoVariable

	^ self isFalsePseudoVariable
		or: [ self isTruePseudoVariable
		or: [ self isSelfPseudoVariable
		or: [ self isSuperPseudoVariable
		or: [ self isThisContextPseudoVariable
		or: [ self isNilPseudoVariable ]]]]]! !

!VariableNode methodsFor: '*CuisUniversity-Model' stamp: 'HAW 11/30/2022 18:29:22'!
pseudoVariableNameIn: aContext

	(self isSelfPseudoVariable or: [ self isSuperPseudoVariable] ) ifTrue: [ ^aContext receiver argumentName ].
	(self isFalsePseudoVariable or: [ self isTruePseudoVariable]) ifTrue: [ ^ 'aBoolean' ].
	self isThisContextPseudoVariable ifTrue: [ ^ 'aMethodContext' ].
	
	^'anObject'! !

!Behavior methodsFor: '*CuisUniversity-Model' stamp: 'HAW 1/27/2023 11:17:44'!
collectNotDefinedInstanceVariablesFor: variableNames

	| counter proposedVariableName allInstVarNames |
	
	counter := 0.
	allInstVarNames := self allInstVarNames.
	^variableNames collect: [ :variableName |
		proposedVariableName := variableName.
		[ allInstVarNames includes: proposedVariableName ] whileTrue: [
			counter := counter + 1.
			proposedVariableName := variableName, counter printString ].
		proposedVariableName ]
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

!Message methodsFor: '*CuisUniversity-Model' stamp: 'HAW 7/3/2023 12:12:47'!
createInstanceCreationMessageFor: aClass with: argumentNames

	| instanceCreationMessageString |
		
	^ String streamContents: [ :stream |
		self writeMessageNameOn: stream with: argumentNames.
		instanceCreationMessageString := stream contents.
		stream newLine; tab; nextPutAll: '"DO NOT FORGET TO RENAME COLLABORATORS AND REMOVE THIS COMMENT!!!!"';newLine; tab.
		self writeShouldBeImplementedOn: stream.
		stream
			newLine; tab;
			nextPutAll: '^self new initialize', instanceCreationMessageString capitalized ]! !

!Message methodsFor: '*CuisUniversity-Model' stamp: 'HAW 7/28/2023 15:43:21'!
createStubMethodFor: aClass with: argumentNames 

	^ String streamContents: [ :stream |
		self writeMessageNameOn: stream with: argumentNames.
		stream newLine; tab.
		self writeShouldBeImplementedOn: stream.
		(self isGetterFor: aClass) ifTrue: [ self addGetterCodeOn: stream ].
		(self isSetterFor: aClass) ifTrue: [ self addSetterCodeOn: stream with: argumentNames first ].
	]! !

!Message methodsFor: '*CuisUniversity-Model' stamp: 'HAW 10/7/2019 14:49:23'!
isInitializer 

	^selector beginsWith: 'initialize'.! !

!Message methodsFor: '*CuisUniversity-Model' stamp: 'HAW 2/10/2023 15:42:28'!
writeMessageNameOn: aStream with: argumentNames 

	self selector keywords withIndexDo: [ :keyword :index |
		aStream nextPutAll: keyword.
		self hasArguments ifTrue: [ self writeOn: aStream argumentNameAt: index from: argumentNames ]].
	
	! !

!Message methodsFor: '*CuisUniversity-Model' stamp: 'HAW 2/10/2023 15:42:10'!
writeOn: aStream argumentNameAt: index from: argumentNames  

	| argumentName |
	
	argumentName _ argumentNames at: index.
	
	aStream 
		nextPutAll: ' '; 
		nextPutAll: argumentName; 
		space
	
	! !

!Message class methodsFor: '*CuisUniversity-Model' stamp: 'HAW 10/5/2022 12:41:12'!
renameMeIdentifier

	^'aRenameMe'! !

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

!Debugger methodsFor: '*CuisUniversity-Model' stamp: 'HAW 3/30/2024 19:30:31'!
argumentNamesForMessageSent: senderNode from: aSender toImplementIn: aClass 

	| cantDeduceNameCounter |
	
	cantDeduceNameCounter := 0.
	
	^senderNode arguments collect: [ :argumentNode | 
		argumentNode isVariableNode 
			ifTrue: [argumentNode argumentNameForNewMessageSentFrom: aSender toImplementIn: aClass ]
			ifFalse: [ 
				cantDeduceNameCounter := cantDeduceNameCounter + 1.
				Message renameMeIdentifier, cantDeduceNameCounter printString ]]! !

!Debugger methodsFor: '*CuisUniversity-Model' stamp: 'HAW 1/27/2023 11:00:52'!
argumentNamesFrom: aMessage

	| cantDeduceNameCounter |
	
	cantDeduceNameCounter := 0.
	
	^aMessage arguments collect: [ :argumentNode | 
		cantDeduceNameCounter := cantDeduceNameCounter + 1.
		Message renameMeIdentifier, cantDeduceNameCounter printString ]! !

!Debugger methodsFor: '*CuisUniversity-Model' stamp: 'HAW 3/30/2024 19:29:33'!
argumentNamesOf: aMessage sentIn: aSender toImplementIn: aClass 
		
	| argumentNames senderMethodNode senderNode messageSendRange |
	
	senderMethodNode := aSender methodNode.
	messageSendRange := aSender debuggerMap
		rangeForPC: aSender pc
		contextIsActiveContext: false.
	senderNode := (senderMethodNode parseNodeIncluding: messageSendRange first ifAbsent: [ nil -> nil]) key.
	
	 argumentNames := senderNode notNil 
		ifTrue: [ (senderNode isMessageNode and: [ senderNode selectorSymbol = aMessage selector ]) 
			ifTrue: [ self argumentNamesForMessageSent: senderNode from: aSender toImplementIn: aClass]
			ifFalse: [ self argumentNamesFrom: aMessage ]]
		ifFalse: [ self argumentNamesFrom: aMessage].
		
	^aSender receiver class collectNotDefinedInstanceVariablesFor: argumentNames 

! !

!Debugger methodsFor: '*CuisUniversity-Model' stamp: 'HAW 3/30/2024 19:24:11'!
compileInitilizationMessage: aMessage in: aCategory fromClass: aClass context: aContext 
	
	| argumentNames realCategory initializationMethodSourceCode |
	
	argumentNames := self argumentNamesOf: aMessage sentIn: aContext sender toImplementIn: aClass.
	
	realCategory := aCategory = ClassOrganizer defaultMethodCategory 
		ifTrue: [ Categorizer initialization ]  
		ifFalse: [ aCategory ].
	initializationMethodSourceCode := aMessage 
		createInitializeMessageWith: argumentNames 
		forEachInstVarNameDo: [ :anInstVarName |  
			(aClass definesInstanceVariableNamedInHierarchy: anInstVarName) ifFalse: [ aClass addInstVarName: anInstVarName ]].
		
	aClass
		compile: initializationMethodSourceCode
		classified: realCategory
		! !

!Debugger methodsFor: '*CuisUniversity-Model' stamp: 'HAW 3/30/2024 19:24:11'!
compileInstanceCreationMessage: aMessage in: aCategory fromClass: aClass context: aContext 
	
	| argumentNames |
	
	argumentNames := self argumentNamesOf: aMessage sentIn: aContext sender toImplementIn: aClass.
	aClass
		compile: (aMessage createInstanceCreationMessageFor: aClass with: argumentNames)
		classified: aCategory
! !

!Debugger methodsFor: '*CuisUniversity-Model' stamp: 'HAW 3/30/2024 19:24:11'!
compileMessage: aMessage inCategory: aCategory fromClass: aClass context: aContext
	
	| argumentNames methodSourceCode |
	
	argumentNames := self argumentNamesOf: aMessage sentIn: aContext sender toImplementIn: aClass.
	
	methodSourceCode := aMessage createStubMethodFor: aClass with: argumentNames.
	
	aClass
		compile: methodSourceCode
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

!PopUpMenu class methodsFor: '*CuisUniversity-Model' stamp: 'HAW 3/24/2020 17:10:15'!
informBlockingUI: aStringToShow

	(self labels: ' OK ' icons: #(emblemImportantIcon)) startUpWithCaption: aStringToShow ! !
CuisUniversityInstallation initialize!
