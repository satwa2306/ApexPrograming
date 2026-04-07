public class Dog extends Animal{
    
    public Dog(String n){
        // Animal();
        super(n);
        System.debug('Child Constructor.');
    }
    
    public override void walk(){
        System.debug('Talk method from Dog class.');
    }
    
    public void walk(integer i){
        System.debug('Integer value - ' + i);
    }
}