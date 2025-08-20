'From Cuis7.5 [latest update: #7428] on 20 August 2025 at 11:37:37 am'!
'Description Avoid using well know object as parameter name'!
!provides: 'Debugger-MethodCreation' 1 2!
SystemOrganization addCategory: #'Debugger-MethodCreation-Tests'!


!classDefinition: #StringCuisUniversityExtentionsTest category: #'Debugger-MethodCreation-Tests'!
TestCase subclass: #StringCuisUniversityExtentionsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Debugger-MethodCreation-Tests'!
!classDefinition: 'StringCuisUniversityExtentionsTest class' category: #'Debugger-MethodCreation-Tests'!
StringCuisUniversityExtentionsTest class
	instanceVariableNames: ''!


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

!VariableNode methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 3/30/2024 19:31:20'!
argumentNameForNewMessageSentFrom: aSender toImplementIn: aClass 

	| argumentName |
	
	argumentName := self isPseudoVariable
		ifTrue: [ self pseudoVariableNameIn: aSender ]
		ifFalse: [ self name ].
	
	^ (aClass definesInstanceVariableNamedInHierarchy: argumentName) 
		ifTrue: [ argumentName article, argumentName capitalized ]
		ifFalse: [ argumentName ]
	! !

!VariableNode methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 11/30/2022 18:23:27'!
isPseudoVariable

	^ self isFalsePseudoVariable
		or: [ self isTruePseudoVariable
		or: [ self isSelfPseudoVariable
		or: [ self isSuperPseudoVariable
		or: [ self isThisContextPseudoVariable
		or: [ self isNilPseudoVariable ]]]]]! !

!VariableNode methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 11/30/2022 18:29:22'!
pseudoVariableNameIn: aContext

	(self isSelfPseudoVariable or: [ self isSuperPseudoVariable] ) ifTrue: [ ^aContext receiver argumentName ].
	(self isFalsePseudoVariable or: [ self isTruePseudoVariable]) ifTrue: [ ^ 'aBoolean' ].
	self isThisContextPseudoVariable ifTrue: [ ^ 'aMethodContext' ].
	
	^'anObject'! !

!Debugger methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 8/20/2025 11:35:04'!
argumentNamesForMessageSent: senderNode from: aSender toImplementIn: aClass 

	| cantDeduceNameCounter |
	
	cantDeduceNameCounter := 0.
	
	^ senderNode arguments collect: [ :argumentNode | |candidateName|
		candidateName := argumentNode isVariableNode 
			ifTrue: [ argumentNode argumentNameForNewMessageSentFrom: aSender toImplementIn: aClass] 
			ifFalse: [ '' ].
	
		(candidateName isEmpty or: [ Smalltalk includesKey: candidateName asSymbol ])
			ifTrue: [
				cantDeduceNameCounter := cantDeduceNameCounter + 1.
				Message renameMeIdentifier, cantDeduceNameCounter printString] 
			ifFalse: [ candidateName ]
	]! !

!Debugger methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 1/27/2023 11:00:52'!
argumentNamesFrom: aMessage

	| cantDeduceNameCounter |
	
	cantDeduceNameCounter := 0.
	
	^aMessage arguments collect: [ :argumentNode | 
		cantDeduceNameCounter := cantDeduceNameCounter + 1.
		Message renameMeIdentifier, cantDeduceNameCounter printString ]! !

!Debugger methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 3/30/2024 19:29:33'!
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

!Debugger methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 3/30/2024 19:24:11'!
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

!Debugger methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 3/30/2024 19:24:11'!
compileInstanceCreationMessage: aMessage in: aCategory fromClass: aClass context: aContext 
	
	| argumentNames |
	
	argumentNames := self argumentNamesOf: aMessage sentIn: aContext sender toImplementIn: aClass.
	aClass
		compile: (aMessage createInstanceCreationMessageFor: aClass with: argumentNames)
		classified: aCategory
! !

!Debugger methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 3/30/2024 19:24:11'!
compileMessage: aMessage inCategory: aCategory fromClass: aClass context: aContext
	
	| argumentNames methodSourceCode |
	
	argumentNames := self argumentNamesOf: aMessage sentIn: aContext sender toImplementIn: aClass.
	
	methodSourceCode := aMessage createStubMethodFor: aClass with: argumentNames.
	
	aClass
		compile: methodSourceCode
		classified: aCategory! !

!Debugger methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 10/10/2019 11:08:45'!
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

