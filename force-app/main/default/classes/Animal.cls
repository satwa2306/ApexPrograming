public virtual class Animal {
    
    public Animal(string nm){
        System.debug('Parent Constructor.');
        this.name = nm;
    }
    
    public string name;
	public integer legs = 4;
    public boolean tail = true;
    public integer eyes = 2;
    
    // Polymorphism
    // Compile Time	: Method Overloading	- methods having same name but parameters are different wihin the same class.
    // Run Time		: Method Overriding		- methods having same name, can have same parameters but within inherited class.
    
    public virtual void walk(){
        System.debug(name + ' is walking.');
    }
    
    public void  walk(string s){
        System.debug(s + ' is walking ...!!!');
    }
    
    public virtual void talk(){
        system.debug(name + ' is talking.');
    }
}