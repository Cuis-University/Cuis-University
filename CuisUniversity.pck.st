'From Cuis7.5 [latest update: #7594] on 20 September 2025 at 6:48:26 pm'!
'Description Removes addtional dot'!
!provides: 'CuisUniversity' 1 40!
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

!classDefinition: #ObjectExtentionsTest category: #'CuisUniversity-Tests'!
TestCase subclass: #ObjectExtentionsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CuisUniversity-Tests'!
!classDefinition: 'ObjectExtentionsTest class' category: #'CuisUniversity-Tests'!
ObjectExtentionsTest class
	instanceVariableNames: ''!


!CuisUniversityInstallation class methodsFor: 'initialization' stamp: 'HAW 8/20/2025 12:01:52'!
initialize

	self renameMKCategories.
	self removeSystemChangesFromChangeSet.
	
	UnitsTestResource  installUnitsAsGlobals.
	TimeUnits installUnitsAsGlobals.
	self addSpanishUnits.
	
	StackSizeWatcher startWatchingWithDefaults.
	DenotativeObjectTheme beCurrent.
	Preferences name: #autoNumberUserChanges category: #system value: false.
	Preferences name: #logDebuggerStackToFile category: #programming value: false.
	Preferences name: #checkLostChangesOnStartUp category: #system value: true.
	Preferences name: #methodAnnotations category: #programming value: #(timeStamp messageCategory packages changeSets).
	Preferences name: #classAnnotations category: #programming value: #(instanceMethodsCount classMethodsCount).
	Preferences name: #systemCategoryAnnotations category: #programming value: #(classCount instanceMethodsCount classMethodsCount).
	Preferences name: #showAssignmentAsLeftArrow category: #programming value: false.
	Preferences name: #spaceTabOpensAutoCompletion category: #gui value: true.
	
	BrowserWindow 
		at: #systemCatListMenuSpec 
		registerMenuAndShortcutsSpecProvider: self systemCategoriesListMenuSpecSend.! !

!CuisUniversityInstallation class methodsFor: 'initialization' stamp: 'HAW 3/6/2021 18:44:01'!
initializeWithLiveTypingVM

	self 
		"runAllTests;"
		removeSystemChangesFromChangeSet;
		openWelcomeWindow.

	TranscriptWindow allInstancesDo: [:aTranscriptWindow | aTranscriptWindow delete ].
! !

!CuisUniversityInstallation class methodsFor: 'initialization' stamp: 'HAW 4/29/2025 08:14:40'!
unload

	"More things to undone... - Hernan"
	
	BrowserWindow 
		at: #systemCatListMenuSpec 
		unregisterMenuAndShortcutsSpecProvider: self systemCategoriesListMenuSpecSend.! !

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

!CuisUniversityInstallation class methodsFor: 'menu & kbd shortcuts' stamp: 'HAW 4/29/2025 08:17:48'!
systemCatListMenuSpec
	
	^#(
		#(121		'Change New Line Encode...' 							nil 	model 			changeNewLineEncode 								updateIcon)
		#(310		'Create Package' 							nil 	model 			createPackage 								packageIcon)
	)! !

!CuisUniversityInstallation class methodsFor: 'menu & kbd shortcuts' stamp: 'HAW 4/29/2025 08:17:48'!
systemCategoriesListMenuSpecSend

	^ MessageSend receiver: self selector: #systemCatListMenuSpec! !

!CuisUniversityInstallation class methodsFor: 'rename mk categories' stamp: 'HAW 8/20/2025 09:37:54'!
renameMKCategories

	ProtoObject withAllSubclassesDo: [ :aClass | | beforeSelectorsSize |
		beforeSelectorsSize := aClass selectors size.
		self renameMKCategoriesOf: aClass.	
		beforeSelectorsSize ~= aClass selectors size ifTrue: [ self halt ] ]
	
	! !

