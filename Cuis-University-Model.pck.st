'From Cuis 5.0 of 7 November 2016 [latest update: #3174] on 19 January 2018 at 9:09:33 pm'!
'Description Please enter a description for this package'!
!provides: 'Cuis-University-Model' 1 0!

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

!Debugger methodsFor: '*Cuis-University-Model' stamp: 'RNG 1/1/2018 21:46:08'!
askForSuperclassOf: aClass toImplement: aSelector ifCancel: cancelBlock

	^self askForSuperclassOf: aClass upTo: Object toImplement: aSelector ifCancel: cancelBlock
! !
