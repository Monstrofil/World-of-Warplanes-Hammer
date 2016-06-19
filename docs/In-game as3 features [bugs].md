### AS3 XML LOADING
In-game as3 has strange behavior while loading XML-like files. It converts such code:
	
```xml
<position value="absolute"/>
```
...into:
	
```xml
<position>
	<value>absolute</value>
</position>
```

In order to avoid it, each file in modification starts with line that makes xml malformed.