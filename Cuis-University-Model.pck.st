'From Cuis 5.0 of 7 November 2016 [latest update: #3285] on 11 April 2018 at 7:40:34 pm'!
'Description change on the menu option to open DenotativeObject browser'!
!provides: 'Cuis-University-Model' 1 8!
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


!CuisUniversityInstallation class methodsFor: 'initialization' stamp: 'HAW 3/28/2018 16:48:46'!
initialize

	UnitsTestResource  installUnitsAsGlobals.
	TimeUnits installUnitsAsGlobals.
	StackSizeWatcher startWatchingWithDefaults.
	DenotativeObjectTheme beCurrent.
	TranscriptWindow allInstancesDo: [:aTranscriptWindow | aTranscriptWindow delete ].
	self openWelcomeWindow.! !

!CuisUniversityInstallation class methodsFor: 'welcome window' stamp: 'HAW 3/28/2018 19:59:40'!
openWelcomeWindow

	| welcomeWindow |
	
	welcomeWindow := SystemWindow editText: (TextModel withText: (self welcomeWindowContents)) label: '¡Bienvenidos a CuisUniversity!!' wrap: true.
	welcomeWindow resize: (Rectangle origin: 45@40 extent: 910@435)! !

!CuisUniversityInstallation class methodsFor: 'welcome window' stamp: 'HAW 4/11/2018 15:30:10'!
welcomeWindowContents

	^Compiler evaluate: '(Text string: ''CuisUniversity

Este es un ambiente creado especialmente para la enseñanza de la Programación Orientada a Objetos, usando Smalltalk como herramienta y en particular la implementación Argentina de Smalltalk denominada Cuis.

El objetivo es que los interesados empiecen aprendiendo qué significa trabajar con objetos concretos (denotative objects) para luego pasar a implementaciones más complejas del paradigma.

Para trabajar con objetos concretos, solo basta elegir la opcion "DenotativeObject Browser" del menú principal.
Para videos que muestran cómo usar CuisUniversity ir a: https://www.youtube.com/playlist?list=PLMkq_h36PcLCQiU5gxNmedxdXbl10JYeV

Este ambiente viene con los siguientes paquetes instalados:
- DenotativeObject: Herramienta que permite trabajar con Objetos sin Clases
- Refactoring: Implementacion de refactorings automatizados para Cuis.
- Aconcagua: Posibilita trabajar con medidas 
- Chalten: Implementación del Calendario Gregoriano. Usa Aconcagua

Implementadores:
- Hernán Wilkinson, Máximo Prieto, Juan Manuel Vuletich

Colaboradores
- Nahuel Garbezza, Gastón Caruso, Angeles Tella Arena, Matias Melendi

Sponsors:
- 10Pines SRL: Este ambiente no sería posible sin la horas de trabajo cedidas por 10Pines para hacerlo.'' runs: (RunArray runs: #(14 1 1230 ) values: ((Array new: 3) at: 1 put: ((Array new: 4) at: 1 put: (TextFontFamilyAndSize basicNew instVarAt: 1 put: ''DejaVu''; instVarAt: 2 put: 22; yourself); at: 2 put: (TextEmphasis basicNew instVarAt: 1 put: 1; yourself); at: 3 put: (TextColor basicNew instVarAt: 1 put: (Color r: 0.000 g: 0.000 b: 1.000); yourself); at: 4 put: (TextAlignment basicNew instVarAt: 1 put: 2; yourself); yourself); at: 2 put: ((Array new: 1) at: 1 put: (TextAlignment basicNew instVarAt: 1 put: 2; yourself); yourself); at: 3 put: #(); yourself)))'! !

!Debugger methodsFor: '*Cuis-University-Model' stamp: 'RNG 1/1/2018 21:46:08'!
askForSuperclassOf: aClass toImplement: aSelector ifCancel: cancelBlock

	^self askForSuperclassOf: aClass upTo: Object toImplement: aSelector ifCancel: cancelBlock
! !

!Parser methodsFor: '*Cuis-University-Model' stamp: 'RNG 1/1/2018 13:14:10'!
method: doit context: ctxt 
	" pattern [ | temporaries ] block => MethodNode."

	| sap blk prim temps messageComment methodNode |
	sap := self pattern: doit inContext: ctxt.
	"sap={selector, arguments, precedence}"
	self properties selector: (sap at: 1).
	encoder selector: (sap at: 1).
	(sap at: 2) do: [:argNode | argNode beMethodArg].
	doit ifFalse: [self pragmaSequence].
	temps := self temporaries.
	messageComment := currentComment.
	currentComment := nil.
	doit ifFalse: [self pragmaSequence].
	prim := self pragmaPrimitives.
	self statements: #() innerBlock: doit.
	blk := parseNode.
	doit ifTrue: [blk returnLast]
		ifFalse: [blk returnSelfIfNoOther: encoder].
	hereType == #doIt ifFalse: [^self expected: 'Nothing more'].
	methodNode := self newMethodNode comment: messageComment.
	methodNode
		selector: (sap at: 1)
		arguments: (sap at: 2)
		precedence: (sap at: 3)
		temporaries: temps
		block: blk
		encoder: encoder
		primitive: prim
		properties: properties.
	self interactive ifTrue: [ self performInteractiveChecks: methodNode ].
	^methodNode! !

!Parser methodsFor: '*Cuis-University-Model' stamp: 'RNG 1/1/2018 13:13:55'!
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

!Parser methodsFor: '*Cuis-University-Model' stamp: 'RNG 1/19/2018 20:45:41'!
warnIfPossibilityOfSelfRecursion: aMethodNode

	^ aMethodNode sendsRecursivelyToSelf ifTrue: [
		| answer |
		answer := PopUpMenu
			confirm: (self possibleSelfRecursionWarningMessage: aMethodNode selector)
			trueChoice: 'Ignore and continue'
			falseChoice: 'Change'.
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

!SelectorNode methodsFor: '*Cuis-University-Model' stamp: 'RNG 12/31/2017 19:22:06'!
named: aSelectorName

	^ self key = aSelectorName! !

!VariableNode methodsFor: '*Cuis-University-Model' stamp: 'RNG 12/31/2017 19:16:41'!
referencesSelf

	^ self name = 'self'! !

!VariableNode class methodsFor: '*Cuis-University-Model' stamp: 'RNG 1/19/2018 20:50:48'!
named: aString 

	^ self new name: aString; yourself! !

!MessageNode methodsFor: '*Cuis-University-Model' stamp: 'RNG 12/31/2017 19:22:17'!
sendsMessageToSelf: aSelector

	^ self receiver referencesSelf and: [ self selector named: aSelector ]! !

!MethodNode methodsFor: '*Cuis-University-Model' stamp: 'RNG 12/31/2017 19:10:04'!
sendsRecursivelyToSelf

	^ self body sendsMessageToSelf: self selector! !
CuisUniversityInstallation initialize!
