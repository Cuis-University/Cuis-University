'From Cuis 5.0 of 7 November 2016 [latest update: #3659] on 18 March 2019 at 2:47:17 pm'!
'Description renamed to isNamed:'!
!provides: 'Cuis-University-Model' 1 17!
!requires: 'DenotativeObject' 1 21 nil!
!requires: 'Chalten' 1 6 nil!
SystemOrganization addCategory: #'Cuis-University-Model'!


!classDefinition: #CuisUniversityInstallation category: #'Cuis-University-Model'!
Object subclass: #CuisUniversityInstallation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuis-University-Model'!
!classDefinition: 'CuisUniversityInstallation class' category: #'Cuis-University-Model'!
CuisUniversityInstallation class
	instanceVariableNames: ''!


!CuisUniversityInstallation class methodsFor: 'initialization' stamp: 'HAW 2/28/2019 22:40:41'!
initialize

	UnitsTestResource  installUnitsAsGlobals.
	TimeUnits installUnitsAsGlobals.
	StackSizeWatcher startWatchingWithDefaults.
	DenotativeObjectTheme beCurrent.
	
	! !

!CuisUniversityInstallation class methodsFor: 'initialization' stamp: 'HAW 2/28/2019 22:40:25'!
initializeWhitLiveTypingVM

	self 
		runAllTests;
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

!Parser methodsFor: '*Cuis-University-Model' stamp: 'HAW 8/13/2018 11:55:17'!
performInteractiveChecks: aMethodNode

	self
		warnIfPossibilityOfSelfRecursion: aMethodNode;
		declareUndeclaredTemps: aMethodNode;
		removeUnusedTemps! !

!Parser methodsFor: '*Cuis-University-Model' stamp: 'RNG 1/19/2018 20:46:19'!
possibleSelfRecursionWarningMessage: aSelector

	^ 'Warning: possibility of infinite recursion.'
	, String crString ,
	'Sending ' , aSelector printString
	, ' to self inside the method body'! !

!Parser methodsFor: '*Cuis-University-Model' stamp: 'HAW 1/7/2019 15:02:24'!
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

!ParseNode methodsFor: '*Cuis-University-Model' stamp: 'RNG 12/31/2017 19:16:13'!
referencesSelf

	^ false! !

!ParseNode methodsFor: '*Cuis-University-Model' stamp: 'RNG 12/31/2017 19:10:30'!
sendsMessageToSelf: aSelector

	^ false! !

!ParseNode methodsFor: '*Cuis-University-Model' stamp: 'RNG 12/31/2017 19:06:07'!
sendsRecursivelyToSelf

	^ false! !

!BlockNode methodsFor: '*Cuis-University-Model' stamp: 'RNG 12/31/2017 19:11:55'!
sendsMessageToSelf: aSelector

	^ self statements anySatisfy: [ :statementNode | statementNode sendsMessageToSelf: aSelector ]! !

!BlockNode class methodsFor: '*Cuis-University-Model' stamp: 'RNG 1/19/2018 21:06:55'!
empty

	^ self statements: #() returns: false! !

!SelectorNode methodsFor: '*Cuis-University-Model' stamp: 'HAW 3/14/2019 11:14:25'!
isNamed: aSelectorName

	^ self key = aSelectorName! !

!VariableNode methodsFor: '*Cuis-University-Model' stamp: 'RNG 12/31/2017 19:16:41'!
referencesSelf

	^ self name = 'self'! !

!VariableNode class methodsFor: '*Cuis-University-Model' stamp: 'RNG 1/19/2018 20:50:48'!
named: aString 

	^ self new name: aString; yourself! !

!MessageNode methodsFor: '*Cuis-University-Model' stamp: 'HAW 3/14/2019 11:13:47'!
sendsMessageToSelf: aSelector

	^ self receiver referencesSelf and: [ self selector isNamed: aSelector ]! !

!MethodNode methodsFor: '*Cuis-University-Model' stamp: 'RNG 12/31/2017 19:10:04'!
sendsRecursivelyToSelf

	^ self body sendsMessageToSelf: self selector! !
CuisUniversityInstallation initialize!
