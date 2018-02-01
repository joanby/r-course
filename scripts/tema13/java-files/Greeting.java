public class Greeting {
	
	
	String greeting = "Hello World";
	
	public String getString(String name){
		if (name != null && !name.equals("")){
			greeting = "Hello "+name;
		} else {
			greeting = "Hello there!";
		}
		return greeting;
	}
	
	public String toString(){
		return greeting;
	}
	
}