!Behavior methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 1/27/2023 11:17:44'!
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

!CharacterSequence methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 3/24/2025 18:30:31'!
asInstanceVariableName
	
	^self asInstanceVariableNameIfHasNoPrefix: [ self asInstanceVariableNameUncapitilized ]
	! !

!CharacterSequence methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 3/24/2025 18:30:13'!
asInstanceVariableNameIfHasNoPrefix: aBlock
	
	self hasAnPrefix ifTrue: [ ^self uncapitalizedRemovingFirst: 2 ].
	self hasAPrefix ifTrue: [ ^self uncapitalizedRemovingFirst: 1 ].
	self hasUnPrefix ifTrue: [ ^self uncapitalizedRemovingFirst: 2 ].
	self hasUnaPrefix ifTrue: [ ^self uncapitalizedRemovingFirst: 3 ].
	
	^aBlock value
	! !

!CharacterSequence methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 1/13/2023 10:09:50'!
asInstanceVariableNameUncapitilized 

	| instVarName |
	
	instVarName := self uncapitalized.
	^self = instVarName 
		ifTrue: [ instVarName, '_CHANGE_ME' ]
		ifFalse: [ instVarName ]! !

!CharacterSequence methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 1/13/2023 10:09:55'!
continuesWithUppercaseAfterPrefix: aPrefix
	
	^(self beginsWith: aPrefix) and: [ self size > aPrefix size and: [ (self at: aPrefix size + 1) isUppercase ]]! !

!CharacterSequence methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 1/13/2023 10:10:01'!
hasAPrefix
	
	^self continuesWithUppercaseAfterPrefix: 'a'! !

!CharacterSequence methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 1/13/2023 10:10:07'!
hasAnPrefix
	
	^self continuesWithUppercaseAfterPrefix: 'an'! !

!CharacterSequence methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 1/13/2023 10:10:13'!
hasUnPrefix

	^self continuesWithUppercaseAfterPrefix: 'un'! !

!CharacterSequence methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 1/13/2023 10:10:18'!
hasUnaPrefix
	
	^self continuesWithUppercaseAfterPrefix: 'una'! !

!CharacterSequence methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 1/13/2023 10:10:24'!
uncapitalizedRemovingFirst: numberOfChars
	
	^(self allButFirst: numberOfChars) uncapitalized ! !

!Message methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 10/8/2019 16:04:23'!
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

!Message methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 11/12/2019 09:05:37'!
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

!Message methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 10/8/2019 16:05:36'!
createInitializeMessageWith: argumentNames forEachInstVarNameDo: instVarNameBlock 

	^ String streamContents: [ :stream |
		self createInitializeMessageDefinitionIn: stream with: argumentNames.
		stream newLine;tab.		
		self writeShouldBeImplementedOn: stream.
		self createInitializationMessageAssigmentsIn: stream with: argumentNames forEachInstVarNameDo: instVarNameBlock ]! !

!Message methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 7/3/2023 12:12:47'!
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

!Message methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 7/28/2023 15:43:21'!
createStubMethodFor: aClass with: argumentNames 

	^ String streamContents: [ :stream |
		self writeMessageNameOn: stream with: argumentNames.
		stream newLine; tab.
		self writeShouldBeImplementedOn: stream.
		(self isGetterFor: aClass) ifTrue: [ self addGetterCodeOn: stream ].
		(self isSetterFor: aClass) ifTrue: [ self addSetterCodeOn: stream with: argumentNames first ].
	]! !

!Message methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 10/7/2019 14:49:23'!
isInitializer 

	^selector beginsWith: 'initialize'.! !

!Message methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 2/10/2023 15:42:28'!
writeMessageNameOn: aStream with: argumentNames 

	self selector keywords withIndexDo: [ :keyword :index |
		aStream nextPutAll: keyword.
		self hasArguments ifTrue: [ self writeOn: aStream argumentNameAt: index from: argumentNames ]].
	
	! !

!Message methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 2/10/2023 15:42:10'!
writeOn: aStream argumentNameAt: index from: argumentNames  

	| argumentName |
	
	argumentName _ argumentNames at: index.
	
	aStream 
		nextPutAll: ' '; 
		nextPutAll: argumentName; 
		space
	
	! !

!Message class methodsFor: '*Debugger-MethodCreation' stamp: 'HAW 10/5/2022 12:41:12'!
renameMeIdentifier

	^'aRenameMe'! !