!CuisUniversityInstallation class methodsFor: 'rename mk categories' stamp: 'HAW 8/20/2025 09:38:22'!
renameMKCategoriesOf: aClass

	aClass methodCategories 
		select: [ :aCategory | aCategory beginsWith: '[' ]
		thenDo: [ :aCategory | | newCategory selectors | 
			"I assume all [m..] follow the same pattern of leaving an space after it - Hernan"
			newCategory := aCategory last: aCategory size - (aCategory indexOf: $ ).
			selectors := aClass organization listAtCategoryNamed: aCategory.
			aClass organization classifyAll: selectors under: newCategory.
			aClass organization removeCategory: aCategory ]! !

!CuisUniversityInstallation class methodsFor: 'units' stamp: 'HAW 9/20/2025 18:11:00'!
addSpanishUnits
	"Thanks Facu"
	
	" Unidades en castellano, inspirado en https://github.com/Cuis-University/Cuis-University/issues/3 "
	Smalltalk at: #miligramo put: milligram.
	Smalltalk at: #gramo put: gram.
	Smalltalk at: #kilogramo put: kilogram.

	Smalltalk at: #milisegundo put: millisecond.
	Smalltalk at: #segundo put: second.
	Smalltalk at: #minuto put: minute.
	Smalltalk at: #hora put: hour.
	Smalltalk at: #día put: day.
	Smalltalk at: #semana put: week.
	Smalltalk at: #mes put: month.
	Smalltalk at: #año put: year.

	Smalltalk at: #milímetro put: millimeter.
	Smalltalk at: #centímetro put: centimeter.
	Smalltalk at: #decímetro put: decimeter.
	Smalltalk at: #metro put: meter.
	Smalltalk at: #decámetro put: decameter.
	Smalltalk at: #hectómetro put: hectometer.
	Smalltalk at: #kilómetro put: kilometer.

	Smalltalk at: #dólar put: dollar.

	" Infinito en castellano "
	Smalltalk at: #infinito put: infinity.
	Smalltalk at: #menosInfinito put: minusInfinity.
	Smalltalk at: #másInfinito put: infinity.! !

!CuisUniversityInstallation class methodsFor: 'units' stamp: 'HAW 8/20/2025 09:46:53'!
removeDuplicatedUnits
	"Thanks Facu"
	
	" Eliminar unidades duplicadas (creemos que es un bug) "
	Unit allSubInstances groupBy: [:unit | unit name]
		:: select: [:group | group size > 1]
		:: do: [:group | |originalUnit|
			originalUnit := group first.
			group allButFirst do: [:duplicatedUnit | duplicatedUnit becomeForward: originalUnit ]
		].! !

!ObjectExtentionsTest methodsFor: 'tests' stamp: 'HAW 5/7/2025 12:16:40'!
test01_NotEqualMessageAsInCBehavesAsNotEqual

	self assert: 1 !!= 2.
	self deny: 1 !!= 1

! !

!ObjectExtentionsTest methodsFor: 'tests' stamp: 'HAW 5/7/2025 12:17:03'!
test02_NotEqualMessageAsInMathBehavesAsNotEqual

	self assert: 1 <> 2.
	self deny: 1 <> 1

! !

!ProtoObject methodsFor: '*CuisUniversity' stamp: 'HAW 2/28/2024 15:59:37'!
forceBecome: anotherObject

	^{ self } elementsExchangeIdentityWith: { anotherObject }! !

!Object methodsFor: '*CuisUniversity-Model' stamp: 'HAW 5/7/2025 12:15:00'!
!!= anObject 
	
	"Just for convinience - Hernan"

	^self ~= anObject! !

!Object methodsFor: '*CuisUniversity-Model' stamp: 'HAW 5/7/2025 12:14:52'!
<> anObject 

	"Just for convinience - Hernan"

	^self ~= anObject! !

!Object methodsFor: '*CuisUniversity-Model' stamp: 'HAW 3/24/2020 17:10:28'!
informBlockingUI: aStringToShow
	"Display aString blocking the UI"

	aStringToShow isEmptyOrNil ifFalse: [PopUpMenu informBlockingUI: aStringToShow]! !

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

!PopUpMenu class methodsFor: '*CuisUniversity-Model' stamp: 'HAW 3/24/2020 17:10:15'!
informBlockingUI: aStringToShow

	(self labels: ' OK ' icons: #(emblemImportantIcon)) startUpWithCaption: aStringToShow ! !
CuisUniversityInstallation initialize!
