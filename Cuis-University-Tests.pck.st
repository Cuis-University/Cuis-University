'From Cuis 5.0 [latest update: #3938] on 29 October 2019 at 5:56:07 pm'!
'Description Requeriments for Extract Method, Extract To Method Object and TDDGuru'!
!provides: 'Cuis-University-Tests' 1 3!
!requires: 'Cuis-University-Model' 1 0 nil!
!requires: 'Tests-Refactorings-ExtractMethod' 1 18 nil!
SystemOrganization addCategory: #'Cuis-University-Tests'!


!classDefinition: #ParseNodeTest category: #'Cuis-University-Tests' stamp: 'HAW 10/29/2019 17:56:07'!
TestCase subclass: #ParseNodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuis-University-Tests'!
!classDefinition: 'ParseNodeTest class' category: #'Cuis-University-Tests' stamp: 'HAW 10/29/2019 17:56:07'!
ParseNodeTest class
	instanceVariableNames: ''!

!classDefinition: #BlockNodeTest category: #'Cuis-University-Tests' stamp: 'HAW 10/29/2019 17:56:07'!
ParseNodeTest subclass: #BlockNodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuis-University-Tests'!
!classDefinition: 'BlockNodeTest class' category: #'Cuis-University-Tests' stamp: 'HAW 10/29/2019 17:56:07'!
BlockNodeTest class
	instanceVariableNames: ''!

!classDefinition: #MessageNodeTest category: #'Cuis-University-Tests' stamp: 'HAW 10/29/2019 17:56:07'!
ParseNodeTest subclass: #MessageNodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuis-University-Tests'!
!classDefinition: 'MessageNodeTest class' category: #'Cuis-University-Tests' stamp: 'HAW 10/29/2019 17:56:07'!
MessageNodeTest class
	instanceVariableNames: ''!

!classDefinition: #VariableNodeTest category: #'Cuis-University-Tests' stamp: 'HAW 10/29/2019 17:56:07'!
ParseNodeTest subclass: #VariableNodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuis-University-Tests'!
!classDefinition: 'VariableNodeTest class' category: #'Cuis-University-Tests' stamp: 'HAW 10/29/2019 17:56:07'!
VariableNodeTest class
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
