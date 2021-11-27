'From Cuis 5.0 [latest update: #4972] on 27 November 2021 at 11:39:13 am'!
'Description Tests for parameters starting with ''un'' and ''una'''!
!provides: 'Cuis-University-Tests' 1 5!
!requires: 'Cuis-University-Model' 1 0 nil!
SystemOrganization addCategory: 'Cuis-University-Tests'!


!classDefinition: #ParseNodeTest category: 'Cuis-University-Tests'!
TestCase subclass: #ParseNodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuis-University-Tests'!
!classDefinition: 'ParseNodeTest class' category: 'Cuis-University-Tests'!
ParseNodeTest class
	instanceVariableNames: ''!

!classDefinition: #BlockNodeTest category: 'Cuis-University-Tests'!
ParseNodeTest subclass: #BlockNodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuis-University-Tests'!
!classDefinition: 'BlockNodeTest class' category: 'Cuis-University-Tests'!
BlockNodeTest class
	instanceVariableNames: ''!

!classDefinition: #MessageNodeTest category: 'Cuis-University-Tests'!
ParseNodeTest subclass: #MessageNodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuis-University-Tests'!
!classDefinition: 'MessageNodeTest class' category: 'Cuis-University-Tests'!
MessageNodeTest class
	instanceVariableNames: ''!

!classDefinition: #VariableNodeTest category: 'Cuis-University-Tests'!
ParseNodeTest subclass: #VariableNodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuis-University-Tests'!
!classDefinition: 'VariableNodeTest class' category: 'Cuis-University-Tests'!
VariableNodeTest class
	instanceVariableNames: ''!

!classDefinition: #StringCuisUniversityExtentionsTest category: 'Cuis-University-Tests'!
TestCase subclass: #StringCuisUniversityExtentionsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Cuis-University-Tests'!
!classDefinition: 'StringCuisUniversityExtentionsTest class' category: 'Cuis-University-Tests'!
StringCuisUniversityExtentionsTest class
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
